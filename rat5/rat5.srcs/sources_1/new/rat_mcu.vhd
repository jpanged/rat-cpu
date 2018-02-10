----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/07/2018 03:09:26 PM
-- Design Name: 
-- Module Name: rat_mcu - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity rat_mcu is
    Port ( in_port : in STD_LOGIC_VECTOR (7 downto 0);
           reset : in STD_LOGIC;
           int : in STD_LOGIC;
           clk_mcu : in STD_LOGIC;
           
           out_port : out STD_LOGIC_VECTOR (7 downto 0);
           port_id : out STD_LOGIC_VECTOR (7 downto 0);
           io_strb_mcu : out STD_LOGIC);
end rat_mcu;

architecture Behavioral of rat_mcu is

    component control_unit 
        port (c_flag: in STD_LOGIC;
               z_flag: in STD_LOGIC;
               int: in STD_LOGIC;
               reset : in STD_LOGIC;
               opcode_hi_5 : in STD_LOGIC_VECTOR(4 downto 0);
               opcode_lo_2: in STD_LOGIC_VECTOR(1 downto 0);
               clk: in STD_LOGIC;
               
               i_set: out STD_LOGIC;
               i_clr: out STD_LOGIC;
               
               pc_ld: out STD_LOGIC;
               pc_inc: out STD_LOGIC;
               pc_mux_sel: out STD_LOGIC_VECTOR(1 downto 0);
               
               alu_opy_sel: out STD_LOGIC;
               alu_sel: out STD_LOGIC_VECTOR(3 downto 0);
               
               rf_wr: out STD_LOGIC;
               rf_wr_sel: out STD_LOGIC_VECTOR(1 downto 0);
               
               sp_ld: out STD_LOGIC;
               sp_incr: out STD_LOGIC;
               sp_decr: out STD_LOGIC;
               
               scr_we: out STD_LOGIC;
               scr_addr_sel: out STD_LOGIC_VECTOR(1 downto 0);
               scr_data_sel: out STD_LOGIC;
               
               flg_c_set: out STD_LOGIC;
               flg_c_clr: out STD_LOGIC;
               flg_c_ld: out STD_LOGIC;
               flg_z_ld: out STD_LOGIC;
               flg_ld_sel: out STD_LOGIC;
               flg_shad_ld: out STD_LOGIC;
               
               rst: out STD_LOGIC; --control unit reset output
               io_strb: out STD_LOGIC);
    end component;
    
    component pc_wrapper
        port (FROM_IMMED : in STD_LOGIC_VECTOR (9 downto 0); -- input to mux_4t1
              FROM_STACK : in STD_LOGIC_VECTOR (9 downto 0); -- input to mux_4t1
              PC_MUX_SEL : in STD_LOGIC_VECTOR (1 downto 0); -- input to mux_4t1
              PC_LD      : in STD_LOGIC; -- input to PC
              PC_INC     : in STD_LOGIC; -- input to PC
              RST        : in STD_LOGIC; -- input to PC
              CLK        : in STD_LOGIC; -- input to PC
              PC_COUNT   : out STD_LOGIC_VECTOR (9 downto 0));
    end component;
   
    component prog_rom 
        port (ADDRESS : in std_logic_vector(9 downto 0); 
             INSTRUCTION : out std_logic_vector(17 downto 0); 
                     CLK : in std_logic); 
    end component;
    
    component rat_alu
        port (a : in STD_LOGIC_VECTOR (7 downto 0);
              b : in STD_LOGIC_VECTOR (7 downto 0);
              c_in : in STD_LOGIC;
              sel : in STD_LOGIC_VECTOR (3 downto 0);
              sum : out STD_LOGIC_VECTOR (7 downto 0);
              c_flag : out STD_LOGIC;
              z_flag : out STD_LOGIC);
    end component;
    
    component REG_FILE
        port (RF_WR_DATA : in STD_LOGIC_VECTOR (7 downto 0);
              ADRX : in STD_LOGIC_VECTOR (4 downto 0);
              ADRY : in STD_LOGIC_VECTOR (4 downto 0);
              RF_WR : in STD_LOGIC;
              DX_OUT : out STD_LOGIC_VECTOR (7 downto 0);
              DY_OUT : out STD_LOGIC_VECTOR (7 downto 0);
              CLK : in STD_LOGIC);
    end component;
   -- intermediate signal go here--
    signal instruction_temp : std_logic_vector (17 downto 0);
    signal pc_count_temp, from_immed_temp, from_stack_temp : std_logic_vector (9 downto 0);
    signal dx_out_temp, dy_out_temp, rf_wr_data_temp, ir_alu_temp, alu_b_temp, sum_temp: std_logic_vector(7 downto 0);
    signal adrx_temp, adry_temp, opcode_hi_5_temp : std_logic_vector (4 downto 0);
    signal alu_sel_temp: std_logic_vector(3 downto 0);
    signal pc_mux_sel_temp, rf_wr_sel_temp, opcode_lo_2_temp : std_logic_vector (1 downto 0);
    signal rst_temp, pc_inc_temp, pc_ld_temp, rf_wr_temp, alu_opy_sel_temp : std_logic;
   
begin
    adrx_temp <= instruction_temp (12 downto 8);
    adry_temp <= instruction_temp (7 downto 3);
    ir_alu_temp <= instruction_temp (7 downto 0);
    from_immed_temp <= instruction_temp (12 downto 3);
    from_stack_temp <= "0000000000"; --will change when scr is implemented
    opcode_hi_5_temp <= instruction_temp(17 downto 13);
    opcode_lo_2_temp <= instruction_temp(1 downto 0);

-- port map components --
--    pc1: pc_wrapper 
--    port map (FROM_IMMED => from_immed_temp,
--              FROM_STACK =>  from_stack_temp,
--              PC_MUX_SEL => pc_mux_sel_temp,
--              PC_LD => pc_ld_temp,    
--              PC_INC => pc_inc_temp,     
--              RST => rst_temp,      
--              CLK => clk_mcu,        
--              PC_COUNT => pc_count_temp);

--    prog_rom1: prog_rom 
--    port map (ADDRESS => pc_count_temp,
--              INSTRUCTION => "from_immed_temp", -- needs (12 downto 3), also adrx_temp (12:8) and adry_temp (7:3)
--              CLK => clk_mcu);

--    reg_file1: reg_file 
--    port map (RF_WR_DATA => rf_wr_data_temp, --see below port mapping
--              ADRX => adrx_temp,
--              ADRY => adry_temp,
--              RF_WR => rf_wr_temp,
--              DX_OUT => dx_out_temp,
--              DY_OUT => dy_out_temp, -- needs attention for alu   
--              CLK => clk_mcu);

--    alu1: rat_alu 
--    port map (a => dx_out_temp,
--              b => alu_b_temp,
--              c_in =>, --take from flags
--              sel => alu_sel_temp,
--              sum => sum_temp, --result from alu
--              c_flag =>, -- send to flags
--              z_flag =>); --send to flags

--    cu1: control_unit 
--    port map (c_flag =>,
--               z_flag =>,
--               int =>,
--               reset => reset_mcu,
--               opcode_hi_5 => opcode_hi_5_temp,
--               opcode_lo_2 => opcode_lo_2_temp,
--               clk => clk_mcu,
               
--               i_set =>,
--               i_clr =>,
               
--               pc_ld => pc_ld_temp,
--               pc_inc => pc_inc_temp, 
--               pc_mux_sel => pc_mux_sel_temp,
               
--               alu_opy_sel => alu_opy_sel_temp,
--               alu_sel => alu_sel_temp,
               
--               rf_wr => rf_wr_temp,
--               rf_wr_sel => rf_wr_sel_temp,
               
--               sp_ld => '0',
--               sp_incr => '0',
--               sp_decr => '0',
               
--               scr_we => '0',
--               scr_addr_sel => "00",
--               scr_data_sel => "00,
               
--               flg_c_set =>,
--               flg_c_clr =>,
--               flg_c_ld =>,
--               flg_z_ld =>,
--               flg_ld_sel =>,
--               flg_shad_ld =>,
               
--               rst => rst_temp,
--               io_strb => io_strb_mcu); --look at iostrob output for big mcu component (resolves conflict)

--    mux_rf_alu: mux_2t1
--    port map(sel => alu_opy_sel_temp,
--             in1 => dy_out_temp,
--             in2 => ir_alu_temp,
--             f => alu_b_temp); 
--    mux_rf: mux_4to1
--    port map(sel => rf_wr_sel_temp,
--             in1 => sum_temp,
--             in2 => "00000000" , -- scratch ram data out
--             in3 => '0',
--             in4 => in_port,
--             d_out => rf_wr_data_temp); 
             
    out_port <= dx_out_temp;
    port_id <= ir_alu_temp; 

end Behavioral;

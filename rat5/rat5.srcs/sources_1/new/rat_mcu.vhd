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
           clk : in STD_LOGIC;
           
           out_port : out STD_LOGIC_VECTOR (7 downto 0);
           port_id : out STD_LOGIC_VECTOR (7 downto 0);
           io_strb : out STD_LOGIC);
end rat_mcu;

architecture Behavioral of rat_mcu is

    component control_unit 
        port (c_flag: in STD_LOGIC;
               z_flag: in STD_LOGIC;
               int: in STD_LOGIC;
               reset: in STD_LOGIC;
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
               
               rst: out STD_LOGIC;
               io_strb: out STD_LOGIC);
    end component;
    
    component pc
        port (d_in : in STD_LOGIC_VECTOR (9 downto 0);
              pc_ld : in STD_LOGIC;
              pc_inc : in STD_LOGIC;
              rst : in STD_LOGIC;
              clk : in STD_LOGIC;
              pc_count : out STD_LOGIC_VECTOR (9 downto 0));
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

begin

-- port map components --
--    pc1: pc 
--    port map (d_in =>,
--              pc_ld =>,
--              pc_inc =>,
--              rst =>,
--              clk  =>,
--              pc_count =>);

--    prog_rom1: prog_rom 
--    port map (ADDRESS =>,
--              INSTRUCTION =>,
--              CLK =>);

--    reg_file1: reg_file 
--    port map (RF_WR_DATA =>,
--              ADRX =>,
--              ADRY =>,
--              RF_WR =>,
--              DX_OUT =>,
--              DY_OUT =>,   
--              CLK =>);

--    alu1: rat_alu 
--    port map (a =>,
--              b =>,
--              c_in =>,
--              sel =>,
--              sum =>,
--              c_flag =>,   
--              z_flag =>);


end Behavioral;

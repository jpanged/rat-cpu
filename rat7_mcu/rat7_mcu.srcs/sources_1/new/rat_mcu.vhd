----------------------------------------------------------------------------------
-- Company: CPE 233 Winter 2018
-- Engineer: Russell Caletena, Josiah Pang, & Nathan Wang
--
-- Create Date: 02/07/2018 03:09:26 PM
-- Design Name:
-- Module Name: rat_mcu - Behavioral
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description: The MCU wrapper for the RAT CPU
--
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--Define inputs and outputs of rat_mcu
entity rat_mcu is
    Port ( in_port : in STD_LOGIC_VECTOR (7 downto 0);
           reset_mcu : in STD_LOGIC;
           int_mcu : in STD_LOGIC;
           clk_mcu : in STD_LOGIC;

           out_port : out STD_LOGIC_VECTOR (7 downto 0);
           port_id : out STD_LOGIC_VECTOR (7 downto 0);
           io_strb_mcu : out STD_LOGIC);
end rat_mcu;

architecture Behavioral of rat_mcu is
    -- Import rat mcu components
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

    component d_flip_flop
        Port ( load : in STD_LOGIC;
               set : in STD_LOGIC;
               clear : in STD_LOGIC;
               data : in STD_LOGIC;
               clk : in STD_LOGIC;
               flag : out STD_LOGIC);
    end component;

    component mux_2T1
        Port ( sel : in std_logic;
               in1 : in std_logic_vector (7 downto 0);
               in2 : in std_logic_vector (7 downto 0);
               f : out std_logic_vector (7 downto 0));
    end component;

    component mux_4to1
        Port ( sel  : in  std_logic_vector (1 downto 0);
               in1 : in  std_logic_vector (9 downto 0);
               in2 : in  std_logic_vector (9 downto 0);
               in3 : in  std_logic_vector (9 downto 0);
               in4 : in std_logic_vector (9 downto 0);
               d_out    : out std_logic_vector(9 downto 0));
    end component;

    component mux_rf
            Port ( sel  : in  std_logic_vector (1 downto 0);
                   in1 : in  std_logic_vector (7 downto 0);
                   in2 : in  std_logic_vector (7 downto 0);
                   in3 : in  std_logic_vector (7 downto 0);
                   in4 : in std_logic_vector (7 downto 0);
                   d_out    : out std_logic_vector(7 downto 0));
    end component;

    component scratch_ram
        Port ( data_in : in STD_LOGIC_VECTOR (9 downto 0);
               scr_addr : in STD_LOGIC_VECTOR (7 downto 0);
               scr_we : in STD_LOGIC;
               clk : in STD_LOGIC;
               data_out : out STD_LOGIC_VECTOR (9 downto 0));
    end component;

    component mux_2to1 is
        Port ( sel  : in  std_logic;
               in1 : in  std_logic_vector (7 downto 0);
               in2 : in  std_logic_vector (9 downto 0);
               d_out    : out std_logic_vector(9 downto 0));
    end component;

    component stack_pointer is
        Port ( rst : in STD_LOGIC;
               ld : in STD_LOGIC;
               incr : in STD_LOGIC;
               decr : in STD_LOGIC;
               data_in : in STD_LOGIC_VECTOR (7 downto 0);
               clk : in STD_LOGIC;
               data_out : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

   -- Define intermediate signals--
    signal instruction_temp : std_logic_vector (17 downto 0);
    signal pc_count_temp, from_immed_temp, from_stack_temp, scr_data_in_temp, scr_data_out : std_logic_vector (9 downto 0);
    signal dx_out_temp, dy_out_temp, rf_wr_data_temp, ir_7to0_temp, alu_b_temp, sum_temp, sp_data_out_temp, sp_data_out_dec1_temp, scr_addr_data_temp, scr_data_out_rf: std_logic_vector(7 downto 0);
    signal adrx_temp, adry_temp, opcode_hi_5_temp : std_logic_vector (4 downto 0);
    signal alu_sel_temp: std_logic_vector(3 downto 0);
    signal pc_mux_sel_temp, rf_wr_sel_temp, opcode_lo_2_temp, scr_addr_sel_temp : std_logic_vector (1 downto 0);
    signal rst_temp, pc_inc_temp, pc_ld_temp, rf_wr_temp, alu_opy_sel_temp : std_logic;
    signal flg_c_set_temp, flg_c_clr_temp, flg_c_ld_temp, flg_z_ld_temp, flg_z_ld_sel_temp, flg_shad_ld_temp : std_logic;
    signal c_flag_temp, z_flag_temp, alu_c_temp, alu_z_temp, i_set_temp, i_clr_temp, i_flag_temp, int_temp : std_logic;
    signal sp_ld_temp, sp_incr_temp, sp_decr_temp, scr_we_temp, scr_data_sel_temp: std_logic;

begin
    -- Assign values to signals --
    adrx_temp <= instruction_temp (12 downto 8);
    adry_temp <= instruction_temp (7 downto 3);
    ir_7to0_temp <= instruction_temp (7 downto 0);
    from_immed_temp <= instruction_temp (12 downto 3);
    opcode_hi_5_temp <= instruction_temp(17 downto 13);
    opcode_lo_2_temp <= instruction_temp(1 downto 0);
    int_temp <= i_flag_temp AND int_mcu;
    sp_data_out_dec1_temp <= sp_data_out_temp - "00000001"; -- Could fail miserably
    scr_data_out_rf <= scr_data_out (7 downto 0);
    from_stack_temp <= scr_data_out;

-- PROGRAM COUNTER
    -- Port map components --
    pc1: pc_wrapper
    port map (FROM_IMMED => from_immed_temp,
              FROM_STACK =>  from_stack_temp,
              PC_MUX_SEL => pc_mux_sel_temp,
              PC_LD => pc_ld_temp,
              PC_INC => pc_inc_temp,
              RST => rst_temp,
              CLK => clk_mcu,
              PC_COUNT => pc_count_temp);

-- PROG ROM
    prog_rom1: prog_rom
    port map (ADDRESS => pc_count_temp,
              INSTRUCTION => instruction_temp,
              CLK => clk_mcu);

-- REGISTER FILE
    reg_file1: reg_file
    port map (RF_WR_DATA => rf_wr_data_temp,
              ADRX => adrx_temp,
              ADRY => adry_temp,
              RF_WR => rf_wr_temp,
              DX_OUT => dx_out_temp,
              DY_OUT => dy_out_temp,
              CLK => clk_mcu);
    mux_rf1: mux_rf
              port map(sel => rf_wr_sel_temp,
                       in1 => sum_temp,
                       in2 => scr_data_out_rf,
                       in3 => sp_data_out_temp,
                       in4 => in_port,
                       d_out => rf_wr_data_temp);

-- ALU
    alu1: rat_alu
    port map (a => dx_out_temp,
              b => alu_b_temp,
              c_in => c_flag_temp,
              sel => alu_sel_temp,
              sum => sum_temp,
              c_flag => alu_c_temp,
              z_flag => alu_z_temp);
    mux_rf_alu: mux_2t1
              port map(sel => alu_opy_sel_temp,
                       in1 => dy_out_temp,
                       in2 => ir_7to0_temp,
                       f => alu_b_temp);

-- CONTROL UNIT
    cu1: control_unit
    port map (c_flag => c_flag_temp,
               z_flag => z_flag_temp,
               int => int_temp,
               reset => reset_mcu,
               opcode_hi_5 => opcode_hi_5_temp,
               opcode_lo_2 => opcode_lo_2_temp,
               clk => clk_mcu,

               i_set => i_set_temp,
               i_clr => i_clr_temp,

               pc_ld => pc_ld_temp,
               pc_inc => pc_inc_temp,
               pc_mux_sel => pc_mux_sel_temp,

               alu_opy_sel => alu_opy_sel_temp,
               alu_sel => alu_sel_temp,

               rf_wr => rf_wr_temp,
               rf_wr_sel => rf_wr_sel_temp,

               sp_ld => sp_ld_temp,
               sp_incr => sp_incr_temp,
               sp_decr => sp_decr_temp,

               scr_we => scr_we_temp,
               scr_addr_sel => scr_addr_sel_temp,
               scr_data_sel => scr_data_sel_temp,

               flg_c_set => flg_c_set_temp,
               flg_c_clr => flg_c_clr_temp,
               flg_c_ld => flg_c_ld_temp,
               flg_z_ld => flg_z_ld_temp,
               flg_ld_sel => flg_z_ld_sel_temp,
               flg_shad_ld => flg_shad_ld_temp,

               rst => rst_temp,
               io_strb => io_strb_mcu);
    -- Create flag modules--
    cf1: d_flip_flop
    port map ( load => flg_c_ld_temp,
               set => flg_c_set_temp,
               clear => flg_c_clr_temp,
               data => alu_c_temp,
               clk => clk_mcu,
               flag => c_flag_temp);

    zf1: d_flip_flop
    port map ( load => flg_z_ld_temp,
               set => '0',
               clear => '0',
               data => alu_z_temp,
               clk => clk_mcu,
               flag => z_flag_temp);

    if1: d_flip_flop
    port map ( load => '0',
               set => i_set_temp,
               clear => i_clr_temp,
               data => '0',
               clk => clk_mcu,
               flag => i_flag_temp);
    --create additional muxes--

-- SCRATCH RAM
    scr_ram1: scratch_ram
    port map   (data_in => scr_data_in_temp,
                scr_addr => scr_addr_data_temp,
                scr_we => scr_we_temp,
                clk => clk_mcu,
                data_out => scr_data_out);

    mux_scr_addr: mux_rf
    port map(sel => scr_addr_sel_temp,
             in1 => dy_out_temp,
             in2 => ir_7to0_temp,
             in3 => sp_data_out_temp,
             in4 => sp_data_out_dec1_temp,
             d_out => scr_addr_data_temp);

     mux_scr_data_in: mux_2to1
     port map ( sel => scr_data_sel_temp,
                in1 => dx_out_temp,
                in2 => pc_count_temp,
                d_out => scr_data_in_temp);

-- STACK POINTER
    sp: stack_pointer
        port map ( rst => rst_temp,
                   ld => sp_ld_temp,
                   incr => sp_incr_temp,
                   decr => sp_decr_temp,
                   data_in => dx_out_temp,
                   clk => clk_mcu,
                   data_out => sp_data_out_temp);

    -- Take care of port_ and out_port signals
    out_port <= dx_out_temp;
    port_id <= ir_7to0_temp;

end Behavioral;

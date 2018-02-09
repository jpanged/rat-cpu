----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/09/2018 12:07:20 AM
-- Design Name: 
-- Module Name: control_unit - Behavioral
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

entity control_unit is
    Port ( c_flag: in STD_LOGIC;
           z_flag: in STD_LOGIC;
           int: in STD_LOGIC;
           reset: in STD_LOGIC;
           opcode_hi_5 : in STD_LOGIC_VECTOR(4 downto 0);
           opcode_lo_2: in STD_LOGIC_VECTOR(2 downto 0);
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
           
end control_unit;

architecture Behavioral of control_unit is
--    ------------------Default Block------------------
--    --signal i_set: STD_LOGIC;
    
--    i_set <= '0';
--    i_clr <= '0';
    
--    pc_ld <= '0';
--    pc_inc <= '0';
--    pc_mux_sel <= "00";
    
--    alu_opy_sel <= '0';
--    alu_sel <= "0000";
    
--    rf_wr <= '0';
--    rf_wr_sel <= "00";
    
--    sp_ld <= '0';
--    sp_incr <= '0';
--    sp_decr <= '0';
    
--    scr_we <= '0';
--    scr_addr_sel <= "00";
--    scr_data_sel <= '0';
    
--    flg_c_set <= '0';
--    flg_c_clr <= '0';
--    flg_c_ld <= '0';
--    flg_z_ld <= '0';
--    flg_ld_sel <= '0';
--    flg_shad_ld <= '0';
    
--    rst <= '0';
--    io_strb <= '0';
--    ------------------Default Block------------------
    type state_type is (st_int, st_fetch, st_execute, st_interrupt);
    signal ps, ns: state_type;
    signal sig_opcode_7: STD_LOGIC_VECTOR(6 downto 0);
    
    sig_opcode_7 <= opcode_hi_5 & opcode_lo_2;
    
    sync_process : process (clk, ns, ps, rst)
    begin
        if (rst = '1') then
            ps <= st_int;
        elsif (rising_edge(clk)) then
            ps <= ns;
        end if;
    end process;

begin

end Behavioral;

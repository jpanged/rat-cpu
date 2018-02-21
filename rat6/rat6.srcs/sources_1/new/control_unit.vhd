----------------------------------------------------------------------------------
-- Company:
-- Engineers: Russell Caletena, Josiah Pang, Nathan Wang
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

--create the inputs and outputs of the control unit
entity control_unit is
    Port ( c_flag: in STD_LOGIC;
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

end control_unit;

architecture Behavioral of control_unit is
    -- create state types and signals for FSM
    type state_type is (st_int, st_fetch, st_execute, st_interrupt);
    signal ps, ns: state_type;
    signal sig_opcode_7: STD_LOGIC_VECTOR(6 downto 0);

begin
    -- create opcode
    sig_opcode_7 <= opcode_hi_5 & opcode_lo_2;

    -- present and next state logic
    sync_process : process (clk, ns, reset)
    begin
        if (reset = '1') then
            ps <= st_int;
        elsif (rising_edge(clk)) then
            ps <= ns;
        end if;
    end process;

    --
    comb_process: process (ns, ps, reset, sig_opcode_7)
    begin
        -- insert default block here --
        --start default block--
        i_set <= '0';
        i_clr <= '0';

        pc_ld <= '0';
        pc_inc <= '0';
        pc_mux_sel <= "00";

        alu_opy_sel <= '0';
        alu_sel <= "0000";

        rf_wr <= '0';
        rf_wr_sel <= "00";

        sp_ld <= '0';
        sp_incr <= '0';
        sp_decr <= '0';

        scr_we <= '0';
        scr_addr_sel <= "00";
        scr_data_sel <= '0';

        flg_c_set <= '0';
        flg_c_clr <= '0';
        flg_c_ld <= '0';
        flg_z_ld <= '0';
        flg_ld_sel <= '0';
        flg_shad_ld <= '0';

        rst <= '0';
        io_strb <= '0';
        --end default block--

        case ps is
            when st_int =>
                ns <= st_fetch;
                rst <= '1'; -- accounts for pc_rst and sp_rst (all the same signal coming from output rst signal of control unit)
            when st_fetch =>
                ns <= st_execute;
                pc_inc <= '1';
            when st_execute =>
                ns <= st_fetch;
                --insert default block here--
                --start default block--
                    pc_ld <= '0';
                    pc_inc <= '0';
                    pc_mux_sel <= "00";

                    rf_wr <= '0';
                    rf_wr_sel <= "00";

                    alu_sel <= "0000";
                    alu_opy_sel <= '0';

                    scr_data_sel <= '0';
                    scr_we <= '0';
                    scr_addr_sel <= "00";

                    sp_ld <= '0';
                    sp_incr <= '0';
                    sp_decr <= '0';

                    flg_c_ld <= '0';
                    flg_c_set <= '0';
                    flg_c_clr <= '0';

                    flg_z_ld <= '0';

                    i_clr <= '0';
                    i_set <= '0';
                    flg_ld_sel <= '0';
                    flg_shad_ld <= '0';

                    rst <= '0';
                --end default block--
                        pc_inc <= '0';

                -- Sets correct signals for RAT Control Unit
                case sig_opcode_7 is

                    when "00001" => -- add reg-reg opcode
                        pc_ld <= '0';
                        pc_inc <= '0';
                        pc_mux_sel <= "00";

                        rf_wr <= '1';
                        rf_wr_sel <= "00";

                        alu_sel <= "0000";
                        alu_opy_sel <= '0';

                        scr_data_sel <= '0';
                        scr_we <= '0';
                        scr_addr_sel <= "00";

                        sp_ld <= '0';
                        sp_incr <= '0';
                        sp_decr <= '0';

                        flg_c_ld <= '1';
                        flg_c_set <= '0';
                        flg_c_clr <= '0';

                        flg_z_ld <= '1';

                        i_clr <= '0';
                        i_set <= '0';
                        flg_ld_sel <= '0';
                        flg_shad_ld <= '0';

                        rst <= '0';

                    when "1010000" |  "1010001" | "1010010" | "1010011" => -- add reg-immed opcode
                        pc_ld <= '0';
                        pc_inc <= '0';
                        pc_mux_sel <= "00";

                        rf_wr <= '1';
                        rf_wr_sel <= "00";

                        alu_sel <= "0000";
                        alu_opy_sel <= '1';

                        scr_data_sel <= '0';
                        scr_we <= '0';
                        scr_addr_sel <= "00";

                        sp_ld <= '0';
                        sp_incr <= '0';
                        sp_decr <= '0';

                        flg_c_ld <= '1';
                        flg_c_set <= '0';
                        flg_c_clr <= '0';

                        flg_z_ld <= '1';

                        i_clr <= '0';
                        i_set <= '0';
                        flg_ld_sel <= '0';
                        flg_shad_ld <= '0';

                        rst <= '0';

                    when "00001" => -- addc reg-reg opcode
                        pc_ld <= '0';
                        pc_inc <= '0';
                        pc_mux_sel <= "00";

                        rf_wr <= '1';
                        rf_wr_sel <= "00";

                        alu_sel <= "0001";
                        alu_opy_sel <= '0';

                        scr_data_sel <= '0';
                        scr_we <= '0';
                        scr_addr_sel <= "00";

                        sp_ld <= '0';
                        sp_incr <= '0';
                        sp_decr <= '0';

                        flg_c_ld <= '1';
                        flg_c_set <= '0';
                        flg_c_clr <= '0';

                        flg_z_ld <= '1';

                        i_clr <= '0';
                        i_set <= '0';
                        flg_ld_sel <= '0';
                        flg_shad_ld <= '0';

                        rst <= '0';

                    when "1010100" | "1010101" | "1010110" | "1010111"  => -- addc reg-immed opcode
                        pc_ld <= '0';
                        pc_inc <= '0';
                        pc_mux_sel <= "00";

                        rf_wr <= '1';
                        rf_wr_sel <= "00";

                        alu_sel <= "0001";
                        alu_opy_sel <= '1';

                        scr_data_sel <= '0';
                        scr_we <= '0';
                        scr_addr_sel <= "00";

                        sp_ld <= '0';
                        sp_incr <= '0';
                        sp_decr <= '0';

                        flg_c_ld <= '1';
                        flg_c_set <= '0';
                        flg_c_clr <= '0';

                        flg_z_ld <= '1';

                        i_clr <= '0';
                        i_set <= '0';
                        flg_ld_sel <= '0';
                        flg_shad_ld <= '0';

                        rst <= '0';

                    when "00000" => -- and opcode
                        pc_ld <= '0';
                        pc_inc <= '0';
                        pc_mux_sel <= "00";

                        rf_wr <= '1';
                        rf_wr_sel <= "00";

                        alu_sel <= "0101";
                        alu_opy_sel <= '0';

                        scr_data_sel <= '0';
                        scr_we <= '0';
                        scr_addr_sel <= "00";

                        sp_ld <= '0';
                        sp_incr <= '0';
                        sp_decr <= '0';

                        flg_c_ld <= '1';
                        flg_c_set <= '0';
                        flg_c_clr <= '1';

                        flg_z_ld <= '1';

                        i_clr <= '0';
                        i_set <= '0';
                        flg_ld_sel <= '0';
                        flg_shad_ld <= '0';

                        rst <= '0';

                    when "1000000" | "1000001" | "1000010" | "1000011" => -- and reg-immed opcode
                        pc_ld <= '0';
                        pc_inc <= '0';
                        pc_mux_sel <= "00";

                        rf_wr <= '1';
                        rf_wr_sel <= "00";

                        alu_sel <= "0101";
                        alu_opy_sel <= '1';

                        scr_data_sel <= '0';
                        scr_we <= '0';
                        scr_addr_sel <= "00";

                        sp_ld <= '0';
                        sp_incr <= '0';
                        sp_decr <= '0';

                        flg_c_ld <= '1';
                        flg_c_set <= '0';
                        flg_c_clr <= '1';

                        flg_z_ld <= '1';

                        i_clr <= '0';
                        i_set <= '0';
                        flg_ld_sel <= '0';
                        flg_shad_ld <= '0';

                        rst <= '0';

                    when "01001" => -- asr opcode
                        pc_ld <= '0';
                        pc_inc <= '0';
                        pc_mux_sel <= "00";

                        rf_wr <= '1';
                        rf_wr_sel <= "00";

                        alu_sel <= "1101";
                        alu_opy_sel <= '0';

                        scr_data_sel <= '0';
                        scr_we <= '0';
                        scr_addr_sel <= "00";

                        sp_ld <= '0';
                        sp_incr <= '0';
                        sp_decr <= '0';

                        flg_c_ld <= '1';
                        flg_c_set <= '0';
                        flg_c_clr <= '0';

                        flg_z_ld <= '1';

                        i_clr <= '0';
                        i_set <= '0';
                        flg_ld_sel <= '0';
                        flg_shad_ld <= '0';

                        rst <= '0';

                    when "00101" => -- brcc opcode
                        pc_ld <= '1';
                        pc_inc <= '0';
                        pc_mux_sel <= "00";

                        rf_wr <= '0';
                        rf_wr_sel <= "00";

                        alu_sel <= "0000";
                        alu_opy_sel <= '0';

                        scr_data_sel <= '0';
                        scr_we <= '0';
                        scr_addr_sel <= "00";

                        sp_ld <= '0';
                        sp_incr <= '0';
                        sp_decr <= '0';

                        flg_c_ld <= '0';
                        flg_c_set <= '0';
                        flg_c_clr <= '0';

                        flg_z_ld <= '0';

                        i_clr <= '0';
                        i_set <= '0';
                        flg_ld_sel <= '0';
                        flg_shad_ld <= '0';

                        rst <= '0';

                    when "00101" => -- brcs opcode
                        pc_ld <= '1';
                        pc_inc <= '0';
                        pc_mux_sel <= "00";

                        rf_wr <= '0';
                        rf_wr_sel <= "00";

                        alu_sel <= "0000";
                        alu_opy_sel <= '0';

                        scr_data_sel <= '0';
                        scr_we <= '0';
                        scr_addr_sel <= "00";

                        sp_ld <= '0';
                        sp_incr <= '0';
                        sp_decr <= '0';

                        flg_c_ld <= '0';
                        flg_c_set <= '0';
                        flg_c_clr <= '0';

                        flg_z_ld <= '0';

                        i_clr <= '0';
                        i_set <= '0';
                        flg_ld_sel <= '0';
                        flg_shad_ld <= '0';

                        rst <= '0';

                    when "00100" => -- breq opcode
                        pc_ld <= '1';
                        pc_inc <= '0';
                        pc_mux_sel <= "00";

                        rf_wr <= '0';
                        rf_wr_sel <= "00";

                        alu_sel <= "0000";
                        alu_opy_sel <= '0';

                        scr_data_sel <= '0';
                        scr_we <= '0';
                        scr_addr_sel <= "00";

                        sp_ld <= '0';
                        sp_incr <= '0';
                        sp_decr <= '0';

                        flg_c_ld <= '0';
                        flg_c_set <= '0';
                        flg_c_clr <= '0';

                        flg_z_ld <= '0';

                        i_clr <= '0';
                        i_set <= '0';
                        flg_ld_sel <= '0';
                        flg_shad_ld <= '0';

                        rst <= '0';

                    when "0010000" => -- brn opcode
                        pc_ld <= '1';
                        pc_inc <= '0';
                        pc_mux_sel <= "00";

                        rf_wr <= '0';
                        rf_wr_sel <= "00";

                        alu_sel <= "0000";
                        alu_opy_sel <= '0';

                        scr_data_sel <= '0';
                        scr_we <= '0';
                        scr_addr_sel <= "00";

                        sp_ld <= '0';
                        sp_incr <= '0';
                        sp_decr <= '0';

                        flg_c_ld <= '0';
                        flg_c_set <= '0';
                        flg_c_clr <= '0';

                        flg_z_ld <= '0';

                        i_clr <= '0';
                        i_set <= '0';
                        flg_ld_sel <= '0';
                        flg_shad_ld <= '0';

                        rst <= '0';

                    when "00100" => -- brne opcode
                        pc_ld <= '1';
                        pc_inc <= '0';
                        pc_mux_sel <= "00";

                        rf_wr <= '0';
                        rf_wr_sel <= "00";

                        alu_sel <= "0000";
                        alu_opy_sel <= '0';

                        scr_data_sel <= '0';
                        scr_we <= '0';
                        scr_addr_sel <= "00";

                        sp_ld <= '0';
                        sp_incr <= '0';
                        sp_decr <= '0';

                        flg_c_ld <= '0';
                        flg_c_set <= '0';
                        flg_c_clr <= '0';

                        flg_z_ld <= '0';

                        i_clr <= '0';
                        i_set <= '0';
                        flg_ld_sel <= '0';
                        flg_shad_ld <= '0';

                        rst <= '0';

                    when "01100" => -- clc opcode
                        pc_ld <= '0';
                        pc_inc <= '0';
                        pc_mux_sel <= "00";

                        rf_wr <= '0';
                        rf_wr_sel <= "00";

                        alu_sel <= "0000";
                        alu_opy_sel <= '0';

                        scr_data_sel <= '0';
                        scr_we <= '0';
                        scr_addr_sel <= "00";

                        sp_ld <= '0';
                        sp_incr <= '0';
                        sp_decr <= '0';

                        flg_c_ld <= '0';
                        flg_c_set <= '0';
                        flg_c_clr <= '1';

                        flg_z_ld <= '0';

                        i_clr <= '0';
                        i_set <= '0';
                        flg_ld_sel <= '0';
                        flg_shad_ld <= '0';

                        rst <= '0';

                    when "01101" => -- cli opcode
                        pc_ld <= '0';
                        pc_inc <= '0';
                        pc_mux_sel <= "00";

                        rf_wr <= '0';
                        rf_wr_sel <= "00";

                        alu_sel <= "0000";
                        alu_opy_sel <= '0';

                        scr_data_sel <= '0';
                        scr_we <= '0';
                        scr_addr_sel <= "00";

                        sp_ld <= '0';
                        sp_incr <= '0';
                        sp_decr <= '0';

                        flg_c_ld <= '0';
                        flg_c_set <= '0';
                        flg_c_clr <= '0';

                        flg_z_ld <= '0';

                        i_clr <= '1';
                        i_set <= '0';
                        flg_ld_sel <= '0';
                        flg_shad_ld <= '0';

                        rst <= '0';

                    when "00010" => -- cmp reg-reg opcode
                        pc_ld <= '0';
                        pc_inc <= '0';
                        pc_mux_sel <= "00";

                        rf_wr <= '0';
                        rf_wr_sel <= "00";

                        alu_sel <= "0100";
                        alu_opy_sel <= '0';

                        scr_data_sel <= '0';
                        scr_we <= '0';
                        scr_addr_sel <= "00";

                        sp_ld <= '0';
                        sp_incr <= '0';
                        sp_decr <= '0';

                        flg_c_ld <= '1';
                        flg_c_set <= '0';
                        flg_c_clr <= '0';

                        flg_z_ld <= '1';

                        i_clr <= '0';
                        i_set <= '0';
                        flg_ld_sel <= '0';
                        flg_shad_ld <= '0';

                        rst <= '0';

                    when "11000" => -- cmp reg-immed opcode
                        pc_ld <= '0';
                        pc_inc <= '0';
                        pc_mux_sel <= "00";

                        rf_wr <= '0';
                        rf_wr_sel <= "00";

                        alu_sel <= "0100";
                        alu_opy_sel <= '1';

                        scr_data_sel <= '0';
                        scr_we <= '0';
                        scr_addr_sel <= "00";

                        sp_ld <= '0';
                        sp_incr <= '0';
                        sp_decr <= '0';

                        flg_c_ld <= '1';
                        flg_c_set <= '0';
                        flg_c_clr <= '0';

                        flg_z_ld <= '1';

                        i_clr <= '0';
                        i_set <= '0';
                        flg_ld_sel <= '0';
                        flg_shad_ld <= '0';

                        rst <= '0';

                    when "0000010" => -- exor opcode reg-reg
                        pc_ld <= '0';
                        pc_inc <= '0';
                        pc_mux_sel <= "00";

                        rf_wr <= '1';
                        rf_wr_sel <= "00";

                        alu_sel <= "0111";
                        alu_opy_sel <= '0';

                        scr_data_sel <= '0';
                        scr_we <= '0';
                        scr_addr_sel <= "00";

                        sp_ld <= '0';
                        sp_incr <= '0';
                        sp_decr <= '0';

                        flg_c_ld <= '0';
                        flg_c_set <= '0';
                        flg_c_clr <= '1';

                        flg_z_ld <= '1';

                        i_clr <= '0';
                        i_set <= '0';
                        flg_ld_sel <= '0';
                        flg_shad_ld <= '0';

                        rst <= '0';

                   when "1001000" | "1001001" | "1001010" | "1001011" => -- exor opcode reg-immed with low2 bit cases taken care of
                        pc_ld <= '0';
                        pc_inc <= '0';
                        pc_mux_sel <= "00";

                        rf_wr <= '1';
                        rf_wr_sel <= "00";

                        alu_sel <= "0111";
                        alu_opy_sel <= '1';

                        scr_data_sel <= '0';
                        scr_we <= '0';
                        scr_addr_sel <= "00";

                        sp_ld <= '0';
                        sp_incr <= '0';
                        sp_decr <= '0';

                        flg_c_ld <= '0';
                        flg_c_set <= '0';
                        flg_c_clr <= '1';

                        flg_z_ld <= '1';

                        i_clr <= '0';
                        i_set <= '0';
                        flg_ld_sel <= '0';
                        flg_shad_ld <= '0';

                        rst <= '0';

                    when "1100100" | "1100101" | "1100110" | "1100111" => -- in opcode with low2 bit cases taken care of
                        pc_ld <= '0';
                        pc_inc <= '0';
                        pc_mux_sel <= "00";

                        rf_wr <= '1';
                        rf_wr_sel <= "11";

                        alu_sel <= "0000";
                        alu_opy_sel <= '0';

                        scr_data_sel <= '0';
                        scr_we <= '0';
                        scr_addr_sel <= "00";

                        sp_ld <= '0';
                        sp_incr <= '0';
                        sp_decr <= '0';

                        flg_c_ld <= '0';
                        flg_c_set <= '0';
                        flg_c_clr <= '0';

                        flg_z_ld <= '0';

                        i_clr <= '0';
                        i_set <= '0';
                        flg_ld_sel <= '0';
                        flg_shad_ld <= '0';

                        rst <= '0';

                    when "00010" => -- ld reg-reg opcode
                        pc_ld <= '0';
                        pc_inc <= '0';
                        pc_mux_sel <= "00";

                        rf_wr <= '1';
                        rf_wr_sel <= "01";

                        alu_sel <= "0000";
                        alu_opy_sel <= '0';

                        scr_data_sel <= '0';
                        scr_we <= '0';
                        scr_addr_sel <= "00";

                        sp_ld <= '0';
                        sp_incr <= '0';
                        sp_decr <= '0';

                        flg_c_ld <= '0';
                        flg_c_set <= '0';
                        flg_c_clr <= '0';

                        flg_z_ld <= '0';

                        i_clr <= '0';
                        i_set <= '0';
                        flg_ld_sel <= '0';
                        flg_shad_ld <= '0';

                        rst <= '0';

                    when "11100" => -- ld reg-immed opcode
                        pc_ld <= '0';
                        pc_inc <= '0';
                        pc_mux_sel <= "00";

                        rf_wr <= '1';
                        rf_wr_sel <= "01";

                        alu_sel <= "0000";
                        alu_opy_sel <= '0';

                        scr_data_sel <= '0';
                        scr_we <= '0';
                        scr_addr_sel <= "01";

                        sp_ld <= '0';
                        sp_incr <= '0';
                        sp_decr <= '0';

                        flg_c_ld <= '0';
                        flg_c_set <= '0';
                        flg_c_clr <= '0';

                        flg_z_ld <= '0';

                        i_clr <= '0';
                        i_set <= '0';
                        flg_ld_sel <= '0';
                        flg_shad_ld <= '0';

                        rst <= '0';

                    when "01000" => -- lsl opcode
                        pc_ld <= '0';
                        pc_inc <= '0';
                        pc_mux_sel <= "00";

                        rf_wr <= '1';
                        rf_wr_sel <= "00";

                        alu_sel <= "1001";
                        alu_opy_sel <= '0';

                        scr_data_sel <= '0';
                        scr_we <= '0';
                        scr_addr_sel <= "00";

                        sp_ld <= '0';
                        sp_incr <= '0';
                        sp_decr <= '0';

                        flg_c_ld <= '1';
                        flg_c_set <= '0';
                        flg_c_clr <= '0';

                        flg_z_ld <= '1';

                        i_clr <= '0';
                        i_set <= '0';
                        flg_ld_sel <= '0';
                        flg_shad_ld <= '0';

                        rst <= '0';

                    when "00001" => -- lsr opcode
                        pc_ld <= '0';
                        pc_inc <= '0';
                        pc_mux_sel <= "00";

                        rf_wr <= '1';
                        rf_wr_sel <= "00";

                        alu_sel <= "1010";
                        alu_opy_sel <= '0';

                        scr_data_sel <= '0';
                        scr_we <= '0';
                        scr_addr_sel <= "00";

                        sp_ld <= '0';
                        sp_incr <= '0';
                        sp_decr <= '0';

                        flg_c_ld <= '1';
                        flg_c_set <= '0';
                        flg_c_clr <= '0';

                        flg_z_ld <= '1';

                        i_clr <= '0';
                        i_set <= '0';
                        flg_ld_sel <= '0';
                        flg_shad_ld <= '0';

                        rst <= '0';

                    when "0001001" => -- mov opcode reg- reg with low2 bit cases taken care of
                        pc_ld <= '0';
                        pc_inc <= '0';
                        pc_mux_sel <= "00";

                        rf_wr <= '1';
                        rf_wr_sel <= "00";

                        alu_sel <= "1110";
                        alu_opy_sel <= '0';

                        scr_data_sel <= '0';
                        scr_we <= '0';
                        scr_addr_sel <= "00";

                        sp_ld <= '0';
                        sp_incr <= '0';
                        sp_decr <= '0';

                        flg_c_ld <= '0';
                        flg_c_set <= '0';
                        flg_c_clr <= '0';

                        flg_z_ld <= '0';

                        i_clr <= '0';
                        i_set <= '0';
                        flg_ld_sel <= '0';
                        flg_shad_ld <= '0';

                        rst <= '0';

                    when "1101100" | "1101101" | "1101110" | "1101111" => -- mov opcode reg-immed with low2 bit cases taken care of
                        pc_ld <= '0';
                        pc_inc <= '0';
                        pc_mux_sel <= "00";

                        rf_wr <= '1';
                        rf_wr_sel <= "00";

                        alu_sel <= "1110";
                        alu_opy_sel <= '1';

                        scr_data_sel <= '0';
                        scr_we <= '0';
                        scr_addr_sel <= "00";

                        sp_ld <= '0';
                        sp_incr <= '0';
                        sp_decr <= '0';

                        flg_c_ld <= '0';
                        flg_c_set <= '0';
                        flg_c_clr <= '0';

                        flg_z_ld <= '0';

                        i_clr <= '0';
                        i_set <= '0';
                        flg_ld_sel <= '0';
                        flg_shad_ld <= '0';

                        rst <= '0';

                    when "00000" => -- or reg-reg opcode
                        pc_ld <= '0';
                        pc_inc <= '0';
                        pc_mux_sel <= "00";

                        rf_wr <= '1';
                        rf_wr_sel <= "00";

                        alu_sel <= "0110";
                        alu_opy_sel <= '0';

                        scr_data_sel <= '0';
                        scr_we <= '0';
                        scr_addr_sel <= "00";

                        sp_ld <= '0';
                        sp_incr <= '0';
                        sp_decr <= '0';

                        flg_c_ld <= '0';
                        flg_c_set <= '0';
                        flg_c_clr <= '1';

                        flg_z_ld <= '1';

                        i_clr <= '0';
                        i_set <= '0';
                        flg_ld_sel <= '0';
                        flg_shad_ld <= '0';

                        rst <= '0';

                    when "1000100" | "1000101" | "1000110" | "1000111" => -- or reg-immed opcode
                        pc_ld <= '0';
                        pc_inc <= '0';
                        pc_mux_sel <= "00";

                        rf_wr <= '1';
                        rf_wr_sel <= "00";

                        alu_sel <= "0110";
                        alu_opy_sel <= '1';

                        scr_data_sel <= '0';
                        scr_we <= '0';
                        scr_addr_sel <= "00";

                        sp_ld <= '0';
                        sp_incr <= '0';
                        sp_decr <= '0';

                        flg_c_ld <= '0';
                        flg_c_set <= '0';
                        flg_c_clr <= '1';

                        flg_z_ld <= '1';

                        i_clr <= '0';
                        i_set <= '0';
                        flg_ld_sel <= '0';
                        flg_shad_ld <= '0';

                        rst <= '0';



                    when "1101000" | "1101001" | "1101010" | "1101011" => -- out opcode with low2 bit cases taken care of
                        pc_ld <= '0';
                        pc_inc <= '0';
                        pc_mux_sel <= "00";

                        rf_wr <= '0';
                        rf_wr_sel <= "00";

                        alu_sel <= "0000";
                        alu_opy_sel <= '0';

                        scr_data_sel <= '0';
                        scr_we <= '0';
                        scr_addr_sel <= "00";

                        sp_ld <= '0';
                        sp_incr <= '0';
                        sp_decr <= '0';

                        flg_c_ld <= '0';
                        flg_c_set <= '0';
                        flg_c_clr <= '0';

                        flg_z_ld <= '0';

                        i_clr <= '0';
                        i_set <= '0';
                        flg_ld_sel <= '0';
                        flg_shad_ld <= '0';

                        rst <= '0';

                    when "00001" => -- rol opcode
                        pc_ld <= '0';
                        pc_inc <= '0';
                        pc_mux_sel <= "00";

                        rf_wr <= '1';
                        rf_wr_sel <= "00";

                        alu_sel <= "1011";
                        alu_opy_sel <= '0';

                        scr_data_sel <= '0';
                        scr_we <= '0';
                        scr_addr_sel <= "00";

                        sp_ld <= '0';
                        sp_incr <= '0';
                        sp_decr <= '0';

                        flg_c_ld <= '1';
                        flg_c_set <= '0';
                        flg_c_clr <= '0';

                        flg_z_ld <= '1';

                        i_clr <= '0';
                        i_set <= '0';
                        flg_ld_sel <= '0';
                        flg_shad_ld <= '0';

                        rst <= '0';

                    when "00001" => -- ror opcode
                        pc_ld <= '0';
                        pc_inc <= '0';
                        pc_mux_sel <= "00";

                        rf_wr <= '1';
                        rf_wr_sel <= "00";

                        alu_sel <= "1100";
                        alu_opy_sel <= '0';

                        scr_data_sel <= '0';
                        scr_we <= '0';
                        scr_addr_sel <= "00";

                        sp_ld <= '0';
                        sp_incr <= '0';
                        sp_decr <= '0';

                        flg_c_ld <= '1';
                        flg_c_set <= '0';
                        flg_c_clr <= '0';

                        flg_z_ld <= '1';

                        i_clr <= '0';
                        i_set <= '0';
                        flg_ld_sel <= '0';
                        flg_shad_ld <= '0';

                        rst <= '0';

                    when "00001" => -- sec opcode
                        pc_ld <= '0';
                        pc_inc <= '0';
                        pc_mux_sel <= "00";

                        rf_wr <= '0';
                        rf_wr_sel <= "00";

                        alu_sel <= "0000";
                        alu_opy_sel <= '0';

                        scr_data_sel <= '0';
                        scr_we <= '0';
                        scr_addr_sel <= "00";

                        sp_ld <= '0';
                        sp_incr <= '0';
                        sp_decr <= '0';

                        flg_c_ld <= '0';
                        flg_c_set <= '1';
                        flg_c_clr <= '0';

                        flg_z_ld <= '0';

                        i_clr <= '0';
                        i_set <= '0';
                        flg_ld_sel <= '0';
                        flg_shad_ld <= '0';

                        rst <= '0';

                    when "00001" => -- sei opcode
                        pc_ld <= '0';
                        pc_inc <= '0';
                        pc_mux_sel <= "00";

                        rf_wr <= '0';
                        rf_wr_sel <= "00";

                        alu_sel <= "0000";
                        alu_opy_sel <= '0';

                        scr_data_sel <= '0';
                        scr_we <= '0';
                        scr_addr_sel <= "00";

                        sp_ld <= '0';
                        sp_incr <= '0';
                        sp_decr <= '0';

                        flg_c_ld <= '0';
                        flg_c_set <= '0';
                        flg_c_clr <= '0';

                        flg_z_ld <= '0';

                        i_clr <= '0';
                        i_set <= '1';
                        flg_ld_sel <= '0';
                        flg_shad_ld <= '0';

                        rst <= '0';

                    when "00001" => -- st reg-reg opcode
                        pc_ld <= '0';
                        pc_inc <= '0';
                        pc_mux_sel <= "00";

                        rf_wr <= '0';
                        rf_wr_sel <= "01";

                        alu_sel <= "0000";
                        alu_opy_sel <= '0';

                        scr_data_sel <= '0';
                        scr_we <= '1';
                        scr_addr_sel <= "00";

                        sp_ld <= '0';
                        sp_incr <= '0';
                        sp_decr <= '0';

                        flg_c_ld <= '0';
                        flg_c_set <= '0';
                        flg_c_clr <= '0';

                        flg_z_ld <= '0';

                        i_clr <= '0';
                        i_set <= '0';
                        flg_ld_sel <= '0';
                        flg_shad_ld <= '0';

                        rst <= '0';

                    when "00001" => -- st reg-immed opcode
                        pc_ld <= '0';
                        pc_inc <= '0';
                        pc_mux_sel <= "00";

                        rf_wr <= '0';
                        rf_wr_sel <= "01";

                        alu_sel <= "0000";
                        alu_opy_sel <= '0';

                        scr_data_sel <= '0';
                        scr_we <= '1';
                        scr_addr_sel <= "01";

                        sp_ld <= '0';
                        sp_incr <= '0';
                        sp_decr <= '0';

                        flg_c_ld <= '0';
                        flg_c_set <= '0';
                        flg_c_clr <= '0';

                        flg_z_ld <= '0';

                        i_clr <= '0';
                        i_set <= '0';
                        flg_ld_sel <= '0';
                        flg_shad_ld <= '0';

                        rst <= '0';

                    when "00001" => -- sub reg-reg opcode
                        pc_ld <= '0';
                        pc_inc <= '0';
                        pc_mux_sel <= "00";

                        rf_wr <= '0';
                        rf_wr_sel <= "00";

                        alu_sel <= "0000";
                        alu_opy_sel <= '0';

                        scr_data_sel <= '0';
                        scr_we <= '0';
                        scr_addr_sel <= "00";

                        sp_ld <= '0';
                        sp_incr <= '0';
                        sp_decr <= '0';

                        flg_c_ld <= '0';
                        flg_c_set <= '0';
                        flg_c_clr <= '0';

                        flg_z_ld <= '0';

                        i_clr <= '0';
                        i_set <= '0';
                        flg_ld_sel <= '0';
                        flg_shad_ld <= '0';

                        rst <= '0';

                    when "00001" => -- sub reg-immed opcode
                        pc_ld <= '0';
                        pc_inc <= '0';
                        pc_mux_sel <= "00";

                        rf_wr <= '0';
                        rf_wr_sel <= "00";

                        alu_sel <= "0000";
                        alu_opy_sel <= '0';

                        scr_data_sel <= '0';
                        scr_we <= '0';
                        scr_addr_sel <= "00";

                        sp_ld <= '0';
                        sp_incr <= '0';
                        sp_decr <= '0';

                        flg_c_ld <= '0';
                        flg_c_set <= '0';
                        flg_c_clr <= '0';

                        flg_z_ld <= '0';

                        i_clr <= '0';
                        i_set <= '0';
                        flg_ld_sel <= '0';
                        flg_shad_ld <= '0';

                        rst <= '0';

                    when "00001" => -- subc reg-reg opcode
                        pc_ld <= '0';
                        pc_inc <= '0';
                        pc_mux_sel <= "00";

                        rf_wr <= '0';
                        rf_wr_sel <= "00";

                        alu_sel <= "0000";
                        alu_opy_sel <= '0';

                        scr_data_sel <= '0';
                        scr_we <= '0';
                        scr_addr_sel <= "00";

                        sp_ld <= '0';
                        sp_incr <= '0';
                        sp_decr <= '0';

                        flg_c_ld <= '0';
                        flg_c_set <= '0';
                        flg_c_clr <= '0';

                        flg_z_ld <= '0';

                        i_clr <= '0';
                        i_set <= '0';
                        flg_ld_sel <= '0';
                        flg_shad_ld <= '0';

                        rst <= '0';

                    when "00001" => -- subc reg-immed opcode
                        pc_ld <= '0';
                        pc_inc <= '0';
                        pc_mux_sel <= "00";

                        rf_wr <= '0';
                        rf_wr_sel <= "00";

                        alu_sel <= "0000";
                        alu_opy_sel <= '0';

                        scr_data_sel <= '0';
                        scr_we <= '0';
                        scr_addr_sel <= "00";

                        sp_ld <= '0';
                        sp_incr <= '0';
                        sp_decr <= '0';

                        flg_c_ld <= '0';
                        flg_c_set <= '0';
                        flg_c_clr <= '0';

                        flg_z_ld <= '0';

                        i_clr <= '0';
                        i_set <= '0';
                        flg_ld_sel <= '0';
                        flg_shad_ld <= '0';

                        rst <= '0';

                    when "00001" => -- test reg-reg opcode
                        pc_ld <= '0';
                        pc_inc <= '0';
                        pc_mux_sel <= "00";

                        rf_wr <= '0';
                        rf_wr_sel <= "00";

                        alu_sel <= "0000";
                        alu_opy_sel <= '0';

                        scr_data_sel <= '0';
                        scr_we <= '0';
                        scr_addr_sel <= "00";

                        sp_ld <= '0';
                        sp_incr <= '0';
                        sp_decr <= '0';

                        flg_c_ld <= '0';
                        flg_c_set <= '0';
                        flg_c_clr <= '0';

                        flg_z_ld <= '0';

                        i_clr <= '0';
                        i_set <= '0';
                        flg_ld_sel <= '0';
                        flg_shad_ld <= '0';

                        rst <= '0';

                    when "00001" => -- test reg-immed opcode
                        pc_ld <= '0';
                        pc_inc <= '0';
                        pc_mux_sel <= "00";

                        rf_wr <= '0';
                        rf_wr_sel <= "00";

                        alu_sel <= "0000";
                        alu_opy_sel <= '0';

                        scr_data_sel <= '0';
                        scr_we <= '0';
                        scr_addr_sel <= "00";

                        sp_ld <= '0';
                        sp_incr <= '0';
                        sp_decr <= '0';

                        flg_c_ld <= '0';
                        flg_c_set <= '0';
                        flg_c_clr <= '0';

                        flg_z_ld <= '0';

                        i_clr <= '0';
                        i_set <= '0';
                        flg_ld_sel <= '0';
                        flg_shad_ld <= '0';

                        rst <= '0';

                    --take care of other cases
                    when others =>
                        --insert default block here--
                        --start default block--
                        i_set <= '0';
                        i_clr <= '0';

                        pc_ld <= '0';
                        pc_inc <= '0';
                        pc_mux_sel <= "00";

                        alu_opy_sel <= '0';
                        alu_sel <= "0000";

                        rf_wr <= '0';
                        rf_wr_sel <= "00";

                        sp_ld <= '0';
                        sp_incr <= '0';
                        sp_decr <= '0';

                        scr_we <= '0';
                        scr_addr_sel <= "00";
                        scr_data_sel <= '0';

                        flg_c_set <= '0';
                        flg_c_clr <= '0';
                        flg_c_ld <= '0';
                        flg_z_ld <= '0';
                        flg_ld_sel <= '0';
                        flg_shad_ld <= '0';

                        rst <= '0';
                        io_strb <= '0';
                        --end default block--

                    end case;

            --take care of other cases
            when others =>
                --insert default block here--
                --start default block--
                i_set <= '0';
                i_clr <= '0';

                pc_ld <= '0';
                pc_inc <= '0';
                pc_mux_sel <= "00";

                alu_opy_sel <= '0';
                alu_sel <= "0000";

                rf_wr <= '0';
                rf_wr_sel <= "00";

                sp_ld <= '0';
                sp_incr <= '0';
                sp_decr <= '0';

                scr_we <= '0';
                scr_addr_sel <= "00";
                scr_data_sel <= '0';

                flg_c_set <= '0';
                flg_c_clr <= '0';
                flg_c_ld <= '0';
                flg_z_ld <= '0';
                flg_ld_sel <= '0';
                flg_shad_ld <= '0';

                rst <= '0';
                io_strb <= '0';
            --end default block--

       end case;

    end process;

end Behavioral;

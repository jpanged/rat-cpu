----------------------------------------------------------------------------------
-- Company: CPE 233 Winter 2018
-- Engineer: Russell Caletena, Josiah Pang, & Nathan Wang
--
-- Create Date: 02/02/2018 03:18:00 PM
-- Design Name: Testbench for ALU module
-- Module Name: alu_sim - Behavioral
-- Project Name: RAT Assignment 4
-- Target Devices: Basys 3
-- Tool Versions:
-- Description: The testbench simulation for rat_alu.vhd
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity alu_sim is
--  Port ( );
end alu_sim;

architecture bench of alu_sim is
    component rat_alu is
        Port ( a :      in std_logic_vector (7 downto 0);
               b :      in std_logic_vector (7 downto 0);
               c_in :   in std_logic;
               sel :    in std_logic_vector (3 downto 0);
               sum :    out std_logic_vector (7 downto 0);
               c_flag : out std_logic;
               z_flag : out std_logic);
    end component;

        -- intermediate signal declaration for inputs --
    signal a_tb : std_logic_vector(7 downto 0) := (others=>'0');
    signal b_tb : std_logic_vector(7 downto 0) := (others=>'0');
    signal c_in_tb : std_logic := '0';
    signal sel_tb : std_logic_vector(3 downto 0) := (others=>'0');

    -- intermediate signal declaration for outputs --
    signal sum_tb : std_logic_vector(7 downto 0) := (others=>'0');
    signal c_flag_tb : std_logic := '0';
    signal z_flag_tb : std_logic := '0';

begin
    uut: rat_alu port map(
        a => a_tb,
        b => b_tb,
        c_in => c_in_tb,
        sel => sel_tb,
        sum => sum_tb,
        c_flag => c_flag_tb,
        z_flag => z_flag_tb
        );

-- TEST CASES ---------------------------------------------------------------
    stimulus_process: process
    begin
        wait for 10 ns;
        -- Test Case 1
        a_tb <= x"AA";
        b_tb <= x"AA";
        c_in_tb <= '0';
        sel_tb <= "0000";
        wait for 10 ns;
        -- Test Case 2
        a_tb <= x"0A";
        b_tb <= x"A0";
        c_in_tb <= '1';
        sel_tb <= "0000";
        wait for 10 ns;
        -- Test Case 3
        a_tb <= x"FF";
        b_tb <= x"01";
        c_in_tb <= '0';
        sel_tb <= "0000";
        wait for 10 ns;
        -- Test Case 4
        a_tb <= x"C8";
        b_tb <= x"36";
        c_in_tb <= '1';
        sel_tb <= "0001";
        wait for 10 ns;
        -- Test Case 5
        a_tb <= x"C8";
        b_tb <= x"37";
        c_in_tb <= '1';
        sel_tb <= "0001";
        wait for 10 ns;
        -- Test Case 6
        a_tb <= x"C8";
        b_tb <= x"64";
        c_in_tb <= '0';
        sel_tb <= "0010";
        wait for 10 ns;
        -- Test Case 7
        a_tb <= x"C8";
        b_tb <= x"64";
        c_in_tb <= '1';
        sel_tb <= "0010";
        wait for 10 ns;
        -- Test Case 8
        a_tb <= x"64";
        b_tb <= x"C8";
        c_in_tb <= '0';
        sel_tb <= "0010";
        wait for 10 ns;
        -- Test Case 9
        a_tb <= x"C8";
        b_tb <= x"64";
        c_in_tb <= '0';
        sel_tb <= "0011";
        wait for 10 ns;
        -- Test Case 10
        a_tb <= x"C8";
        b_tb <= x"64";
        c_in_tb <= '1';
        sel_tb <= "0011";
        wait for 10 ns;

        -- Test Case 11
        a_tb <= x"64";
        b_tb <= x"C8";
        c_in_tb <= '0';
        sel_tb <= "0011";
        wait for 10 ns;
        -- Test Case 12
        a_tb <= x"64";
        b_tb <= x"C8";
        c_in_tb <= '1';
        sel_tb <= "0011";
        wait for 10 ns;
        -- Test Case 13
        a_tb <= x"AA";
        b_tb <= x"FF";
        c_in_tb <= '0';
        sel_tb <= "0100";
        wait for 10 ns;
        -- Test Case 14
        a_tb <= x"FF";
        b_tb <= x"AA";
        c_in_tb <= '0';
        sel_tb <= "0100";
        wait for 10 ns;
        -- Test Case 15
        a_tb <= x"AA";
        b_tb <= x"AA";
        c_in_tb <= '0';
        sel_tb <= "0100";
        wait for 10 ns;
        -- Test Case 16
        a_tb <= x"AA";
        b_tb <= x"AA";
        c_in_tb <= '0';
        sel_tb <= "0101";
        wait for 10 ns;
        -- Test Case 17
        a_tb <= x"03";
        b_tb <= x"AA";
        c_in_tb <= '0';
        sel_tb <= "0101";
        wait for 10 ns;
        -- Test Case 18
        a_tb <= x"AA";
        b_tb <= x"AA";
        c_in_tb <= '0';
        sel_tb <= "0110";
        wait for 10 ns;
        -- Test Case 19
        a_tb <= x"03";
        b_tb <= x"AA";
        c_in_tb <= '0';
        sel_tb <= "0110";
        wait for 10 ns;
        -- Test Case 20
        a_tb <= x"AA";
        b_tb <= x"AA";
        c_in_tb <= '0';
        sel_tb <= "0111";
        wait for 10 ns;
        -- Test Case 21
        a_tb <= x"03";
        b_tb <= x"AA";
        c_in_tb <= '0';
        sel_tb <= "0111";
        wait for 10 ns;
        -- Test Case 22
        a_tb <= x"AA";
        b_tb <= x"AA";
        c_in_tb <= '0';
        sel_tb <= "1000";
        wait for 10 ns;
        -- Test Case 23
        a_tb <= x"55";
        b_tb <= x"AA";
        c_in_tb <= '0';
        sel_tb <= "1000";
        wait for 10 ns;
        -- Test Case 24
        a_tb <= x"01";
        b_tb <= x"12";
        c_in_tb <= '0';
        sel_tb <= "1001";
        wait for 10 ns;
        -- Test Case 25
        a_tb <= x"80";
        b_tb <= x"33";
        c_in_tb <= '0';
        sel_tb <= "1010";
        wait for 10 ns;
        -- Test Case 26
        a_tb <= x"80";
        b_tb <= x"43";
        c_in_tb <= '1';
        sel_tb <= "1010";
        wait for 10 ns;
        -- Test Case 27
        a_tb <= x"01";
        b_tb <= x"AB";
        c_in_tb <= '1';
        sel_tb <= "1011";
        wait for 10 ns;
        -- Test Case 28
        a_tb <= x"AA";
        b_tb <= x"F2";
        c_in_tb <= '0';
        sel_tb <= "1011";
        wait for 10 ns;
        -- Test Case 29
        a_tb <= x"80";
        b_tb <= x"3C";
        c_in_tb <= '0';
        sel_tb <= "1100";
        wait for 10 ns;
        -- Test Case 30
        a_tb <= x"80";
        b_tb <= x"98";
        c_in_tb <= '1';
        sel_tb <= "1100";
        wait for 10 ns;
        -- Test Case 31
        a_tb <= x"80";
        b_tb <= x"81";
        c_in_tb <= '0';
        sel_tb <= "1101";
        wait for 10 ns;
        -- Test Case 32
        a_tb <= x"40";
        b_tb <= x"B2";
        c_in_tb <= '0';
        sel_tb <= "1101";
        wait for 10 ns;
        -- Test Case 33
        a_tb <= x"50";
        b_tb <= x"30";
        c_in_tb <= '0';
        sel_tb <= "1110";
        wait for 10 ns;
        -- Test Case 34
        a_tb <= x"43";
        b_tb <= x"22";
        c_in_tb <= '1';
        sel_tb <= "1110";
        wait;

    end process stimulus_process;
end bench;

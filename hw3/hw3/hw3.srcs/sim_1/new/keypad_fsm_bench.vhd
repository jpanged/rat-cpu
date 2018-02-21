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

entity keypad_fsm_bench is
--  Port ( );
end keypad_fsm_bench;

architecture bench of keypad_fsm_bench is
    component keypad_fsm is
        Port (clk: in std_logic;
        cols: in std_logic_vector(2 downto 0);
        rows: out std_logic_vector(3 downto 0);
        --led_state: out std_logic_vector(3 downto 0);
        pressed_key: out std_logic_vector(7 downto 0));
    end component;

        -- intermediate signal declaration for inputs --
    signal clk_tb : std_logic := '0';
    signal cols_tb : std_logic_vector(2 downto 0) := (others=>'0');

    -- intermediate signal declaration for outputs --
    signal rows_tb : std_logic_vector(3 downto 0) := (others=>'0');
    signal pressed_key_tb : std_logic_vector(7 downto 0) := (others=>'0');

begin
    uut: keypad_fsm port map(
        clk => clk_tb,
        cols => cols_tb,
        rows => rows_tb,
        pressed_key => pressed_key_tb
        );

-- TEST CASES ---------------------------------------------------------------
    clk_process: process
    begin
        clk_tb <= '1';
        wait for 10 ns;
        clk_tb <= '0';
        wait for 10 ns;
        
    end process clk_process;
    
    stimulus_process: process
    begin
        -- Test Case 1
        cols_tb <= "111";
        wait for 10 ns;
        -- Test Case 2
        cols_tb <= "011";
        wait for 10 ns;
        -- Test Case 3
        cols_tb <= "101";
        wait for 10 ns;
        -- Test Case 4
        cols_tb <= "110";
        wait;

    end process stimulus_process;
end bench;


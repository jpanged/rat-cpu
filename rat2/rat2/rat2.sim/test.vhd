----------------------------------------------------------------------------------
-- Company: CPE 233 Winter 2018
-- Engineer: Russell Caletena, Josiah Pang, & Nathan Wang
--
-- Create Date: 01/24/2018 12:07:52 AM
-- Design Name: PC Test Bench VHDL
-- Module Name: rat2 - Behavioral
-- Project Name: RAT Assignment 2
-- Target Devices: Basys 3
-- Description: Creating a test bench in VHDL

----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- defines signed / unsigned vector

entity testBench is
end testBench;

architecture Bench of testBench is

    -- Component declaration for the Unit Under Test (uut)
    -- pc wrapper --
    component pc_wrapper is
        Port ( from_immed : in STD_LOGIC_VECTOR (9 downto 0); -- input to mux_4t1
               from_stack : in STD_LOGIC_VECTOR (9 downto 0); -- input to mux_4t1
               pc_mux_sel : in STD_LOGIC_VECTOR (1 downto 0); -- input to mux_4t1
               pc_ld      : in STD_LOGIC; -- input to PC
               pc_inc     : in STD_LOGIC; -- input to PC
               rst        : in STD_LOGIC; -- input to PC
               clk        : in STD_LOGIC; -- input to PC
               pc_count   : out STD_LOGIC_VECTOR (9 downto 0));
    end component;

    -- intermediate signal declaration for inputs--
    signal from_immed_tb : std_logic_vector(9 downto 0) := (others=>'0');
    signal from_stack_tb : std_logic_vector(9 downto 0) := (others=>'0');
    signal pc_mux_sel_tb : std_logic_vector(1 downto 0) := (others=> '0');
    signal pc_ld_tb : std_logic := '0';
    signal pc_inc_tb : std_logic := '0';
    signal rst_tb : std_logic := '0';
    signal clk_tb : std_logic; --don't know if we need this

    -- intermediate signal declaration for outputs--
    signal pc_count_tb : std_logic_vector(9 downto 0) := (others=>'0');

    constant clk_period : time := 10ns;

begin
    -- Instantiate the Unit Under Test (uut)
    uut: pc_wrapper port map(
      from_immed => from_immed_tb,
      from_stack => from_stack_tb,
      pc_mux_sel => pc_mux_sel_tb,
      pc_ld => pc_ld_tb,
      pc_inc => pc_inc_tb,
      rst => rst_tb,
      clk => clk_tb, --again, don't know if we need this
      pc_count => pc_count_tb
    );

    clk_process: process
    begin
      clk_tb <= '1';
      wait for 5 ns;
      clk_tb <= '0';
      wait for 5 ns;
    end process clk_process;

-- TEST CASES ------------------------------------------------------------------

-- Test if it loads from_immed
    stimulus_process: process
    begin
      pc_ld_tb <= '1';
      from_immed_tb <= "0001000000";
      pc_mux_sel_tb <= "00";
      wait for 10 ns;
-- Test if it loads from_stack   
      pc_ld_tb <= '1';
      from_stack_tb <= "0101010101";
      pc_mux_sel_tb <= "01";
      wait for 10 ns;
-- Test if it loads 3FF      
      pc_ld_tb <= '1';
      pc_mux_sel_tb <= "10";
      wait for 20 ns;
-- Test if it resets      
      pc_ld_tb <= '0';
      rst_tb <= '1';
      wait for 10 ns;         
-- Test if it increments 
      pc_ld_tb <= '0';
      pc_inc_tb <= '1';
      rst_tb <= '0';
      wait;

    end process stimulus_process;

end Bench;

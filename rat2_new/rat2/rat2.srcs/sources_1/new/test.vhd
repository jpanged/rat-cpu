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

architecture Bench of testBench is

    -- Component declaration for the Unit Under Test (uut)
    -- pc wrapper --
    component pcWrapper
        Port ( d_in : in STD_LOGIC_VECTOR (9 downto 0);
               pc_ld : in STD_LOGIC;
               pc_inc : in STD_LOGIC;
               rst : in STD_LOGIC;
               clk : in STD_LOGIC;
               pc_count : out STD_LOGIC_VECTOR (9 downto 0));
    end component;

    -- intermediate signal declaration for inputs--
    signal d_in_tb : std_logic_vector(9 downto 0) := (others=>'0');
    signal pc_ld_tb := '0';
    signal pc_inc_tb := '0';
    signal rst_tb := '0';
    -- signal clk_tb --don't know if we need this

    -- intermediate signal declaration for outputs--
    signal pc_count_tb : std_logic_vector(9 downto 0) := (others=>'0');

    constant clk_period : time := 10ns;

begin
    -- Instantiate the Unit Under Test (uut)
    uut: pcWrapper port map(
      d_in => d_in_tb,
      pc_ld => pc_ld_tb,
      pc_inc => pc_inc_tb,
      rst => rst_tb,
      -- clk => clk_tb --again, don't know if we need this
      pc_count => pc_count_tb
    );

    clk_process: process(clk_tb)
    begin
      clk_tb <= '0';
      wait for 5 ns;
      clk_tb <= '1';
      wait for 5 ns;
    end process clk_process;

    stimulus_process: process(ld_tb, PC_MUX_SEL, ld_tb)
    begin
      ld_tb <= '1';
      from_I_tb <= 0x40;
      PC_MUX_SEL <= "00";
      wait for 10 ns;
      ld_tb <= '0';
    end process stimulus_process;

end Bench;

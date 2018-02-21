----------------------------------------------------------------------------------
-- Company: CPE 233 Winter 2018
-- Engineer: Russell Caletena, Josiah Pang, & Nathan Wang
--
-- Create Date: 02/14/2018 10:00:31 PM
-- Design Name: Keypad Driver
-- Module Name: keypad_drvr - Behavioral
-- Project Name: HW Assignment 3
-- Target Devices: Basys 3
-- Description: Creates a keypad driver which reads in 12 values from a physical
--              keypad, ranging from 0-9, *, and #. Outputs to a 7-seg display.
--
--              This module is the wrapper for all the components.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity keypad_drvr is
    Port (clk: in std_logic;
          cols: in std_logic_vector(2 downto 0);
          rows: out std_logic_vector(3 downto 0);
          digit: out std_logic_vector(3 downto 0);
          seg: out std_logic_vector(7 downto 0));

end keypad_drvr;

architecture Behavioral of keypad_drvr is

    -- Components used
    component clk_div_fs
    port (clk : in std_logic;
          clk_out : out std_logic);
    end component;

    component keypad_fsm
    port (clk: in std_logic;
          cols: in std_logic_vector(2 downto 0);
          rows: out std_logic_vector(3 downto 0);
          pressed_key: out std_logic_vector(7 downto 0));
    end component;

    component binary_to_sseg
    port (binary_result : in STD_LOGIC_VECTOR (7 downto 0);
          seg : out STD_LOGIC_VECTOR (7 downto 0);
          digit : out STD_LOGIC_VECTOR (3 downto 0));
    end component;

    -- Define signals
    signal sig_fsm_clk : std_logic;
    signal sig_temp_pressed_key: std_logic_vector(7 downto 0);

begin
    -- Port map
    c1: clk_div_fs
    port map(clk => clk,
             clk_out => sig_fsm_clk);

    f1: keypad_fsm
    port map(clk => sig_fsm_clk,
             cols => cols,
             rows => rows,
             pressed_key => sig_temp_pressed_key);

    sseg1 : binary_to_sseg
    port map(binary_result => sig_temp_pressed_key,
             seg => seg,
             digit => digit);

end Behavioral;

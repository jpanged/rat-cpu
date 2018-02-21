----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/20/2018 03:09:07 PM
-- Design Name: 
-- Module Name: keypad_fsm_tb - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
entity keypad_fsm_tb is
--  Port ( );
end keypad_fsm_tb;

architecture bench of keypad_fsm_tb is
    component keypad_fsm is
        Port (clk: in std_logic;
                cols: in std_logic_vector(2 downto 0);
                rows: out std_logic_vector(3 downto 0);
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
        wait for 5 ns;
        clk_tb <= '0';
        wait for 5 ns;
    end process clk_process;
    
    stimulus_process: process
    begin
        cols_tb <= "111"; --none pressed
        wait for 10 ms;
        cols_tb <= "011"; --column 2 pressed
        wait for 10 ms;
        cols_tb <= "101"; --column 1 pressed
        wait for 10 ms;
        cols_tb <= "110";  --column 0 pressed
        wait;

    end process stimulus_process;
end bench;

----------------------------------------------------------------------------------
-- Company: Calpoly
-- Engineer: Nathan Pestes, Harris Nguyen
-- 
-- Create Date: 02/5/2018 10:59:13 AM
-- Design Name: ALU
-- Module Name: testing_ALU - Behavioral
-- Project Name: ALU
-- Target Devices: 
-- Tool Versions: 
-- Description: tests
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


entity testing_keypad_drvr is
--  Port ( );
end testing_keypad_drvr;

architecture Behavioral of testing_keypad_drvr is
component keypad_drvr is
    Port (		clk : in std_logic;
		cols : in std_logic_vector(2 downto 0);
		rows : out std_logic_vector(3 downto 0);
		led : out std_logic_vector(3 downto 0);
		pressed_key : out std_logic_vector(7 downto 0));
end component;

signal clk : std_logic;
signal cols : std_logic_vector(2 downto 0);
signal rows : std_logic_vector(3 downto 0);
signal led : std_logic_vector(3 downto 0);
signal pressed_key : std_logic_vector(7 downto 0);
begin
    uut: keypad_drvr port map(		clk => clk,
		cols => cols,
		rows => rows,
		led => led,
		pressed_key => pressed_key);

clk_process: process
    begin
    clk <= '1';
    wait for 10ns;
    clk <= '0';
    wait for 10ns;
end process;
stim_proc: process
    begin
    cols <= "111";
        wait;
    end process;
end Behavioral;

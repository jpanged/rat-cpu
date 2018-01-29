----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/28/2018 10:36:35 PM
-- Design Name: 
-- Module Name: Scratch_RAM_TB - Behavioral
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

entity Scratch_RAM_TB is
end Scratch_RAM_TB;

architecture Bench of Scratch_RAM_TB is
    component Scratch_RAM is
        Port (
        DATA_IN : in STD_LOGIC_VECTOR (9 downto 0);
        SCR_ADDR : in STD_LOGIC_VECTOR (7 downto 0);
        SCR_WE : in STD_LOGIC;
        CLK : in STD_LOGIC;
        DATA_OUT : out STD_LOGIC_VECTOR (9 downto 0));
    end component;
    
    -- intermediate signal declaration for inputs--
    signal DATA_IN_TB : std_logic_vector(9 downto 0) := (others=> '0');
    signal SCR_ADDR_TB : std_logic_vector(7 downto 0) := (others=> '0');
    signal SCR_WE_TB : std_logic := '0';
    signal CLK_TB : std_logic;
    -- intermediate signal declaration for outputs--
    signal DATA_OUT_TB : std_logic_vector(9 downto 0) := (others=> '0');

begin
    uut: Scratch_RAM port map(
        DATA_IN => DATA_IN_TB,
        SCR_ADDR => SCR_ADDR_TB,
        SCR_WE => SCR_WE_TB,
        CLK => CLK_TB,
        DATA_OUT => DATA_OUT_TB
        );

    clk_process: process
    begin
        CLK_TB <= '1';
        wait for 5 ns;
        CLK_TB <= '0';
        wait for 5 ns;
    end process clk_process;

-- TEST CASES ---------------------------------------------------------------
    stimulus_process: process
    begin
    
        wait for 10 ns;
        -- Load in a bunch of data
        SCR_WE_TB <= '1';
        DATA_IN_TB <= "1111111111";
        SCR_ADDR_TB <= "00000000";
        wait for 10 ns;

        SCR_WE_TB <= '1';
        DATA_IN_TB <= "0000000000";
        SCR_ADDR_TB <= "00000001";    
        wait for 10 ns;
    
                  
        SCR_WE_TB <= '1';
        DATA_IN_TB <= "1010101010";
        SCR_ADDR_TB <= "10000000";
        wait for 10 ns;
 
        SCR_WE_TB <= '1';       
        DATA_IN_TB <= "0101010101";
        SCR_ADDR_TB <= "11111110";
        wait for 10 ns;

        SCR_WE_TB <= '1';        
        DATA_IN_TB <= "1100110011";
        SCR_ADDR_TB <= "11111111";        
        wait;
        
    end process stimulus_process;
end Bench;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/28/2018 10:36:35 PM
-- Design Name: 
-- Module Name: REG_FILE_TB - Behavioral
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

entity REG_FILE_TB is
--  Port ( );
end REG_FILE_TB;

architecture Bench of REG_FILE_TB is
    component REG_FILE is
        Port ( RF_WR_DATA : in STD_LOGIC_VECTOR (7 downto 0);
           ADRX : in STD_LOGIC_VECTOR (4 downto 0);
           ADRY : in STD_LOGIC_VECTOR (4 downto 0);
           RF_WR : in STD_LOGIC;
           DX_OUT : out STD_LOGIC_VECTOR (7 downto 0);
           DY_OUT : out STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC);
    end component;
    
        -- intermediate signal declaration for inputs--
    signal RF_WR_DATA_TB : std_logic_vector(7 downto 0) := (others=>'0');
    signal ADRX_TB : std_logic_vector(4 downto 0) := (others=>'0');
    signal ADRY_TB : std_logic_vector(4 downto 0) := (others=> '0');
    signal RF_WR_TB : std_logic := '0';
    signal CLK_TB : std_logic;

    -- intermediate signal declaration for outputs--
    signal DX_OUT_TB : std_logic_vector(7 downto 0) := (others=>'0');
    signal DY_OUT_TB : std_logic_vector(7 downto 0) := (others=>'0');
    
begin
    uut: REG_FILE port map(
        RF_WR_DATA => RF_WR_DATA_TB,
        ADRX => ADRX_TB,
        ADRY => ADRY_TB,
        RF_WR => RF_WR_TB,
        DX_OUT => DX_OUT_TB,
        DY_OUT => DY_OUT_TB,
        CLK => CLK_TB
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
        RF_WR_DATA_TB <= "11111111";
        RF_WR_TB <= '1';
        ADRX_TB <= "00101";
        wait for 10 ns;
        ADRY_TB <= "00101";
        wait for 10 ns;
        
    end process stimulus_process;
end Bench;

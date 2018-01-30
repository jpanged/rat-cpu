----------------------------------------------------------------------------------
-- Company: CPE 233 Winter 2018
-- Engineer: Russell Caletena, Josiah Pang, & Nathan Wang
-- 
-- Create Date: 01/28/2018 06:28:02 PM
-- Design Name: scratch ram
-- Module Name: Scratch_RAM - Behavioral
-- Project Name: RAT Assignment 3
-- Target Devices: Basys 3
-- Tool Versions: 
-- Description: Creates the RAM component of the RAT CPU
--              
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Scratch_RAM is
    Port ( DATA_IN : in STD_LOGIC_VECTOR (9 downto 0);
           SCR_ADDR : in STD_LOGIC_VECTOR (7 downto 0);
           SCR_WE : in STD_LOGIC;
           CLK : in STD_LOGIC;
           DATA_OUT : out STD_LOGIC_VECTOR (9 downto 0));
end Scratch_RAM;

architecture Behavioral of Scratch_RAM is
type type_def is array (0 to 255) of std_logic_vector (9 downto 0);
signal signal_name : type_def := (others => (others => '0'));
begin
    process(clk)
    begin
        if (rising_edge(clk)) then
            if (SCR_WE = '1') then
                signal_name(to_integer(unsigned(SCR_ADDR))) <= DATA_IN;     
            end if;
        end if;
    end process;
    DATA_OUT <= signal_name(to_integer(unsigned(SCR_ADDR)));
end Behavioral;

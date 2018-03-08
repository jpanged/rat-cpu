----------------------------------------------------------------------------------
-- Company: CPE 233 Winter 2018
-- Engineer: Russell Caletena, Josiah Pang, & Nathan Wang
-- 
-- Create Date: 01/28/2018 06:28:02 PM
-- Design Name: Scratch RAM
-- Module Name: scratch_ram - Behavioral
-- Project Name: RAT Assignment 3
-- Target Devices: Basys 3
-- Tool Versions: 
-- Description: Creates the RAM component of the RAT CPU
--              
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity scratch_ram is
    Port ( data_in : in STD_LOGIC_VECTOR (9 downto 0);
           scr_addr : in STD_LOGIC_VECTOR (7 downto 0);
           scr_we : in STD_LOGIC;
           clk : in STD_LOGIC;
           data_out : out STD_LOGIC_VECTOR (9 downto 0));
end scratch_ram;

architecture Behavioral of scratch_ram is
type type_def is array (0 to 255) of std_logic_vector (9 downto 0);
signal signal_name : type_def := (others => (others => '0'));
begin
    process(clk)
    begin
        if (rising_edge(clk)) then
            if (scr_we = '1') then
                signal_name(to_integer(unsigned(scr_addr))) <= data_in;     
            end if;
        end if;
    end process;
    data_out <= signal_name(to_integer(unsigned(scr_addr)));
end Behavioral;

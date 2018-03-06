----------------------------------------------------------------------------------
-- Company: CPE 233 Winter 2018
-- Engineer: Russell Caletena, Josiah Pang, & Nathan Wang
-- 
-- Create Date: 01/24/2018 12:07:52 AM
-- Design Name: 2 to 1 10 Bit Mux
-- Module Name: mux_scr_dat_in - Behavioral
-- Project Name: RAT Assignment 2
-- Target Devices: Basys 3
-- Description: Implements a 2 to 1 10 bit mux

----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_2to1 is
    Port ( sel  : in  std_logic;
           in1 : in  std_logic_vector (7 downto 0);
           in2 : in  std_logic_vector (9 downto 0);
           d_out    : out std_logic_vector(9 downto 0));
end mux_2to1;

architecture Behavioral of mux_2to1 is

begin
    d_out <= "00" & in1 when (sel = '0') else -- Select is 0
                    in2 when (sel = '1') else -- Select is 1
                    "0000000000"; -- Output all else 0

end Behavioral;

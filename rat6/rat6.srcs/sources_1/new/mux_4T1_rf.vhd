----------------------------------------------------------------------------------
-- Company: CPE 233 Winter 2018
-- Engineer: Russell Caletena, Josiah Pang, & Nathan Wang
-- 
-- Create Date: 01/24/2018 12:07:52 AM
-- Design Name: 4 to 1 10 Bit Mux
-- Module Name: mux_4to1 - Behavioral
-- Project Name: RAT Assignment 2
-- Target Devices: Basys 3
-- Description: Implements a 4 to 1 10 bit mux, except a "11" input will always be "0000000000"

----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_4to1 is
    Port ( sel  : in  std_logic_vector (1 downto 0);
           in1 : in  std_logic_vector (9 downto 0);
           in2 : in  std_logic_vector (9 downto 0);
           in3 : in  std_logic_vector (9 downto 0);
           in4 : in std_logic_vector (9 downto 0);
           d_out    : out std_logic_vector(9 downto 0));
end mux_4to1;

architecture Behavioral of mux_4to1 is

begin
    d_out <= in1 when (SEL = "00") else -- Select is 0
             in2 when (SEL = "01") else -- Select is 1
             in3 when (SEL = "10") else -- Select is 2
             in4 when (SEL = "11") else -- Select is 3
         "0000000000"; -- Output all else 0

end Behavioral;

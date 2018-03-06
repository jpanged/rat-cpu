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

entity flags_mux_2to1 is
    Port ( sel  : in  std_logic;
           in1  : in  std_logic;
           in2  : in  std_logic;
        output  : out std_logic);
end flags_mux_2to1;

architecture Behavioral of flags_mux_2to1 is

begin
    output <= in1 when (sel = '0') else -- Select is 0
              in2 when (sel = '1') else -- Select is 1
              '0'; -- Output all else 0
end Behavioral;

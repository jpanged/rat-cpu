----------------------------------------------------------------------------------
-- Company: CPE 233 Winter 2018
-- Engineers: Russell Caletena, Josiah Pang, Nathan Wang
--
-- Create Date: 10/23/2017 08:58:39 PM
-- Module Name: mux_2T1 - Behavioral
-- Target Devices: Bays 3
-- Description: 
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_2T1 is
    Port ( sel : in std_logic;
           in1 : in std_logic_vector (7 downto 0);
           in2 : in std_logic_vector (7 downto 0);
           f : out std_logic_vector (7 downto 0));
end mux_2T1;

architecture Behavioral of mux_2T1 is

begin
    f <= in1 when (sel = '0') else
         in2 when (sel = '1') else
         "00000000";

end Behavioral;

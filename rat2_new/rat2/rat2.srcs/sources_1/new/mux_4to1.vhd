----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 10/22/2017 05:14:08 PM
-- Design Name:
-- Module Name: mux_4T1 - Behavioral
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

entity mux_4to1 is
    Port ( sel  : in  std_logic_vector (1 downto 0);
           in1 : in  std_logic_vector (9 downto 0);
           in2 : in  std_logic_vector (9 downto 0);
           in3 : in  std_logic_vector (9 downto 0);
           d_out    : out std_logic_vector(9 downto 0));
end mux_4to1;

architecture Behavioral of mux_4to1 is

begin
    d_out <= in1 when (SEL = "00") else
            in2 when (SEL = "01") else
            in3 when (SEL = "10") else
         "0000000000";

end Behavioral;

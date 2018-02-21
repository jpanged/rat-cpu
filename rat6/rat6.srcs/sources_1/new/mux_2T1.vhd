----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/23/2017 08:58:39 PM
-- Design Name: 
-- Module Name: mux_2T1 - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

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

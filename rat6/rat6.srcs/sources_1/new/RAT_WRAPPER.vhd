----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/20/2018 03:12:08 AM
-- Design Name: 
-- Module Name: RAT_WRAPPER - Behavioral
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

entity RAT_WRAPPER is
    Port ( btn_l : in STD_LOGIC;
           btn_r : in STD_LOGIC;
           switches : in STD_LOGIC_VECTOR (7 downto 0);
           pmod : in STD_LOGIC;
           clk : in STD_LOGIC;
           sseg : out STD_LOGIC_VECTOR (7 downto 0);
           leds : out STD_LOGIC_VECTOR (7 downto 0));
end RAT_WRAPPER;

architecture Behavioral of RAT_WRAPPER is

begin


end Behavioral;

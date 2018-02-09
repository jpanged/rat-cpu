----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/07/2018 03:09:26 PM
-- Design Name: 
-- Module Name: rat_mcu - Behavioral
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

entity rat_mcu is
    Port ( in_port : in STD_LOGIC_VECTOR (7 downto 0);
           reset : in STD_LOGIC;
           int : in STD_LOGIC;
           clk : in STD_LOGIC;
           
           out_port : out STD_LOGIC_VECTOR (7 downto 0);
           port_id : out STD_LOGIC_VECTOR (7 downto 0);
           io_strb : out STD_LOGIC);
end rat_mcu;

architecture Behavioral of rat_mcu is

begin


end Behavioral;

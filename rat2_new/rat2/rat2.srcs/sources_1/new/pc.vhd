----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/24/2018 12:07:52 AM
-- Design Name: 
-- Module Name: pc - Behavioral
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

entity pc is
    Port ( d_in : in STD_LOGIC_VECTOR (9 downto 0);
           pc_ld : in STD_LOGIC;
           pc_inc : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           pc_count : out STD_LOGIC_VECTOR (9 downto 0));
end pc;

architecture Behavioral of pc is

begin


end Behavioral;

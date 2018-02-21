----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/20/2018 05:40:43 PM
-- Design Name: 
-- Module Name: binary_to_sseg - Behavioral
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

entity binary_to_sseg is
  Port (binary_result: in std_logic_vector(7 downto 0);
        seg: out std_logic_vector(7 downto 0);
        digit: out std_logic_vector(3 downto 0));
end binary_to_sseg;

architecture Behavioral of binary_to_sseg is

begin

    proc1: process (binary_result)
    begin 
        digit <= "1110";
        case binary_result is
            when "00000000" => seg <= "11000000"; --0
            when "00000001" => seg <= "11111001"; --1
            when "00000010" => seg <= "10100100"; --2
            when "00000011" => seg <= "10110000"; --3
            when "00000100" => seg <= "10011001"; --4
            when "00000101" => seg <= "10010010"; --5
            when "00000110" => seg <= "10000010"; --6
            when "00000111" => seg <= "11111000"; --7
            when "00001000" => seg <= "10000000"; --8
            when "00001001" => seg <= "10010000"; --9
          --"hgfedcba" 
            when "00001010" => seg <= "10001000"; --A
            when "00001011" => seg <= "10000011"; --b
            when others => seg <= "11111111";                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
        end case;
    end process proc1;
end Behavioral;


----------------------------------------------------------------------------------
-- Company: CPE 233 Winter 2018
-- Engineer: Russell Caletena, Josiah Pang, & Nathan Wang
--
-- Create Date: 02/20/2018 05:40:43 PM
-- Design Name: Seven Segement Look Up Table for RAT 7
-- Module Name: sseg_lut - Behavioral
-- Project Name:
-- Target Devices: Basys 3
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sseg_lut is
  Port (lut_in: in std_logic_vector(7 downto 0);
        seg: out std_logic_vector(7 downto 0);
        digit: out std_logic_vector(3 downto 0));
end sseg_lut;

architecture Behavioral of sseg_lut is

begin

    -- Assigns seven segment output based on input segment value
    proc1: process (lut_in)
    begin
        digit <= "1110";
        case lut_in is
            --when "00000000" => seg <= "11000000"; --0
            when "00000001" => seg <= "11111001"; --1
            when "00000010" => seg <= "10100100"; --2
            when "00000011" => seg <= "10110000"; --3
            when "00000100" => seg <= "10011001"; --4
            when "00000101" => seg <= "10010010"; --5
            when "00000110" => seg <= "10000010"; --6
            when "00000111" => seg <= "11111000"; --7
            when "00001000" => seg <= "10000000"; --8
            --when "00001001" => seg <= "10010000"; --9
            --when "00001010" => seg <= "10001000"; --A
            --when "00001011" => seg <= "10000011"; --b
            when others => seg <= "11111111";
        end case;
    end process proc1;
end Behavioral;

----------------------------------------------------------------------------------
-- Company: 
-- Engineers: Russell Caletena and Nathan Wang
-- 
-- Create Date: 10/14/2017 06:47:08 PM
-- Design Name: 
-- Module Name: BCD_to_SSEG_2 - Behavioral
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

entity BCD_to_SSEG_2 is
    Port ( SW : in STD_LOGIC_VECTOR (3 downto 0);
           BTN: in STD_LOGIC_VECTOR (3 downto 0);
           SEG : out STD_LOGIC_VECTOR (7 downto 0);
           DIGIT : out STD_LOGIC_VECTOR (3 downto 0));
end BCD_to_SSEG_2;

architecture Behavioral of BCD_to_SSEG_2 is
--These are examples of ways to reduce coding method when referring to an item.
--CVEC std_logic_vector (6 downto 0)
--CVEC <= (CA &CB &CC) (& symbol concatinates wires/segments together, like a bundle)
--SEG(0) SEG(1) (like coding, this is a method to refer to the variable and location item..like 1st bit, 2nd bit, etc.)
--CVEC(0)    CVEC(1) (same as line above).
begin
    proc2: process (SW, BTN)
    begin
        case BTN is
            when "000" => DIGIT <= "1110";
            when "001" => DIGIT <= "1101";  
            when "010" => DIGIT <= "1011";
            when "011" => DIGIT <= "0111";
            when "100" => DIGIT <= "1111";
            when "101" => DIGIT <= "1111";
            when "110" => DIGIT <= "1111";
            when "111" => DIGIT <= "1111";
        end case;    
        if (BTN(3) = '1') then
            case SW is
                when "0000" => SEG <= "11000000"; --0
                when "0001" => SEG <= "11111001"; --1
                when "0010" => SEG <= "10100100"; --2
                when "0011" => SEG <= "10110000"; --3
                when "0100" => SEG <= "10011001"; --4
                when "0101" => SEG <= "10010010"; --5
                when "0110" => SEG <= "10000010"; --6
                when "0111" => SEG <= "11111000"; --7
                when "1000" => SEG <= "10000000"; --8
                when "1001" => SEG <= "10010000"; --9
              --"hgfedcba" 
                when "1010" => SEG <= "10001000"; --A
                when "1011" => SEG <= "10000011"; --b
                when "1100" => SEG <= "11000110"; --C
                when "1101" => SEG <= "10100001"; --d
                when "1110" => SEG <= "10000110"; --E
                when "1111" => SEG <= "10001110"; --F
            end case;
        else
            case SW is
                when "0000" => SEG <= "11000000"; --0
                when "0001" => SEG <= "11111001"; --1
                when "0010" => SEG <= "10100100"; --2
                when "0011" => SEG <= "10110000"; --3
                when "0100" => SEG <= "10011001"; --4
                when "0101" => SEG <= "10010010"; --5
                when "0110" => SEG <= "10000010"; --6
                when "0111" => SEG <= "11111000"; --7
                when "1000" => SEG <= "10000000"; --8
                when "1001" => SEG <= "10010000"; --9
                when others => SEG <= "11111111";
            end case;
        end if;
    end process proc2;
--end Behavioral;

    stim_proc: process
    begin
        -- now assign values to the input signals
        -- you should include at least 8 test cases for all labs that 
        -- are representative of different inputs for your circuit
        -- if you can do an exhaustive test (like those that have only 8
        -- or 16 possible input combinations) - do an exhaustive test
--        SW <= '0000';
--        BTN <= '0000';
--        wait for 10 ns;
--        SW <= '0001';
--        BTN <= '0001';
--        wait for 10 ns;
--        SW <= '0';
--        BTN <= '0';
--        wait for 10 ns;
--        SW <= '0';
--        BTN <= '0';
        
        wait;
    end process;
end Behavioral;

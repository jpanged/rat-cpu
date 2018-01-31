----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/31/2018 02:13:04 PM
-- Design Name: 
-- Module Name: rat_alu - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL; --import library to allow the use of arithmetic symbols

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity rat_alu is
    Port ( a : in STD_LOGIC_VECTOR (7 downto 0);
           b : in STD_LOGIC_VECTOR (7 downto 0);
           c_in : in STD_LOGIC;
           sel : in STD_LOGIC_VECTOR (3 downto 0);
           sum : out STD_LOGIC_VECTOR (7 downto 0);
           c_flag : out STD_LOGIC;
           z_flag : out STD_LOGIC);
end rat_alu;

architecture Behavioral of rat_alu is
begin
    process (a, b, c_in, sel)
        variable v_res : std_logic_vector (8 downto 0); --define a variable called v_res to temporarily hold data
    begin
        ------------------------------------------------------(1)
        c_flag <= '0'; --initialize c_flag to '0'
        z_flag <= '0'; --initialize z_flag to '0'

        case sel is 
            when "0000" => --add instruction
                v_res := ('0' & a) + ('0' & b); --assign a 0 to the msb of v_res to ensure unsigned ints for both a and b
                c_flag <= v_res(8);
            when "0001" => --addc instruction
                v_res := ('0' & a) + ('0' & b) + c_in; --assign a 0 to the msb of v_res to ensure unsigned ints for both a and b
                c_flag <= v_res(8);
            when "0010" => --sub instruction
                v_res := ('1' & a) - ('1' & b); --assign a 1 to the msb of v_res to ensure signed ints for both a and b
                c_flag <= v_res(8);
            when "0011" => --subc instruction
                v_res := ('1' & a) - ('1' & b); --assign a 1 to the msb of v_res to ensure signed ints for both a and b

            when "0100" => --cmp instruction
            when "0101" => --and instruction
                v_res := a and b;
            when "0110" => --or instruction
                v_res := a or b;
            when "0111" => --exor instruction
                v_res := a xor b;
            when "1000" => --test instruction
            when "1001" => --lsl instruction
            when "1010" => --lsr instruction
            when "1011" => --rol instruction
            when "1100" => --ror instruction
            when "1101" => --asr instruction
            when "1110" => --mov instruction
            when "1111" => --unused instruction
            
end Behavioral;

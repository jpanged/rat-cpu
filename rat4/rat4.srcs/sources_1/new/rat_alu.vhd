----------------------------------------------------------------------------------
-- Company: CPE 233 Winter 2018
-- Engineer: Russell Caletena, Josiah Pang, & Nathan Wang
--
-- Create Date: 01/31/2018 02:13:04 PM
-- Design Name: register file
-- Module Name: rat_alu - Behavioral
-- Project Name: RAT Assignment 4
-- Target Devices: Basys 3
-- Tool Versions:
-- Description: Creates an arithmetic logic unit component for the RAT CPU
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL; --import library to allow the use of arithmetic symbols

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
                if (v_res(7 downto 1)) = "00000000" then
                   z_flag <= '1';
                else
                   z_flag <= '0';
                end if;   
            when "0001" => --addc instruction
                v_res := ('0' & a) + ('0' & b) + c_in; --assign a 0 to the msb of v_res to ensure unsigned ints for both a and b
                c_flag <= v_res(8);
                if (v_res(7 downto 1)) = "00000000" then
                   z_flag <= '1';
                else
                   z_flag <= '0';
                end if;   
            when "0010" => --sub instruction
                v_res := ('1' & a) - ('1' & b); --assign a 1 to the msb of v_res to ensure signed ints for both a and b
                c_flag <= v_res(8);
                if (v_res(7 downto 1)) = "00000000" then
                   z_flag <= '1';
                else
                   z_flag <= '0';
                end if;  
            when "0011" => --subc instruction
                v_res := ('1' & a) - ('1' & b) - c_in; --assign a 1 to the msb of v_res to ensure signed ints for both a and b
                if (v_res(7 downto 1)) = "00000000" then
                   z_flag <= '1';
                else
                   z_flag <= '0';
                end if;  
            when "0100" => --cmp instruction
                v_res := ('1' & a) - ('1' & b); --assign a 1 to the msb of v_res to ensure signed ints for both a and b
                c_flag <= v_res(8);
                if (v_res(7 downto 1)) = "00000000" then
                    z_flag <= '1';
                else
                    z_flag <= '0';
                end if; 
            when "0101" => --and instruction
                v_res := ('0' & (a and b));
                c_flag <= '0';
                if (a and b) = "00000000" then
                   z_flag <= '1';
                else
                   z_flag <= '0';
                end if;    
            when "0110" => --or instruction
                v_res := ('0' & (a or b));
                c_flag <= '0';
                if (a and b) = "00000000" then
                   z_flag <= '1';
                else
                   z_flag <= '0';
                end if;    
            when "0111" => --exor instruction
                v_res := ('0' & (a xor b));
                c_flag <= '0';
                if (a and b) = "00000000" then
                   z_flag <= '1';
                else
                   z_flag <= '0';
                end if;  
            when "1000" => --test instruction
                 v_res := ('0' & (a and b));
                 c_flag <= '0';
                 if (a and b) = "00000000" then
                    z_flag <= '1';
                 else
                    z_flag <= '0';
                 end if;           
            when "1001" => --lsl instruction
                --shift bits left
                --c_in --> lsb
                --msb --> c_flag
                v_res(7 downto 0) := a(6 downto 0) & c_in;
                c_flag <= a(7);
                if v_res(7 downto 0) = "00000000" then
                    z_flag <= '1';
                else
                    z_flag <= '0';
                end if;
            when "1010" => --lsr instruction
                --shift bits right
                --c_in --> msb
                --lsb --> c_flag
                v_res(7 downto 0) := c_in & a(7 downto 1);
                c_flag <= a(0);
                if v_res(7 downto 0) = "00000000" then
                    z_flag <= '1';
                else
                    z_flag <= '0';
                end if;
            when "1011" => --rol instruction (rotate left)
                --msb --> c_flag
                --msb --> lsb
                c_flag <= a(7);
                v_res(7 downto 0) := a(6 downto 0) & a(7);
                if v_res(7 downto 0) = "00000000" then
                    z_flag <= '1';
                else
                    z_flag <= '0';
                end if;
            when "1100" => --ror instruction (rotate right)
                --lsb --> c_flag
                --lsb --> msb
                c_flag <= a(0);
                v_res(7 downto 0) := a(0) & a(7 downto 1);  
                if v_res(7 downto 0) = "00000000" then
                    z_flag <= '1';
                else
                    z_flag <= '0';
                end if;
            when "1101" => --asr instruction (arithmetic shift right)
                --lsb --> c_flag
                --msb --> v(7)
                c_flag <= a(0);
                v_res(7 downto 0) := a(7) & a(7 downto 1);
                if v_res(7 downto 0) = "00000000" then
                    z_flag <= '1';
                else
                    z_flag <= '0';
                end if;
            when "1110" => --mov instruction (mov)
                v_res := ('0' & b);             
            when "1111" => --unused instruction
            when others => v_res := (others => '1');
        end case;

        if (v_res(7 downto 0) = X"00") then --assignment of the Z indicator
            z_flag <= '1';                  --if the 8-bit result of the ALU
        end if;                             --operation is zero, this reassigns
                                            --the Z signal

        sum <= v_res(7 downto 0); --assigns the lower 8-bits of the intermediate
                                  --result of v_res variable to the output sum

    end process;
end Behavioral;

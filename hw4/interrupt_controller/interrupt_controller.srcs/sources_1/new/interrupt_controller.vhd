----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/04/2018 10:42:28 PM
-- Design Name: 
-- Module Name: interrupt_controller - Behavioral
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

entity interrupt_controller is
    Port ( int_in : in STD_LOGIC_VECTOR (7 downto 0);
           int_clr : in STD_LOGIC_VECTOR (7 downto 0);
           int_en : in STD_LOGIC_VECTOR (7 downto 0);
           clk : in STD_LOGIC;
           int_out : out STD_LOGIC;
           int_status : out STD_LOGIC_VECTOR (7 downto 0));
end interrupt_controller;

architecture Behavioral of interrupt_controller is

begin

    proc1 : process(clk)
    begin
        if (rising_edge(clk)) then
            if (int_in /= "00000000") then
                int_status <= "00000000";
                if (int_in(0) = '1') and (int_en(0) = '1') then
                    int_out <= '1';
                    int_status(0) <= '1'; 
                elsif (int_in(1) = '1') and (int_en(1) = '1') then
                    int_out <= '1';
                    int_status(1) <= '1'; 
                elsif (int_in(2) = '1') and (int_en(2) = '1') then
                    int_out <= '1';
                    int_status(2) <= '1'; 
                elsif (int_in(3) = '1') and (int_en(3) = '1') then
                    int_out <= '1';
                    int_status(3) <= '1'; 
                elsif (int_in(4) = '1') and (int_en(4) = '1') then
                    int_out <= '1';
                    int_status(4) <= '1'; 
                elsif (int_in(5) = '1') and (int_en(5) = '1') then
                    int_out <= '1';
                    int_status(5) <= '1'; 
                elsif (int_in(6) = '1') and (int_en(6) = '1') then
                    int_out <= '1';
                    int_status(6) <= '1'; 
                elsif (int_in(7) = '1') and (int_en(7) = '1') then
                    int_out <= '1';
                    int_status(7) <= '1'; 
                else
                    int_out <= '0';
                end if;
            end if;

        end if;
                
    end process proc1;


end Behavioral;

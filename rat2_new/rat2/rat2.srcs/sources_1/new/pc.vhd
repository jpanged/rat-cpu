----------------------------------------------------------------------------------
-- Company: CPE 233 Winter 2018
-- Engineer: Russell Caletena, Josiah Pang, & Nathan Wang
-- 
-- Create Date: 01/24/2018 12:07:52 AM
-- Design Name: Program Counter
-- Module Name: pc - Behavioral
-- Project Name: RAT Assignment 2
-- Target Devices: Basys 3
-- Description: Implements a program counter in VHDL

----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity pc is
    Port ( d_in : in STD_LOGIC_VECTOR (9 downto 0);
           pc_ld : in STD_LOGIC;
           pc_inc : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           pc_count : out STD_LOGIC_VECTOR (9 downto 0));
end pc;

architecture Behavioral of pc is
    
    -- Intermediate signal
    signal out_temp : STD_LOGIC_VECTOR (9 downto 0);

begin

    proc1 : process(clk,rst,pc_inc,pc_ld)
    begin
        if (rising_edge(clk)) then -- Check for clock edge
            if (rst = '1') then
                out_temp <= "0000000000"; -- Output 0
            elsif (pc_ld = '1') then
                out_temp <= d_in; -- Output the input data
            elsif (pc_inc = '1') then
                out_temp <= out_temp + 1; -- Increment input by 1
            else
                -- Catch all does nothing
            end if;
        end if;
        pc_count <= out_temp; -- Set intermediate signal to output
    end process proc1;


end Behavioral;

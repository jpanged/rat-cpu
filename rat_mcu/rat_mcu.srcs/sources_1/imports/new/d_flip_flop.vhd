----------------------------------------------------------------------------------
-- Company:
-- Engineers: Russell Caletena, Josiah Pang, Nathan Wang
--
-- Create Date: 02/09/2018 10:30:52 PM
-- Module Name: d_flip_flop - Behavioral
-- Target Devices: Basys 3
-- Description: A general D Flip Flop component
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity d_flip_flop is
    Port ( load : in STD_LOGIC;
           set : in STD_LOGIC;
           clear : in STD_LOGIC;
           data : in STD_LOGIC;
           clk : in STD_LOGIC;
           flag : out STD_LOGIC);
end d_flip_flop;

architecture Behavioral of d_flip_flop is
begin
    dff: process (load,set,clear,data,clk)
    begin
        if (rising_edge(clk)) then
            if (set = '1') then
                flag <= '1';
            elsif (clear = '1') then
                flag <= '0';
            elsif (load = '1') then
                flag <= data;
            end if;
        end if;
    end process dff;
end Behavioral;

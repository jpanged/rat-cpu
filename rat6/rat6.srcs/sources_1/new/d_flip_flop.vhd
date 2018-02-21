----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/09/2018 10:30:52 PM
-- Design Name: 
-- Module Name: d_flip_flop - Behavioral
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

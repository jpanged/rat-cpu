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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

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

    signal out_temp : STD_LOGIC_VECTOR (9 downto 0);


begin

    proc1 : process(clk,rst,pc_inc,pc_ld)
    begin
        if (rising_edge(clk)) then
            if (rst = '1') then
                out_temp <= "0000000000";
            elsif (pc_ld = '1') then
                out_temp <= d_in;
            elsif (pc_inc = '1') then
                out_temp <= out_temp + 1;
            end if;
        end if;
        pc_count <= out_temp;
    end process proc1;


end Behavioral;

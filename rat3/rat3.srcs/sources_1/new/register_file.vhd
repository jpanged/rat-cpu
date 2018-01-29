----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/28/2018 06:28:02 PM
-- Design Name: 
-- Module Name: REG_FILE - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity REG_FILE is
    Port ( RF_WR_DATA : in STD_LOGIC_VECTOR (7 downto 0);
           ADRX : in STD_LOGIC_VECTOR (4 downto 0);
           ADRY : in STD_LOGIC_VECTOR (4 downto 0);
           RF_WR : in STD_LOGIC;
           DX_OUT : out STD_LOGIC_VECTOR (7 downto 0);
           DY_OUT : out STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC);
end REG_FILE;

architecture Behavioral of REG_FILE is
type type_def is array (0 to 31) of std_logic_vector (7 downto 0);
signal signal_name : type_def := (others => (others => '0'));
begin
    process(clk)
    begin
        if (rising_edge(clk)) then
            if (RF_WR = '1') then
                signal_name(to_integer(unsigned(ADRX))) <= RF_WR_DATA;     
            end if;             
        end if;
    end process;
    DX_OUT <= signal_name(to_integer(unsigned(ADRX)));
    DY_OUT <= signal_name(to_integer(unsigned(ADRY)));
end Behavioral;

----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 02/04/2018 08:54:10 PM
-- Design Name:
-- Module Name: spkr_drvr - Behavioral
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
use ieee.numeric_std;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity spkr_drvr is
    Port ( sw : in STD_LOGIC_VECTOR (7 downto 0);
           clk : in STD_LOGIC;
           freq : out STD_LOGIC);
end spkr_drvr;

architecture Behavioral of spkr_drvr is

    signal tmp_clks : std_logic := '0';   

begin


    -- Speaker Process
    my_spkr_drvr : process(clk, sw)
    
    variable div_cnt : integer := 0;
    variable period : integer;
    
    begin
        
        -- Case statements for frequencies
        case sw is
            when "00000000" => -- none
                period := 0;

            when "00000001" => -- C6
                period := 95556; --period = 1/frequency
            when "00000010" => -- C6
                period := 90193; --period = 1/frequency
            when "00000011" => -- C6
                period := 85131; --period = 1/frequency
            when "00000100" => -- C6
                period := 80353; --period = 1/frequency
            --------------------------------------------- 1-4   
            when "00000101" => -- C6
                period := 75843; --iperiod = 1/frequency
            when "00000110" => -- C6
                period := 71586; --period = 1/frequency
            when "00000111" => -- C6
                period := 67568; --period = 1/frequency
            when "00001000" => -- C6
                period := 63776; --period = 1/frequency
            --------------------------------------------- 5-8
            when "00001001" => -- C6
                period := 60196; --period = 1/frequency
            when "00001010" => -- C6
                period := 56818; --period = 1/frequency
            when "00001011" => -- C6
                period := 53629; --period = 1/frequency
            when "00001100" => -- C6
                period := 50619; --period = 1/frequency
            --------------------------------------------- 9-12
            when "00001101" => -- C6
                period := 47778; --period = 1/frequency
            when "00001110" => -- C6
                period := 45096; --period = 1/frequency
            when "00001111" => -- C6
                period := 42565; --period = 1/frequency
            when "00010000" => -- C6
                period := 40176; --period = 1/frequency
            --------------------------------------------- 12-16
            when "00010001" => -- C6
                period := 37921; --period = 1/frequency
            when "00010010" => -- C6
                period := 35793; --period = 1/frequency
            when "00010011" => -- C6
                period := 33784; --period = 1/frequency
            when "00010100" => -- C6
                period := 31888; --period = 1/frequency
            --------------------------------------------- 16-20
            when "00010101" => -- C6
                period := 30098; --period = 1/frequency
            when "00010110" => -- C6
                period := 28409; --period = 1/frequency
            when "00010111" => -- C6
                period := 26814; --period = 1/frequency
            when "00011000" => -- C6
                period := 25309; --period = 1/frequency
            --------------------------------------------- 21-24
            when "00011001" => -- C6
                period := 23889; --period = 1/frequency
            when "00011010" => -- C6
                period := 22548; --period = 1/frequency
            when "00011011" => -- C6
                period := 21282; --period = 1/frequency
            when "00011100" => -- C6
                period := 20088; --period = 1/frequency
            --------------------------------------------- 25-28
            when "00011101" => -- C6
                period := 18960; --period = 1/frequency
            when "00011110" => -- C6
                period := 17896; --period = 1/frequency
            when "00011111" => -- C6
                period := 16892; --period = 1/frequency
            when "00100000" => -- C6
                period := 15944; --period = 1/frequency
            --------------------------------------------- 29-32
            when "00100001" => -- C6
                period := 15049; --period = 1/frequency
            when "00100010" => -- C6
                period := 14204; --period = 1/frequency
            when "00100011" => -- C6
                period := 13407; --period = 1/frequency
            when "00100100" => -- C6
                period := 12654; --period = 1/frequency
            --------------------------------------------- 33-36

            when others => period := 0;

        end case;
        
        -- Clock Stuff
        if (rising_edge(clk)) then
            if (div_cnt >= period) then
              tmp_clks <= not tmp_clks;
              div_cnt := 0;
            else
              div_cnt := div_cnt + 1;
            end if;
        end if;
        freq <= tmp_clks;

    end process;


end Behavioral;

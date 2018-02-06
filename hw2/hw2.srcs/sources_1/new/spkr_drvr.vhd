----------------------------------------------------------------------------------
-- Company: CPE 233 Winter 2018
-- Engineer: Russell Caletena, Josiah Pang, & Nathan Wang
--
-- Create Date: 02/04/2018 08:54:10 PM
-- Design Name: Speaker Driver
-- Module Name: spkr_drvr - Behavioral
-- Project Name: HW Assignment 2
-- Target Devices: Basys 3
-- Tool Versions:
-- Description: Creates a speaker driver which takes an 8-bit switch input of 
--              values between 0 and 36. The speaker outputs frequencies between
--              0 and 7902 Hz which can be heard through the speaker circuit
--              with resistor and transistor.
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

            when "00000001" => -- C | 6
                period := 95556; --period = 1/frequency
            when "00000010" => -- C# / Db | 6
                period := 90193; --period = 1/frequency
            when "00000011" => -- D | 6
                period := 85131; --period = 1/frequency
            when "00000100" => -- D# / Eb | 6
                period := 80353; --period = 1/frequency
            --------------------------------------------- 1-4   
            when "00000101" => -- E | 6
                period := 75843; --iperiod = 1/frequency
            when "00000110" => -- F | 6
                period := 71586; --period = 1/frequency
            when "00000111" => -- F# / Gb | 6
                period := 67568; --period = 1/frequency
            when "00001000" => -- G | 6
                period := 63776; --period = 1/frequency
            --------------------------------------------- 5-8
            when "00001001" => -- G# / Ab | 6
                period := 60196; --period = 1/frequency
            when "00001010" => -- A | 6
                period := 56818; --period = 1/frequency
            when "00001011" => -- A# / Bb | 6
                period := 53629; --period = 1/frequency
            when "00001100" => -- B | 6
                period := 50619; --period = 1/frequency
            --------------------------------------------- 9-12
            when "00001101" => -- C | 7
                period := 47778; --period = 1/frequency
            when "00001110" => -- C# / Db | 7
                period := 45096; --period = 1/frequency
            when "00001111" => -- D | 7
                period := 42565; --period = 1/frequency
            when "00010000" => -- D# / Eb | 7
                period := 40176; --period = 1/frequency
            --------------------------------------------- 12-16
            when "00010001" => -- E | 7
                period := 37921; --period = 1/frequency
            when "00010010" => -- F | 7
                period := 35793; --period = 1/frequency
            when "00010011" => -- F# / Gb | 7
                period := 33784; --period = 1/frequency
            when "00010100" => -- G | 7
                period := 31888; --period = 1/frequency
            --------------------------------------------- 16-20
            when "00010101" => -- G# / Ab | 7
                period := 30098; --period = 1/frequency
            when "00010110" => -- A | 7
                period := 28409; --period = 1/frequency
            when "00010111" => -- A# / Bb | 7
                period := 26814; --period = 1/frequency
            when "00011000" => -- B | 7
                period := 25309; --period = 1/frequency
            --------------------------------------------- 21-24
            when "00011001" => -- C | 8
                period := 23889; --period = 1/frequency
            when "00011010" => -- C# / Db | 8
                period := 22548; --period = 1/frequency
            when "00011011" => -- D | 8
                period := 21282; --period = 1/frequency
            when "00011100" => -- D# / Eb | 8
                period := 20088; --period = 1/frequency
            --------------------------------------------- 25-28
            when "00011101" => -- E | 8
                period := 18960; --period = 1/frequency
            when "00011110" => -- F | 8
                period := 17896; --period = 1/frequency
            when "00011111" => -- F# / Gb | 8
                period := 16892; --period = 1/frequency
            when "00100000" => -- G | 8
                period := 15944; --period = 1/frequency
            --------------------------------------------- 29-32
            when "00100001" => -- G# / Ab | 8
                period := 15049; --period = 1/frequency
            when "00100010" => -- A | 8
                period := 14204; --period = 1/frequency
            when "00100011" => -- A# / Bb | 8
                period := 13407; --period = 1/frequency
            when "00100100" => -- B | 8
                period := 12654; --period = 1/frequency
            --------------------------------------------- 33-36

            when others => period := 0; -- Else case

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

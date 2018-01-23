----------------------------------------------------------------------------------
-- CPE 233 Winter 2018
-- Professor Gerfen
-- Engineers: Russell Caletena, Josiah Pang, & Nathan Wang
--
-- Create Date: 01/20/2018 09:37:00 PM
-- Module Name: pwm_dac - Behavioral
-- Project Name: HW 1: pwm_dac
-- Target Devices: Basys 3

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std;
use IEEE.std_logic_unsigned.all;

entity pwm_dac is
    Port ( sw : in std_logic_vector (7 downto 0);
           clk : in std_logic;
           rst : in std_logic;
           pwm : out std_logic);
end pwm_dac;

architecture Behavioral of pwm_dac is

begin

    my_pwm_dac : process(clk, rst)

        variable cnt : integer := 0; -- Keeps track of where in the full cycle out of 256 the program is
        variable swIn : integer; -- Keeps track of input number

    begin
        swIn := CONV_INTEGER(sw); -- Converts signal to variable

        if (rising_edge(clk)) then
            if (rst = '1') then
                pwm <= '0';

            elsif (cnt /= 256) then
                if (cnt <= swIn) then -- Count not yet at input, output high
                    pwm <= '1';
                else -- Count above input, output low
                    pwm <= '0';
                end if;
                cnt := cnt + 1; -- Increment the counter 
                
            else -- Full cycle complete, reset counter
                cnt := 0;
                pwm <= '0';

            end if;

        end if;

    end process;

end Behavioral;

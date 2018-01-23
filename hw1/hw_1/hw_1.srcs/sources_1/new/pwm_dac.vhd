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
    Port ( sw : in STD_LOGIC_VECTOR (7 downto 0);
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           pwm : out STD_LOGIC);
end pwm_dac;

architecture Behavioral of pwm_dac is

begin

    my_pwm_dac : process(clk, rst)

        variable CNT : integer := 0;
        variable SW_IN : integer;

    begin
        SW_IN := CONV_INTEGER(sw);

        if (rst = '1') then
           pwm <= '0';

        elsif (rising_edge(clk)) then

            if (CNT /= 256) then
                if (CNT <= sw_in) then
                    pwm <= '1';
                else
                    pwm <= '0';
                end if;
                CNT := CNT + 1;
            else
                CNT := 0;
                pwm <= '0';

            end if;

        end if;

    end process;

end Behavioral;

----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 01/20/2018 09:37:00 PM
-- Design Name:
-- Module Name: pwm_dac - Behavioral
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

use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pwm_dac is
    Port ( sw : in STD_LOGIC_VECTOR (7 downto 0);
           clk : in STD_LOGIC;
           PWM_OUT : out STD_LOGIC);
end pwm_dac;

architecture Behavioral of pwm_dac is

begin

    my_pwm_dac : process(clk)

        variable CNT : integer := 0; 
        variable SW_IN : integer;       

    begin
        SW_IN := CONV_INTEGER(sw);

        if (rising_edge(clk)) then   

            if (CNT /= 256) then
                if (CNT <= sw_in) then
                    PWM_OUT <= '1';
                else
                    PWM_OUT <= '0';
                end if;
                CNT := CNT + 1;
            else
                CNT := 0;
                PWM_OUT <= '0';

            end if;
                
                     
--            L1 : while (CNT /= SW_IN) loop
--              exit L1 when CNT = SW_IN;
--              PWM_OUT <= '1';
--              CNT := CNT + 1;
--            end loop L1;
--        
--            L2 : while (CNT /= 256) loop
--              exit L2 when CNT = 256;
--              PWM_OUT <= '0';
--              CNT := CNT + 1;
--            end loop L2;
            
--            CNT := 0; -- Resets counter
        end if;

    end process;

end Behavioral;

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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity spkr_drvr is
    Port ( sw : in STD_LOGIC_VECTOR (7 downto 0);
           clk : in STD_LOGIC;
           pwm : out STD_LOGIC);
end spkr_drvr;

architecture Behavioral of spkr_drvr is

begin

    my_spkr_drvr : process(clk)
    
        variable cnt : integer := 0; -- Keeps track of where in the full cycle out of 256 the program is
        variable swIn : integer; -- Keeps track of input number
    
    begin
        
        swIn := CONV_INTEGER(sw); -- Converts signal to variable
        
        if (rising_edge(clk)) then
            if (cnt /= 256) then
                if (cnt <= swIn) then -- Count not yet as input, output high
                    pwm <= '1';
                else -- Count above input, output low
                end if;
                cnt := cnt + 1; -- Increment the counter
                
            else -- Full cycle complete, reset counter
                cnt := 0;
                pwm <= '0';
            end if;
        end if;
        
    end process;  

end Behavioral;

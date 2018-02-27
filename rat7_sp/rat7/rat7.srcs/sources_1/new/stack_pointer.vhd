----------------------------------------------------------------------------------
-- Company:
-- Engineers: Russell Caletena, Josiah Pang, Nathan Wang
--
-- Create Date: 02/26/2018 03:05:24 PM
-- Design Name: Stack Pointer
-- Module Name: stack_pointer - Behavioral
-- Project Name: RAT CPU
-- Target Devices: Basys 3
-- Description: The stack pointer component for the RAT CPU
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity stack_pointer is
    Port ( rst : in STD_LOGIC;
           ld : in STD_LOGIC;
           incr : in STD_LOGIC;
           decr : in STD_LOGIC;
           data_in : in STD_LOGIC_VECTOR (7 downto 0);
           clk : in STD_LOGIC;
           data_out : out STD_LOGIC_VECTOR (7 downto 0));
end stack_pointer;

architecture Behavioral of stack_pointer is

    -- Intermediate Signal(s)
    signal data_out_sig : std_logic_vector(7 downto 0);

begin

    proc1 : process(clk,rst,ld,incr,decr)
    begin
        if (rst = '1') then -- If reset high
            data_out_sig <= x"00"; -- Reset SP
        elsif (rising_edge(clk)) then -- Check for clock edge
            if (ld = '1') then -- If load is high
                data_out_sig <= data_in; -- Output the input data
            elsif (incr = '1') then -- If increment is high
                data_out_sig <= data_out_sig + 1; -- Increment input by 1
            elsif (decr = '1') then -- If decrement is high
                data_out_sig <= data_out_sig - 1; -- Decrement input by 1
            else
                -- Catch all does nothing
            end if;
        end if;

    end process proc1;
    data_out <= data_out_sig; -- Set intermediate signal to output

end Behavioral;

----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 03/04/2018 10:42:28 PM
-- Design Name:
-- Module Name: interrupt_controller - Behavioral
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description:
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity interrupt_controller is
    Port ( int_in : in STD_LOGIC_VECTOR (7 downto 0);
           int_clr : in STD_LOGIC_VECTOR (7 downto 0);
           int_en : in STD_LOGIC_VECTOR (7 downto 0);
           clk : in STD_LOGIC;
           int_out : out STD_LOGIC;
           int_status : out STD_LOGIC_VECTOR (7 downto 0));
end interrupt_controller;

architecture Behavioral of interrupt_controller is

    -- Declare intermediate signals
    signal int_status_sig : std_logic_vector (7 downto 0);

begin

    proc1 : process(clk)
    begin
        if (rising_edge(clk)) then
            -- Clear signal takes priority
            if (int_clr /= "00000000") then
                if (int_clr(0) = '1') then
                    int_status_sig(0) <= '0';
                else
                end if;
                if (int_clr(1) = '1') then
                    int_status_sig(1) <= '0';
                else
                end if;
                if (int_clr(2) = '1') then
                    int_status_sig(2) <= '0';
                else
                end if;
                if (int_clr(3) = '1') then
                    int_status_sig(3) <= '0';
                else
                end if;
                if (int_clr(4) = '1') then
                    int_status_sig(4) <= '0';
                else
                end if;
                if (int_clr(5) = '1') then
                    int_status_sig(5) <= '0';
                else
                end if;
                if (int_clr(6) = '1') then
                    int_status_sig(6) <= '0';
                else
                end if;
                if (int_clr(7) = '1') then
                    int_status_sig(7) <= '0';
                else
                    -- Nothing
                end if;

            -- Check to see if there are any interrupts
            elsif (int_in /= "00000000") then
                int_status <= "00000000";
                -- Figure out specifically which was triggered
                if (int_in(0) = '1') and (int_en(0) = '1') then
                    int_status_sig(0) <= '1';
                else
                end if;
                if (int_in(1) = '1') and (int_en(1) = '1') then
                    int_status_sig(1) <= '1';
                else
                end if;
                if (int_in(2) = '1') and (int_en(2) = '1') then
                    int_status_sig(2) <= '1';
                else
                end if;
                if (int_in(3) = '1') and (int_en(3) = '1') then
                    int_status_sig(3) <= '1';
                else
                end if;
                if (int_in(4) = '1') and (int_en(4) = '1') then
                    int_status_sig(4) <= '1';
                else
                end if;
                if (int_in(5) = '1') and (int_en(5) = '1') then
                    int_status_sig(5) <= '1';
                else
                end if;
                if (int_in(6) = '1') and (int_en(6) = '1') then
                    int_status_sig(6) <= '1';
                else
                end if;
                if (int_in(7) = '1') and (int_en(7) = '1') then
                    int_status_sig(7) <= '1';
                else
                    -- Nothing
                end if;
            end if;
        end if;

    -- Assign intermediate signals to output
    int_out <= int_status_sig(0) or int_status_sig(1) or int_status_sig(2) or int_status_sig(3) or
               int_status_sig(4) or int_status_sig(5) or int_status_sig(6) or int_status_sig(7); --int_status or
    int_status <= int_status_sig;
    end process proc1;

end Behavioral;

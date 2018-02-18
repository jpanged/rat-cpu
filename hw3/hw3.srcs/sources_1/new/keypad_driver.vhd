----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 02/14/2018 10:00:31 PM
-- Design Name:
-- Module Name: keypad_drvr - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity keypad_drvr is
    Port (clk: in std_logic;
          cols: in std_logic_vector(2 downto 0);
          rows: out std_logic_vector(3 downto 0);
          --int: out std_logic; -- Incorporated later for extra credit, if possible
          pressed_key: out std_logic_vector(7 downto 0)); -- 7-seg output

end keypad_drvr;

architecture Behavioral of keypad_drvr is
    -- Create state types and signals for FSM
    type state_type is (st_init, st_row0, st_row1, st_row2, st_row3);
    signal ps, ns: state_type;
    signal valid : std_logic;

begin

    -- Present and next state logic
    sync_process: process(clk, ns)
    begin
        --might need reset for fsm to work? maybe
        if (rising_edge(clk)) then
            ps <= ns;
        end if;
    end process;

    -- FSM for setting rows
    comb_process: process (ns, ps, cols)
    --comb_process: process (ns, ps, cols)
    begin
---------------------------------------------------------------
--        --cols <= "111";
--        rows <= "1111";
--        --pressed_key <= "11111110"; -- Default 7-seg: Everything lit but DP

--        case ps is
--            when st_init =>
--                ns <= st_row0;
--            when st_row0 => -- Set row 0 to low, all others high
--                ns <= st_row1;
--                rows <= "1110";
--                --if (cols = "110") then
--                if (cols = "011") then
--                    pressed_key <= "00000001"; --assign 1 to pressed key
--                    led <= "0001";
--                elsif (cols = "101") then
----                elsif (cols = "101") then
--                    pressed_key <= "00000010"; --assign 2 to pressed key
--                    --led <= "0010";
--                --elsif (cols = "011") then
--                elsif (cols = "110") then
--                    pressed_key <= "00000011"; --assign 3 to pressed key
--                    --led <= "0011";
--                end if; --don't know if we need an else others case here
--            when st_row1 => -- Set row 1 to low, all others high
--                ns <= st_row2;
--                rows <= "1101";
--                if (cols = "110") then
--                    pressed_key <= "00000100"; --assign 4 to pressed key
--                    led <= "0100";
--                elsif (cols = "101") then
--                    pressed_key <= "00000101"; --assign 5 to pressed key
--                    --led <= "0101";
--                elsif (cols = "011") then
--                    pressed_key <= "00000110"; --assign 6 to pressed key
--                    --led <= "0110";
--                end if; --don't know if we need an else others case here
--            when st_row2 => --Set row 2 to low, all others high
--                ns <= st_row3;
--                rows <= "1011";
--                if (cols = "110") then
--                    pressed_key <= "00000111"; --assign 7 to pressed key
--                    led <= "0111";
--                elsif (cols = "101") then
--                    pressed_key <= "00001000"; --assign 8 to pressed key
--                    --led <= "1000";
--                elsif (cols = "011") then
--                    pressed_key <= "00001001"; --assign 9 to pressed key
--                    --led <= "1001";
--                end if; --don't know if we need an else others case here
--            when st_row3 => -- Set row 3 to low, all others high
--                ns <= st_output;
--                rows <= "0111";
--                if (cols = "110") then
--                    pressed_key <= "11111111"; --assign A(*) to pressed key (set all 1's for now)
--                    led <= "1010";
--                elsif (cols = "101") then
--                    pressed_key <= "00000000"; --assign 0 to pressed key
--                    --led <= "0000";
--                elsif (cols = "011") then
--                    pressed_key <= "11111111"; --assign b(#) to pressed key (set 1100 for now)
--                    --led <= "1100";
--                end if; --don't know if we need an else others case here
--            when st_output =>
--                ns <= st_row0;
--                rows <= "0000";
--            when others =>
--                rows <= "1111";
--                pressed_key <= "11111110";
--        end case;
------------------------------------------------------
        --rows <= "1111";
        --pressed_key <= "11111110"; -- Default 7-seg: Everything lit but DP

        case ps is
            when st_init =>
                ns <= st_row0;
                
                rows <= "1111";
                
            when st_row0 => -- Set row 0 to low, all others high (ACTUALLY ROW3)
                --### WORKS ###--
                ns <= st_row1;
                
                rows <= "1000";
                if (cols = "011") then
                    --pressed_key <= "00000001"; --assign 1 to pressed key
                elsif (cols = "101") then
                    --pressed_key <= "00000010"; --assign 2 to pressed key
                elsif (cols = "110") then
                    --pressed_key <= "00000011"; --assign 3 to pressed key
                end if;  --don't know if we need an else others case here
            
                
                
            when st_row1 => -- Set row 1 to low, all others high (ACTUALLY ROW2)
                ns <= st_row2; 
                
                rows <= "0100";
                if (cols = "011") then
                    --pressed_key <= "00000100"; --assign 4 to pressed key
                elsif (cols = "101") then
                    --pressed_key <= "00000101"; --assign 5 to pressed key
                elsif (cols = "110") then
                    --pressed_key <= "00000110"; --assign 6 to pressed key
                end if; --don't know if we need an else others case here
                
                  
                    
            when st_row2 => -- Set row 2 to low, all others high (ACTUALLY ROW1)
                --### WORKS ###--
                ns <= st_row3;
                
                rows <= "0010";
                    
                if (cols = "011") then
                    --pressed_key <= "00000111"; --assign 7 to pressed key
                elsif (cols = "101") then
                    --pressed_key <= "00001000"; --assign 8 to pressed key
                elsif (cols = "110") then
                    --pressed_key <= "00001001"; --assign 9 to pressed key
                end if; --don't know if we need an else others case here 
            
                   
                         
            when st_row3 => -- Set row 2 to low, all others high (ACTUALLY ROW0)
                --### WORKS ###-- (except for * key)
                ns <= st_init;
                rows <= "0001";
              
                if (cols = "011") then
                    pressed_key <= "00001010"; --assign A to pressed key
                elsif (cols = "101") then
                    pressed_key <= "00000000"; --assign 0 to pressed key
                elsif (cols = "110") then
                    pressed_key <= "11111111"; --assign * to pressed key
                end if; --don't know if we need an else others case here 
                                 
            when others =>
                ns <= st_init;
                
        end case;
------------------------------------------------------------------
--case ps is
--            when st_init =>
--                ns <= st_row0;
--                rows <= "1111";
--            when st_row0 => -- Set row 0 to low, all others high (ACTUALLY ROW3)
--                --rows <= "0111";
--                rows <= "1000";
--                case cols is
--                    --when "011" => pressed_key <= "00000001"; 
--                    --when "101" => pressed_key <= "00000010";  
--                    --when "110" => pressed_key <= "00000011";
--                    when others => null;
--                end case;
            
--                ns <= st_row1;
                
--            when st_row1 => -- Set row 1 to low, all others high (ACTUALLY ROW2)
--                rows <= "0100";
--                case cols is
--                    when "011" => pressed_key <= "00000100"; 
--                    when "101" => pressed_key <= "00000101";  
--                    when "110" => pressed_key <= "00000110";
--                    when others => null;
--                end case;
                        
--                ns <= st_row2;
                    
--            when st_row2 => -- Set row 2 to low, all others high (ACTUALLY ROW1)
--                --rows <= "1101";
--                rows <= "0010";
--                case cols is
--                   -- when "011" => pressed_key <= "00000111"; --7C
--                    --when "101" => pressed_key <= "00001000";  
--                    --when "110" => pressed_key <= "00001001";
--                    when others => null;
--                end case;
            
--                ns <= st_row3;
                         
--            when st_row3 => -- Set row 2 to low, all others high (ACTUALLY ROW0)
--                --rows <= "1110";
--                rows <= "0001";
--                case cols is
--                    --when "011" => pressed_key <= "00001010"; 
--                    --when "101" => pressed_key <= "00000000";  
--                    --when "110" => pressed_key <= "11111110";
--                    when others => null;
--                end case;
            
--                ns <= st_output;
                                            
--            when st_output =>
--                ns <= st_row0;
--                rows <= "0000";
--            when others =>
--                ns <= st_init;
--                rows <= "1111";
--                --pressed_key <= "11111110";
--        end case;
        
    end process;

end Behavioral;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/18/2018 02:53:13 PM
-- Design Name: 
-- Module Name: keypad_fsm - Behavioral
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

entity keypad_fsm is
  Port (clk: in std_logic;
        cols: in std_logic_vector(2 downto 0);
        rows: out std_logic_vector(3 downto 0);
        --led_state: out std_logic_vector(3 downto 0);
        pressed_key: out std_logic_vector(7 downto 0));
end keypad_fsm;


architecture Behavioral of keypad_fsm is
    -- Create state types and signals for FSM
    type state_type is (st_row3, st_row2, st_row1, st_row0);
    --type state_type is (st_init, st_hold, st_row3, st_row2, st_row1, st_row0);
    signal ps, ns : state_type;
    --signal sig_pressed_key : std_logic_vector(7 downto 0);
    --signal sig_temp_pressed_key : std_logic_vector(7 downto 0);
    signal tmp_clks : std_logic := '0';
    signal load : std_logic;
    signal latched_pressed_key : std_logic_vector(7 downto 0);

begin

    -- Present and next state logic
    sync_process: process(clk)
    begin
        --might need reset for fsm to work? maybe
        if (rising_edge(clk)) then
            ps <= ns;
        end if;
    end process sync_process;

    -- FSM for setting rows      
    comb_process: process (ps, cols)
    
    begin
    
    --Old Github Code that Worked [02-20-18]--
    --Nathan's attempt
             if (cols = "011") or (cols = "101") or (cols = "110") then
     
                 case ps is
                         
                     when st_row3 => -- Set row 0 to low, all others high (ACTUALLY ROW3)
                         rows <= "0111";
                         if (cols = "011") then
                             latched_pressed_key <= "00000001"; --assign 1 to pressed key
                             load <= '1';
                             ns <= ps; -- for hold, instead of ps, use the state it is in at that time
                         elsif (cols = "101") then
                             latched_pressed_key <= "00000010"; --assign 2 to pressed key
                             load <= '1';
                             ns <= ps;
                         elsif (cols = "110") then
                             latched_pressed_key <= "00000011"; --assign 3 to pressed key
                             load <= '1';
                             ns <= ps;
                         else
--                             latched_pressed_key <= "00000000"; --assign nothing to pressed key
                             load <= '0';
                             ns <= st_row2;

                         
                         end if;
                         
                     when st_row2 => -- Set row 1 to low, all others high (ACTUALLY ROW2)
                         rows <= "1011";
                         if (cols = "011") then
                             latched_pressed_key <= "00000100"; --assign 4 to pressed key
                             load <= '1';
                             ns <= ps;
                         elsif (cols = "101") then
                             latched_pressed_key <= "00000101"; --assign 5 to pressed key
                             load <= '1';
                             ns <= ps;
                         elsif (cols = "110") then
                             latched_pressed_key <= "00000110"; --assign 6 to pressed key
                             load <= '1';
                             ns <= ps;
                         else
--                             latched_pressed_key <= "00000000"; --assign nothing to pressed key
                             load <= '0';
                             ns <= st_row1;
                         
                         end if;
                         
                         
                     when st_row1 => -- Set row 2 to low, all others high (ACTUALLY ROW1)
                         rows <= "1101";
                         if (cols = "011") then
                             latched_pressed_key <= "00000111"; --assign 7 to pressed key
                             load <= '1';
                         elsif (cols = "101") then
                             latched_pressed_key <= "00001000"; --assign 8 to pressed key
                             load <= '1';
                         elsif (cols = "110") then
                             latched_pressed_key <= "00001001"; --assign 9 to pressed key
                             load <= '1';
                         else
--                             latched_pressed_key <= "00000000"; --assign nothing to pressed key
                             load <= '0';
                         
                         end if;
                         
                         ns <= st_row0;
                           
                     when st_row0 => -- Set row 2 to low, all others high (ACTUALLY ROW0)
                         rows <= "1110";
                         if (cols = "011") then
                             latched_pressed_key <= "00001010"; --assign A to pressed key
                             load <= '1';
                         elsif (cols = "101") then
                             latched_pressed_key <= "00001011"; --assign B to pressed key
                             load <= '1';
                         elsif (cols = "110") then
                             latched_pressed_key <= "00001100"; --assign C to pressed key
                             load <= '1';
--                       else
--                             latched_pressed_key <= "00000000"; --assign nothing to pressed key
                             load <= '0';
                         
                         end if;
                         
                         ns <= st_row3;
                    
                 end case;
                 
             else
             
                --latched_pressed_key <= "00000000"; --assign nothing to pressed key
                load <= '0';
             
             end if;
             
         end process comb_process;
         
        latched_process : process(clk, load, latched_pressed_key)
        begin
         
            if (rising_edge(clk) and load = '1') then
                pressed_key <= latched_pressed_key;
            end if;
            
        end process latched_process;
    
----Nathan's attempt
--        rows <= "1111";
--        pressed_key <= "00000000"; -- LEDs for now
      
--      ---START MORE RECENT CODE---
--            case ps is
                
--                when st_init =>
--                    case cols is              
                
--                        when "111" =>  -- No keys pressed
--                            ns <= st_init;
--                        when others => -- Key was pressed
--                            rows <= "0111";
--                            ns <= st_row3;
--                    end case;
                    
--                when st_hold =>
--                    if (cols = "011" or cols = "101" or cols = "110") then
--                        ns <= st_hold;
--                    else
--                        ns <= st_row3;
--                    end if;
                
                
--                when st_row3 => -- Set row 0 to low, all others high (ACTUALLY ROW3)
--                    led_state <= "1000";
--                    rows <= "1011";
--                    ns <= st_row2;                   
--                    case cols is
--                        when "011" =>
--                            pressed_key <= "00000001"; --assign 1 to pressed key
--                            ns <= st_hold;
--                        when "101" =>
--                            pressed_key <= "00000010"; --assign 2 to pressed key
--                            ns <= st_hold;
--                        when "110" =>
--                            pressed_key <= "00000011"; --assign 3 to pressed key
--                            ns <= st_hold;
--                        when others =>
--                            null; --assign nothing to pressed key
--                    end case;
                    
--                when st_row2 => -- Set row 1 to low, all others high (ACTUALLY ROW2)
--                    led_state <= "0100";
--                    rows <= "1101";
--                    ns <= st_row1;                    
--                    case cols is
--                        when "011" =>
--                            pressed_key <= "00000100"; --assign 4 to pressed key
--                            ns <= st_hold;
--                        when "101" =>
--                            pressed_key <= "00000101"; --assign 5 to pressed key
--                            ns <= st_hold;                            
--                        when "110" =>
--                            pressed_key <= "00000110"; --assign 6 to pressed key
--                            ns <= st_hold;                            
--                        when others =>
--                            null; --assign nothing to pressed key
--                    end case;
                    
--                when st_row1 => -- Set row 2 to low, all others high (ACTUALLY ROW1)
--                    led_state <= "0010";
--                    rows <= "1110";
--                    ns <= st_row0;                                            
--                    case cols is
--                        when "011" =>
--                            pressed_key <= "00000111"; --assign 7 to pressed key
--                            ns <= st_hold;                        
--                        when "101" =>
--                            pressed_key <= "00001000"; --assign 8 to pressed key
--                            ns <= st_hold;                        
--                        when "110" =>
--                            pressed_key <= "00001001"; --assign 9 to pressed key
--                            ns <= st_hold;                                                
--                        when others =>
--                            null; --assign nothing to pressed key
--                    end case;
                      
--                when st_row0 => -- Set row 2 to low, all others high (ACTUALLY ROW0)
--                    led_state <= "0001";
--                    rows <= "0111";
--                    ns <= st_row3;                                                                    
--                    case cols is
--                        when "011" =>
--                            pressed_key <= "00001010"; --assign A to pressed key
--                            ns <= st_hold;                                                
--                        when "101" =>
--                            pressed_key <= "00001011"; --assign B to pressed key
--                            ns <= st_hold;                                                
--                        when "110" =>
--                            pressed_key <= "00001100"; --assign C to pressed key
--                            ns <= st_hold;                                                
--                        when others =>
--                            null; --assign nothing to pressed key
--                    end case;
                    
--                when others =>
--                    ns <= st_init; led_state <= "1111"; rows <= "1111";
--            ---END MOST RECENT CODE---

--                when st_init =>
--                    if (cols = "111") then -- No keys pressed
--                        ns <= st_init;
--                    else -- Key was pressed
--                        rows <= "0111";
--                        ns <= st_row3;
--                    end if;
--                when st_row3 => -- Set row 0 to low, all others high (ACTUALLY ROW3)
--                    led_state <= "1000";
--                    rows <= "1011";
--                    if (cols = "011") then
--                        pressed_key <= "00000001"; --assign 1 to pressed key
--                    elsif (cols = "101") then
--                        pressed_key <= "00000010"; --assign 2 to pressed key
--                    elsif (cols = "110") then
--                        pressed_key <= "00000011"; --assign 3 to pressed key
--                    else
--                        pressed_key <= "00000000"; --assign nothing to pressed key
--                    ns <= st_row2;
--                    end if;
                    
--                when st_row2 => -- Set row 1 to low, all others high (ACTUALLY ROW2)
--                    led_state <= "0100";
--                    --rows <= "1011";
--                    rows <= "1101";
--                    if (cols = "011") then
--                        pressed_key <= "00000100"; --assign 4 to pressed key
--                    elsif (cols = "101") then
--                        pressed_key <= "00000101"; --assign 5 to pressed key
--                    elsif (cols = "110") then
--                        pressed_key <= "00000110"; --assign 6 to pressed key
--                    else
--                        pressed_key <= "00000000"; --assign nothing to pressed key
--                    ns <= st_row1;
--                    end if;
                    
--                when st_row1 => -- Set row 2 to low, all others high (ACTUALLY ROW1)
--                    led_state <= "0010";
--                    --rows <= "1101";
--                    rows <= "1110";
--                    if (cols = "011") then
--                        pressed_key <= "00000111"; --assign 7 to pressed key
--                    elsif (cols = "101") then
--                        pressed_key <= "00001000"; --assign 8 to pressed key
--                    elsif (cols = "110") then
--                        pressed_key <= "00001001"; --assign 9 to pressed key
--                    else
--                        pressed_key <= "00000000"; --assign nothing to pressed key
--                    ns <= st_row0;
--                    end if;
                      
--                when st_row0 => -- Set row 2 to low, all others high (ACTUALLY ROW0)
--                    led_state <= "0001";
--                    --rows <= "1110";
--                    rows <= "0111";
--                    if (cols = "011") then
--                        pressed_key <= "00001010"; --assign A to pressed key
--                    elsif (cols = "101") then
--                        pressed_key <= "00001011"; --assign B to pressed key
--                    elsif (cols = "110") then
--                        pressed_key <= "00001100"; --assign C to pressed key
--                    else
--                        pressed_key <= "00000000"; --assign nothing to pressed key
--                    ns <= st_row3;
--                    end if;
                    
--                when others =>
--                    ns <= st_init; led_state <= "1111"; rows <= "1111";
                    
            --end case;

    --end process comb_process;
    
--    with ps select
--        rows <= --"0000" when st_init,
--                "0111" when st_row3,
--                "1011" when st_row2,
--                "1101" when st_row1,
--                "1110" when st_row0;
      
end Behavioral;
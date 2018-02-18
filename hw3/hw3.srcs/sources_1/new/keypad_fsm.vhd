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
        pressed_key: out std_logic_vector(7 downto 0));
end keypad_fsm;


architecture Behavioral of keypad_fsm is
    -- Create state types and signals for FSM
    type state_type is (st_row3, st_row2, st_row1, st_row0);
    signal ps, ns : state_type;
    --signal sig_pressed_key : std_logic_vector(7 downto 0);
    --signal sig_temp_pressed_key : std_logic_vector(7 downto 0);
    signal tmp_clks : std_logic := '0';

begin

    -- Present and next state logic
    sync_process: process(clk, ns)
    begin
        --might need reset for fsm to work? maybe
        if (rising_edge(clk)) then
            ps <= ns;
        end if;
    end process sync_process;

    -- FSM for setting rows
    comb_process: process (ps, cols)
    
    begin
--Nathan's attempt
        rows <= "1111";
        pressed_key <= "00000000"; -- LEDs for now

        case ps is
--            when st_init =>
--                ns <= st_row0;
                
            when st_row3 => -- Set row 0 to low, all others high (ACTUALLY ROW3)
                rows <= "0111";
                if (cols = "011") then
                    pressed_key <= "00000001"; --assign 1 to pressed key
                elsif (cols = "101") then
                    pressed_key <= "00000010"; --assign 2 to pressed key
                elsif (cols = "110") then
                    pressed_key <= "00000011"; --assign 3 to pressed key
                else
                    pressed_key <= "00000000"; --assign nothing to pressed key
                ns <= st_row2;
                end if;
                
            when st_row2 => -- Set row 1 to low, all others high (ACTUALLY ROW2)
                rows <= "1011";
                if (cols = "011") then
                    pressed_key <= "00000100"; --assign 4 to pressed key
                elsif (cols = "101") then
                    pressed_key <= "00000101"; --assign 5 to pressed key
                elsif (cols = "110") then
                    pressed_key <= "00000110"; --assign 6 to pressed key
                else
                    pressed_key <= "00000000"; --assign nothing to pressed key
                ns <= st_row1;
                end if;
                
            when st_row1 => -- Set row 2 to low, all others high (ACTUALLY ROW1)
                rows <= "1101";
                if (cols = "011") then
                    pressed_key <= "00000111"; --assign 7 to pressed key
                elsif (cols = "101") then
                    pressed_key <= "00001000"; --assign 8 to pressed key
                elsif (cols = "110") then
                    pressed_key <= "00001001"; --assign 9 to pressed key
                else
                    pressed_key <= "00000000"; --assign nothing to pressed key
                ns <= st_row0;
                end if;
                  
            when st_row0 => -- Set row 2 to low, all others high (ACTUALLY ROW0)
                rows <= "1110";
                if (cols = "011") then
                    pressed_key <= "00001010"; --assign A to pressed key
                elsif (cols = "101") then
                    pressed_key <= "00001011"; --assign B to pressed key
                elsif (cols = "110") then
                    pressed_key <= "00001100"; --assign C to pressed key
                else
                    pressed_key <= "00000000"; --assign nothing to pressed key
                ns <= st_row3;
                end if;
           
        end case;
        
    end process comb_process;
    
    with ps select
        rows <= --"0000" when st_init,
                "0111" when st_row3,
                "1011" when st_row2,
                "1101" when st_row1,
                "1110" when st_row0;
      
end Behavioral;



----------------------------------------------------------------------------------
-- Company: CPE 233 Winter 2018
-- Engineer: Russell Caletena, Josiah Pang, & Nathan Wang
--
-- Create Date: 02/18/2018 02:53:13 PM
-- Design Name: Keypad FSM
-- Module Name: keypad_fsm - Behavioral
-- Project Name: HW Assignment 3
-- Target Devices: Basys 3
-- Tool Versions:
-- Description: Defines the keypad FSM component for the keypad driver.
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
    type state_type is (st_init, st_row3, st_row2, st_row1, st_row0);
    signal ps, ns : state_type;
    signal tmp_clks : std_logic := '0';
    signal latched_pressed_key : std_logic_vector(7 downto 0);

begin

    -- Present and next state logic
    sync_process: process(clk)
    begin
        if (rising_edge(clk)) then
            ps <= ns;
        end if;
    end process sync_process;

    -- FSM logic
    comb_process: process (ps,ns)

    begin
         case ps is
             when st_init =>
                ns <= st_row3;

             when st_row3 => -- Set row 0 to low, all others high (ACTUALLY ROW3)
                 ns <= st_row2;
                 rows <= "1110";
                 if (cols = "011") then
                     latched_pressed_key <= "00000001"; --assign 1 to pressed key
                 elsif (cols = "101") then
                     latched_pressed_key <= "00000010"; --assign 2 to pressed key
                 elsif (cols = "110") then
                     latched_pressed_key <= "00000011"; --assign 3 to pressed key
                 else
                     latched_pressed_key <= "11111111"; --assign nothing to pressed key
                 end if;

             when st_row2 => -- Set row 1 to low, all others high (ACTUALLY ROW2)
                 ns <= st_row1;
                   rows <= "0111";
                 if (cols = "011") then
                     latched_pressed_key <= "00000100"; --assign * to pressed key "00001010";
                 elsif (cols = "101") then
                     latched_pressed_key <= "00000101"; --assign 5 to pressed key "00000101";--
                 elsif (cols = "110") then
                     latched_pressed_key <= "00000110"; --assign 6 to pressed key "00000110";--
                 else
                     latched_pressed_key <= "11111111"; --assign nothing to pressed key
                 end if;

             when st_row1 => -- Set row 2 to low, all others high (ACTUALLY ROW1)
                 ns <= st_row0;
                 rows <= "1011";
                 if (cols = "011") then
                     latched_pressed_key <= "00000111"; --assign 7 to pressed key
                 elsif (cols = "101") then
                     latched_pressed_key <= "00001000"; --assign 8 to pressed key
                 elsif (cols = "110") then
                     latched_pressed_key <= "00001001"; --assign 9 to pressed key
                 else
                     latched_pressed_key <= "11111111"; --assign nothing to pressed key
                 end if;

             when st_row0 => -- Set row 2 to low, all others high (ACTUALLY ROW0)
                 ns <= st_row3;
                 rows <= "1101";
                 if (cols = "011") then
                     latched_pressed_key <= "00001010"; --assign 4 to pressed key "00000100";--
                 elsif (cols = "101") then
                     latched_pressed_key <= "00000000"; --assign 0 to pressed key "00001011";
                 elsif (cols = "110") then
                     latched_pressed_key <= "00001011"; --assign # to pressed key "00001100";--
                 else
                     latched_pressed_key <= "11111111"; --assign nothing to pressed key
                 end if;

        end case;
     end process comb_process;

     pressed_key <= latched_pressed_key;

end Behavioral;

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
          rows_out: out std_logic_vector(3 downto 0);
          --int: out std_logic; --incorporated later for extra credit, if possible
          led_out: out std_logic;
          pressed_key: out std_logic_vector(7 downto 0));
          
end keypad_drvr;

architecture Behavioral of keypad_drvr is
    -- create state types and signals for FSM
    type state_type is (st_init, st_row0, st_row1, st_row2, st_row3, st_output);
    signal ps, ns: state_type;
    signal sig_cols: std_logic_vector(2 downto 0);
    
begin
    -- assign values to outputs
    rows_out <= "1111";
    pressed_key <= "00000000";
    --sig_cols <= cols;
    
    -- present and next state logic
    sync_process: process(clk, ns)
    begin
        --might need reset for fsm to work? maybe
        if (rising_edge(clk)) then
            ps <= ns;
        end if;
    end process;
    
    comb_process: process (ns, ps, sig_cols)
    begin
    
        --cols <= "111";
        rows_out <= "1111";
        pressed_key <= "11111110";
        
        case ps is 
            when st_init =>
                ns <= st_row0;
            when st_row0 =>
                ns <= st_row1;
                rows_out <= "1110";
                if (sig_cols = "110") then
                    pressed_key <= "00000001"; --assign 1 to pressed key
                    led_out <= '1';
                elsif (sig_cols = "101") then
                    pressed_key <= "00000010"; --assign 2 to pressed key
                    led_out <= '1';
                elsif (sig_cols = "011") then
                    pressed_key <= "00000011"; --assign 3 to pressed key
                    led_out <= '1';
                end if; --don't know if we need an else others case here
            when st_row1 => 
                ns <= st_row2;
                rows_out <= "1101";
                if (sig_cols = "110") then
                    pressed_key <= "00000100"; --assign 4 to pressed key
                    led_out <= '1';
                elsif (sig_cols = "101") then
                    pressed_key <= "00000101"; --assign 5 to pressed key
                    led_out <= '1';
                elsif (sig_cols = "011") then
                    pressed_key <= "00000110"; --assign 6 to pressed key
                    led_out <= '1';
                end if; --don't know if we need an else others case here
            when st_row2 => 
                ns <= st_row3;
                rows_out <= "1011";
                if (sig_cols = "110") then
                    pressed_key <= "00000111"; --assign 7 to pressed key
                    led_out <= '1';
                elsif (sig_cols = "101") then
                    pressed_key <= "00001000"; --assign 8 to pressed key
                    led_out <= '1';
                elsif (sig_cols = "011") then
                    pressed_key <= "00001001"; --assign 9 to pressed key
                    led_out <= '1';
                end if; --don't know if we need an else others case here
            when st_row3 => 
                ns <= st_output;
                rows_out <= "0111";
                if (sig_cols = "110") then
                    pressed_key <= "11111111"; --assign A(*) to pressed key (set all 1's for now)
                    led_out <= '1';
                elsif (sig_cols = "101") then
                    pressed_key <= "00000000"; --assign 0 to pressed key
                    led_out <= '1';
                elsif (sig_cols = "011") then
                    pressed_key <= "11111111"; --assign b(#) to pressed key (set all 1's for now)
                    led_out <= '1';
                end if; --don't know if we need an else others case here
            when st_output =>
                ns <= st_row0;
                rows_out <= "0000";
            when others =>
                rows_out <= "1111";
                pressed_key <= "11111110";
        end case;
    
    end process; 
    
    rows_out <= "1111";
    pressed_key <= "11111110";
        
    --cols <= sig_cols;

end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity game_clock is
    Port ( interrupt_temp : in std_logic;
           clk : in std_logic;
           --count_out : out std_logic_vector(7 downto 0);
           interrupt : out std_logic);
end game_clock;

architecture Behavioral of game_clock is

--component clk_div_fs is
--    Port (  CLK : in std_logic;
--            FCLK,SCLK : out std_logic);
--end component;

type state_type is (st_off1, st_on1, st_on2, st_off2);
signal ps,ns : state_type;

--signal counter_clk : std_logic;
--signal count_temp : std_logic_vector (7 downto 0) := "00000000";
--signal interrupt_temp : std_logic;

begin
--    cd1: clk_div_fs
--        port map(   CLK => clk,
--                    FCLK=> open,
--                    SCLK => counter_clk);
    
    sync_proc: process(ns,clk)
    begin
        if (rising_edge(clk)) then
            ps <= ns;
        end if;
    end process;

--This is the oneshot debouncer. This FSM says that when an interrupt is triggered,
--interrupt is high for two clock cycles (fetch and execute) and then off again until
--interrupt is triggered. 

--Note: interrupt is the output signal, whereas interrupt_temp is the "button press".
        
    comb_proc: process(ps, interrupt_temp)
    begin
        case ps is
            when st_off1 =>
                interrupt <= '0';
                if interrupt_temp = '1' then
                    ns <= st_on1;
                else
                    ns <= st_off1;
                end if;
            when st_on1 =>
                interrupt <= '1';
                ns <= st_on2;
            when st_on2 =>
                interrupt <= '1';
                ns <= st_off2;
            when st_off2 =>
                interrupt <= '0';
                if interrupt_temp = '0' then
                    ns <= st_off1;
                else
                    ns <= st_off2;
                end if;
            when others =>
                ns <= st_off1;
        end case;
    end process;            

--The timer process tells the clock what to count (measure).
--The actual timing of 1 second is changed via the clk_div values. 

--    timer_proc: process(counter_clk, count_temp)
--    begin
--        if (rst = '1') then
--           count_temp <= "00000000";
--        else    
--            if (rising_edge(counter_clk)) then
--                if (count_temp = "11111111") then
--                    interrupt_temp <= '1';
--                    count_temp <= "00000000";
--                else
--                    interrupt_temp <= '0';
--                    count_temp <= count_temp + 1;
--                end if;
--            end if;
--        end if;
--        count_out <= count_temp;
--    end process;
        
end Behavioral;

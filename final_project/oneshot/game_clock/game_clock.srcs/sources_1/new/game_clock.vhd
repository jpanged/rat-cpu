library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity game_clock is
    Port ( interrupt_temp : in std_logic; -- acts like an interrupt "button" (trigger)
           clk : in std_logic; -- regular clock
           interrupt : out std_logic); -- actual interrupt signal
end game_clock;

architecture Behavioral of game_clock is

--Here we declare the necessary signals to create an fsm.
type state_type is (st_off1, st_on1, st_on2, st_off2);
signal ps,ns : state_type;

begin
    
    --Our synchronous process ensures that our created
    --fsm runs on the rising clock edge.
    sync_proc: process(ns,clk)
    begin
        if (rising_edge(clk)) then
            ps <= ns;
        end if;
    end process;

    --This is our oneshot. The FSM says that when an interrupt
    --is triggered, interrupt is high for two clock cycles
    --(fetch and execute), then off again until another
    --interrupt is triggered. 
        
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

end Behavioral;

----------------------------------------------------------------------------------
-- Company:  RAT Technologies (a subdivision of Cal Poly CENG)
-- Engineer:  Various RAT rats
--
-- Create Date:    02/03/2017
-- Module Name:    RAT_wrapper - Behavioral
-- Target Devices:  Basys3
-- Description: Wrapper for RAT CPU. This model provides a template to interfaces
--    the RAT CPU to the Basys3 development board.
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RAT_wrapper is
    Port ( leds     : out   STD_LOGIC_VECTOR (7 downto 0);
           switches : in    STD_LOGIC_VECTOR (7 downto 0);
           rst      : in    STD_LOGIC;
           clk      : in    STD_LOGIC);
end RAT_wrapper;

architecture Behavioral of RAT_wrapper is

   -- INPUT PORT IDS -------------------------------------------------------------
   -- Right now, the only possible inputs are the switches
   -- In future labs you can add more port IDs, and you'll have
   -- to add constants here for the mux below
   CONSTANT SWITCHES_ID : STD_LOGIC_VECTOR (7 downto 0) := X"20";
   -------------------------------------------------------------------------------
   
   -------------------------------------------------------------------------------
   -- OUTPUT PORT IDS ------------------------------------------------------------
   -- In future labs you can add more port IDs
   CONSTANT LEDS_ID       : STD_LOGIC_VECTOR (7 downto 0) := X"40";
   -------------------------------------------------------------------------------
   
   -- Declare RAT_CPU ------------------------------------------------------------
   component rat_mcu is
       Port ( in_port : in STD_LOGIC_VECTOR (7 downto 0);
              reset_mcu : in STD_LOGIC;
              int_mcu : in STD_LOGIC;
              clk_mcu : in STD_LOGIC;
              
              out_port : out STD_LOGIC_VECTOR (7 downto 0);
              port_id : out STD_LOGIC_VECTOR (7 downto 0);
              io_strb_mcu : out STD_LOGIC);
   end component rat_mcu;
   -------------------------------------------------------------------------------
   
   -- Signals for connecting RAT_CPU to RAT_wrapper -------------------------------
   signal s_input_port  : std_logic_vector (7 downto 0);
   signal s_output_port : std_logic_vector (7 downto 0);
   signal s_port_id     : std_logic_vector (7 downto 0);
   signal s_load        : std_logic;
   signal s_clk_sig     : std_logic := '0';
   --signal s_interrupt   : std_logic; -- not yet used
   
   -- Register definitions for output devices ------------------------------------
   -- add signals for any added outputs
   signal r_LEDS        : std_logic_vector (7 downto 0);
   -------------------------------------------------------------------------------
   -- Signals that match black box routing
   signal btn_r : std_logic;

begin
 
   -- Clock Divider Process ------------------------------------------------------
   clkdiv: process(clk)
    begin
        if RISING_EDGE(clk) then
            s_clk_sig <= NOT s_clk_sig;
        end if;
    end process clkdiv;
   -------------------------------------------------------------------------------
   
   
   -- Instantiate RAT_CPU --------------------------------------------------------
   CPU: rat_mcu
   port map(  IN_PORT  => s_input_port,
              OUT_PORT => s_output_port,
              PORT_ID  => s_port_id,
              RESET_MCU    => rst,
              IO_STRB_MCU  => s_load,
              INT_MCU   => '0',  -- s_interrupt
              CLK_MCU      => s_clk_sig);
   -------------------------------------------------------------------------------


   -------------------------------------------------------------------------------
   -- MUX for selecting what input to read ---------------------------------------
   -- add conditions and connections for any added PORT IDs
   -------------------------------------------------------------------------------
   inputs: process(s_port_id, SWITCHES)
   begin
      if (s_port_id = SWITCHES_ID) then
         s_input_port <= SWITCHES;
      else
         s_input_port <= x"00";
      end if;
   end process inputs;
   -------------------------------------------------------------------------------


   -------------------------------------------------------------------------------
   -- MUX for updating output registers ------------------------------------------
   -- Register updates depend on rising clock edge and asserted load signal
   -- add conditions and connections for any added PORT IDs
   -------------------------------------------------------------------------------
   outputs: process(clk)
   begin
      if (rising_edge(clk)) then
         if (s_load = '1') then
           
            -- the register definition for the LEDS
            if (s_port_id = LEDS_ID) then
               r_LEDS <= s_output_port;
            end if;
           
         end if;
      end if;
   end process outputs;
   -------------------------------------------------------------------------------

   -- Register Interface Assignments ---------------------------------------------
   -- add all outputs that you added to this design
   leds <= r_LEDS;
   
   -- Assigns RST to btn_r
   btn_r <= rst;

end Behavioral;
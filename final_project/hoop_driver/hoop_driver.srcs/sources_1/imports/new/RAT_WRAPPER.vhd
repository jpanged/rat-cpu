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
    Port ( switches :   in std_logic_vector (7 downto 0);
           rst      :   in std_logic;
           clk      :   in std_logic;
           int_in : in std_logic;
           --int_in   :   in std_logic_vector (7 downto 0);
           timer_rst : in std_logic;
           seg      :    out std_logic_vector (7 downto 0);
           leds     :   out std_logic_vector (7 downto 0);
           digit    :   out std_logic_vector (3 downto 0));
           --int_out : out std_logic);

end RAT_wrapper;

architecture Behavioral of RAT_wrapper is

   -- INPUT PORT IDS -------------------------------------------------------------
   -- Right now, the only possible inputs are the switches
   -- In future labs you can add more port IDs, and you'll have
   -- to add constants here for the mux below
   CONSTANT SWITCHES_ID : STD_LOGIC_VECTOR (7 downto 0) := X"20";
   CONSTANT sig_int_id : STD_LOGIC_VECTOR (7 downto 0) := X"21";
   -------------------------------------------------------------------------------

   -------------------------------------------------------------------------------
   -- OUTPUT PORT IDS ------------------------------------------------------------
   -- In future labs you can add more port IDs
   CONSTANT LEDS_ID       : STD_LOGIC_VECTOR (7 downto 0) := X"40";
   CONSTANT SEG_ID        : STD_LOGIC_VECTOR (7 downto 0) := X"81";
   CONSTANT int_clr_id        : STD_LOGIC_VECTOR (7 downto 0) := X"41";
   CONSTANT int_en_id        : STD_LOGIC_VECTOR (7 downto 0) := X"42";
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
-------------------------------------------------------------------------------------
    -- Mealy's SSEG
    component mealy_sseg is
    Port (ALU_VAL : in std_logic_vector(7 downto 0);
          CLK : in std_logic;
          DISP_EN : out std_logic_vector(3 downto 0);
          SEGMENTS : out std_logic_vector(7 downto 0));
    end component;
-----------------------------------------------------------
    -- Declare debouncer 1 shot
    component db_1shot_FSM is
    Port ( A    : in STD_LOGIC;
           CLK  : in STD_LOGIC;
           A_DB : out STD_LOGIC);
    end component;

  -- Interrupt_controller
  component interrupt_controller
  Port (int_in : in STD_LOGIC_VECTOR (7 downto 0);
        int_clr : in STD_LOGIC_VECTOR (7 downto 0);
        int_en : in STD_LOGIC_VECTOR (7 downto 0);
        clk : in STD_LOGIC;
        int_out : out STD_LOGIC;
        int_status : out STD_LOGIC_VECTOR (7 downto 0));
  end component;

    -- Game Clock
    component game_clock is
    port ( count : in std_logic_vector(7 downto 0);
           rst : in std_logic;
           clk : in std_logic;
           count_out : out std_logic_vector(7 downto 0);
           interrupt : out std_logic);
    end component;
   --------------------------------------------------------------------------------
   -- Signals for connecting RAT_CPU to RAT_wrapper -------------------------------
   signal s_input_port  : std_logic_vector (7 downto 0);
   signal s_output_port : std_logic_vector (7 downto 0);
   signal s_port_id     : std_logic_vector (7 downto 0);
   signal s_load        : std_logic;
   signal s_clk_sig     : std_logic := '0';

   signal s_interrupt   : std_logic; -- not yet used----------------------------------------------------------------

   -- Register definitions for output devices ------------------------------------
   -- add signals for any added outputs
   signal r_LEDS        : std_logic_vector (7 downto 0);
   signal r_seg        : std_logic_vector (7 downto 0);
   signal sig_sseg_in    : std_logic_vector (7 downto 0);
   -------------------------------------------------------------------------------
   -- Signals that match black box routing
   signal btn_r : std_logic;
   signal int_btn_r : std_logic;
   -------------------------------------------------------------------------------
   signal sig_int_en : std_logic_vector(7 downto 0);
   signal sig_int_clr : std_logic_vector(7 downto 0);
    signal sig_int_mcu : std_logic;
   --signal sig_int_mcu : std_logic_vector(7 downto 0);
   signal sig_int_status : std_logic_vector(7 downto 0);

begin

   -- Clock Divider Process ------------------------------------------------------
   clkdiv: process(clk)
    begin
        if RISING_EDGE(clk) then
            s_clk_sig <= NOT s_clk_sig;
        end if;
    end process clkdiv;

   -- Instantiate RAT_CPU --------------------------------------------------------
   CPU: rat_mcu
   port map(  IN_PORT  => s_input_port,
              OUT_PORT => s_output_port,
              PORT_ID  => s_port_id,
              RESET_MCU    => btn_r,
              IO_STRB_MCU  => s_load,
              INT_MCU   => s_interrupt,--int_in,
              CLK_MCU      => s_clk_sig);
   -------------------------------------------------------------------------------

   -- Instantiate Mealy SSEG
   msseg1: mealy_sseg
   port map (ALU_VAL => r_seg,
             CLK => clk,
             DISP_EN => digit,
             SEGMENTS => seg);

-- DEBOUNCER 1 SHOT
    db1s: db_1shot_FSM
        port map ( A => sig_int_mcu,
                   CLK => clk,
                   A_DB => s_interrupt);

----   -- Instantiate interrupt_controller
--  ic1: interrupt_controller
--       port map(int_in => int_in,
--                int_clr => sig_int_clr,
--                int_en => sig_int_en,
--                clk => clk ,
--                int_out => sig_int_mcu,
--                int_status => sig_int_status);
--    -- Instantiate game_clock
--   gc1: game_clock
--       port map (count =>, --
--                 rst => timer_rst, -- A normal reset
--                 clk => clk,
--                 count_out =>,
--                 interrupt =>);
   -------------------------------------------------------------------------------
   -- MUX for selecting what input to read ---------------------------------------
   -- add conditions and connections for any added PORT IDs
   -------------------------------------------------------------------------------
   inputs: process(s_port_id, SWITCHES, sig_int_status)
   begin
      if (s_port_id = SWITCHES_ID) then
         s_input_port <= SWITCHES;
      elsif (s_port_id = sig_int_id) then
         s_input_port <= sig_int_status;
      else
         s_input_port <= x"00";
      end if;
   end process inputs;
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
            elsif (s_port_id = SEG_ID) then
               r_seg <= s_output_port;
            elsif (s_port_id = int_en_id) then
                sig_int_en <= s_output_port;
            elsif (s_port_id = int_clr_id) then
                sig_int_clr <= s_output_port;
            end if;

         end if;
      end if;
   end process outputs;
   -------------------------------------------------------------------------------

   -- Register Interface Assignments ---------------------------------------------
   -- add all outputs that you added to this design
   --sig_sseg_in <= r_seg;
   leds <= r_seg;
   --leds(0) <= int_in;
   --seg <= r_seg;
   --digit <= r_digit;
   -- Assigns the interrupt button to int_btn_r
    --int_btn_r <= int_btn;
   -- Assigns RST to btn_r
    btn_r <= rst;
    sig_int_mcu <= int_in;
    --int_out <= sig_int_mcu;

end Behavioral;

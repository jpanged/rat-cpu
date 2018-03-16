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
    Port ( switches     :   in std_logic_vector (7 downto 0);
           rst          :   in std_logic;
           clk          :   in std_logic;
           arduino_in   :   in std_logic; -- signal straight from arduino
           seg          :   out std_logic_vector (7 downto 0);
           leds         :   out std_logic_vector (7 downto 0);
           digit        :   out std_logic_vector (3 downto 0));

end RAT_wrapper;

architecture Behavioral of RAT_wrapper is

    -- INPUT PORT IDS -------------------------------------------------------------
    -- Right now, the only possible inputs are the switches
    -- In future labs you can add more port IDs, and you'll have
    -- to add constants here for the mux below
    CONSTANT SWITCHES_ID    : std_logic_vector(7 downto 0) := X"20";
    CONSTANT sig_int_id     : std_logic_vector(7 downto 0) := X"21";
    -------------------------------------------------------------------------------
    
    -------------------------------------------------------------------------------
    -- OUTPUT PORT IDS ------------------------------------------------------------
    -- In future labs you can add more port IDs
    CONSTANT LEDS_ID       : std_logic_vector(7 downto 0) := X"40";
    CONSTANT SEG_ID        : std_logic_vector(7 downto 0) := X"81";
    CONSTANT int_clr_id    : std_logic_vector(7 downto 0) := X"41";
    CONSTANT int_en_id     : std_logic_vector(7 downto 0) := X"42";
    -------------------------------------------------------------------------------
    
    -- Declare RAT_CPU ------------------------------------------------------------
    component rat_mcu is
    Port ( in_port      : in std_logic_vector (7 downto 0);
           reset_mcu    : in std_logic;
           int_mcu      : in std_logic;
           clk_mcu      : in std_logic;
           out_port     : out std_logic_vector (7 downto 0);
           port_id      : out std_logic_vector (7 downto 0);
           io_strb_mcu  : out std_logic);
    end component rat_mcu;
    -----------------------------------------------------------------------------------
    -- Mealy's SSEG
    component mealy_sseg is
    Port ( ALU_VAL  : in std_logic_vector(7 downto 0);
           CLK      : in std_logic;
           DISP_EN  : out std_logic_vector(3 downto 0);
           SEGMENTS : out std_logic_vector(7 downto 0));
    end component;
-----------------------------------------------------------
    -- Our oneshot component
    component oneshot is
    Port ( interrupt_temp : in std_logic;
           clk            : in std_logic;
           interrupt      : out std_logic);
    end component;
    
    --------------------------------------------------------------------------------
    -- Signals for connecting RAT_CPU to RAT_wrapper -------------------------------
    signal s_input_port  : std_logic_vector (7 downto 0);
    signal s_output_port : std_logic_vector (7 downto 0);
    signal s_port_id     : std_logic_vector (7 downto 0);
    signal s_load        : std_logic;
    signal s_interrupt   : std_logic;
    -------------------------------------------------------------------------------
    -- Register definitions for output devices ------------------------------------
    -- add signals for any added outputs
    signal r_LEDS    : std_logic_vector (7 downto 0);
    signal data_temp : std_logic_vector (7 downto 0);
    -------------------------------------------------------------------------------
    -- Signals that match black box routing
    signal sig_int_en       : std_logic_vector(7 downto 0);
    signal sig_int_clr      : std_logic_vector(7 downto 0);
    signal sig_int_status   : std_logic_vector(7 downto 0);

begin

    -- Clock Divider Process ------------------------------------------------------
    
    -- Not needed for our final project. We use the
    -- standard clock to manage interrupts.
    
    -------------------------------------------------------------------------------
   
    -- Instantiate Own One Shot:
    -- interrupt_temp gets its bit from the arduino interrupt.
    -- interrupt outputs the actual interrupt after it has
    -- been processed by the oneshot.
    os1: oneshot
    port map ( interrupt_temp => arduino_in,
               clk => clk,
               interrupt => s_interrupt);
    
    -- Instantiate RAT_CPU:
    -- rat_mcu takes in the "processed" interrupt from oneshot.vhd
    -- and follows the assembly file's instruction via the prog_rom.vhd
    -- to increment the score counter.
    CPU: rat_mcu
    port map( IN_PORT  => s_input_port,
              OUT_PORT => s_output_port,
              PORT_ID  => s_port_id,
              RESET_MCU    => rst,
              IO_STRB_MCU  => s_load,
              INT_MCU   => s_interrupt,
              CLK_MCU      => clk);
    
    -- Instantiate Mealy SSEG:
    -- the data_temp that comes from rat_mcu's out_port goes to the
    -- alu_val of the seven segment display. Then the seven segment
    -- outputs the segments and disp_en, which are routed to the
    -- seg and digit outputs of the RAT_WRAPPER.
    msseg1: mealy_sseg
    port map (ALU_VAL => data_temp,
              CLK => clk,
              DISP_EN => digit,
              SEGMENTS => seg);
    
    -------------------------------------------------------------------------------
    -- MUX for selecting what input to read ---------------------------------------
    -- add conditions and connections for any added PORT IDs
    --Nathan's Note: MUX reading input options given port_id
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
                    data_temp <= s_output_port;
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

    -- All of our output signals are tied to wrapper outputs via port maps.

end Behavioral;

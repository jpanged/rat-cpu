----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/14/2018 03:07:37 PM
-- Design Name: 
-- Module Name: buckets_wrapper - Behavioral
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

entity buckets_wrapper is
    Port ( arduino_int : in std_logic;
           buckets_rst : in std_logic;
           buckets_clk : in std_logic;
           digit : out std_logic_vector (3 downto 0);
           sseg : out std_logic_vector (7 downto 0);
           leds : out std_logic_vector (7 downto 0));
end buckets_wrapper;

architecture Behavioral of buckets_wrapper is

component game_clock is
    port ( ld        : in std_logic;
           rst       : in std_logic;
           clk       : in std_logic;
           count_out : out std_logic_vector(7 downto 0);
           interrupt : out std_logic);
end component;

component RAT_wrapper is
    port ( rst      :   in std_logic;
           clk      :   in std_logic;
           int_in   :   in std_logic;
           seg      :   out std_logic_vector (7 downto 0);
           leds     :   out std_logic_vector (7 downto 0);
           digit    :   out std_logic_vector (3 downto 0));
end component;

signal arduino_int_temp, game_clk_int_temp : std_logic;
signal digit_temp : std_logic_vector (3 downto 0);
signal sseg_temp, leds_temp : std_logic_vector (7 downto 0);

begin
    gc1: game_clock
    port map ( ld => arduino_int_temp,
               rst => buckets_rst,
               clk => buckets_clk,
               count_out => open,
               interrupt => game_clk_int_temp);
    
    Rw1: RAT_wrapper
    port map ( rst => buckets_rst,
               clk => buckets_clk,
               int_in => game_clk_int_temp,
               seg => sseg_temp,
               leds => leds_temp,
               digit => digit_temp);

    sseg <= sseg_temp;
    leds <= leds_temp;
    digit <= digit_temp;
end Behavioral;

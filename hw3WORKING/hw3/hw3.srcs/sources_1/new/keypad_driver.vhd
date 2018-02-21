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
          rows: out std_logic_vector(3 downto 0);
          digit: out std_logic_vector(3 downto 0);
          seg: out std_logic_vector(7 downto 0);
          pressed_key: out std_logic_vector(7 downto 0));

end keypad_drvr;

architecture Behavioral of keypad_drvr is

    component clk_div_fs
    port (clk : in std_logic;
          clk_out : out std_logic);
    end component;
    
    component keypad_fsm
    port (clk: in std_logic;
          cols: in std_logic_vector(2 downto 0);
          rows: out std_logic_vector(3 downto 0);
          pressed_key: out std_logic_vector(7 downto 0));
    end component;
    
    component binary_to_sseg
    port (binary_result : in STD_LOGIC_VECTOR (7 downto 0);
          seg : out STD_LOGIC_VECTOR (7 downto 0);
          digit : out STD_LOGIC_VECTOR (3 downto 0));
    end component;

    signal sig_fsm_clk : std_logic;
    signal sig_temp_pressed_key: std_logic_vector(7 downto 0);

begin

    c1: clk_div_fs
    port map(clk => clk,
             clk_out => sig_fsm_clk);
    
    f1: keypad_fsm
    port map(clk => sig_fsm_clk,
             cols => cols,
             rows => rows,
             pressed_key => sig_temp_pressed_key);
          
    sseg1 : binary_to_sseg
    port map(binary_result => sig_temp_pressed_key,
             seg => seg,
             digit => digit);

end Behavioral;

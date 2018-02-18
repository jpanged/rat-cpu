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
          --int: out std_logic; -- Incorporated later for extra credit, if possible
          pressed_key: out std_logic_vector(7 downto 0));
          --pressed_key_new: out std_logic_vector(7 downto 0)); -- 7-seg output; -- 7-seg output

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
    
    signal sig_fsm_clk : std_logic;

begin

    c1: clk_div_fs
    port map(clk => clk,
             clk_out => sig_fsm_clk);
    
    f1: keypad_fsm
    port map(clk => sig_fsm_clk,
          cols => cols,
          rows => rows,
          pressed_key => pressed_key);

      
end Behavioral;

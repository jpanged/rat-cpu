----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 02/04/2018 08:54:10 PM
-- Design Name:
-- Module Name: spkr_drvr - Behavioral
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
use ieee.numeric_std;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity spkr_drvr is
    Port ( sw : in STD_LOGIC_VECTOR (7 downto 0);
           clk : in STD_LOGIC;
           freq : out STD_LOGIC);
end spkr_drvr;

architecture Behavioral of spkr_drvr is

    component clk_div_fs is
       port (       CLK : in std_logic;
                    t : in integer;
                    --t: in std_logic_vector(7 downto 0);
              FCLK,SCLK : out std_logic);
    end component;

    signal s_clk : std_logic;
    signal f_clk : std_logic;
    
    --variable asdf : integer;



begin

    -- Port Map Clock Divider
    clk1 : clk_div_fs port map(CLK => clk,
                              t => t,
                              FCLK => f_clk,
                              SCLK => s_clk);

    -- Speaker Process
    my_spkr_drvr : process(clk, sw, t)
    begin

        variable t : integer;

        case sw is
            when "00000000" => -- none
                t := 0;

            when "00000001" => -- C6
                t := 955564; --period = 1/frequency

            when others => period := 0;


        end case;

    freq <= s_clk;


    end process;


end Behavioral;

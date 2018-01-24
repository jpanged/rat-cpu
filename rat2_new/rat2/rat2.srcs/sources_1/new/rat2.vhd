----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/23/2018 10:07:48 PM
-- Design Name: 
-- Module Name: rat2 - Behavioral
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
use IEEE.NUMERIC_STD.ALL; -- defines signed / unsigned vectors

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity rat2 is
    Port ( FROM_IMMED : in STD_LOGIC_VECTOR (9 downto 0); -- input to mux_4t1
           FROM_STACK : in STD_LOGIC_VECTOR (9 downto 0); -- input to mux_4t1
           MAX_HEX      : in STD_LOGIC_VECTOR (9 downto 0); -- input to mux_4t1
           PC_MUX_SEL : in STD_LOGIC_VECTOR (1 downto 0); -- input to mux_4t1
           PC_LD      : in STD_LOGIC; -- input to PC
           PC_INC     : in STD_LOGIC; -- input to PC
           RST        : in STD_LOGIC; -- input to PC
           CLK        : in STD_LOGIC; -- input to PC
           PC_COUNT   : out STD_LOGIC_VECTOR (9 downto 0));

end rat2;

architecture Behavioral of rat2 is

    -- mux_4t1 --
    component mux_4to1
        Port ( sel  : in  std_logic_vector (1 downto 0);
                  in1 : in  std_logic_vector (9 downto 0);
                  in2 : in  std_logic_vector (9 downto 0);
                  in3 : in  std_logic_vector (9 downto 0);
                  d_out    : out std_logic_vector(9 downto 0));
    end component;
    
    -- PC --
    component pc
        Port ( d_in : in STD_LOGIC_VECTOR (9 downto 0);
               pc_ld : in STD_LOGIC;
               pc_inc : in STD_LOGIC;
               rst : in STD_LOGIC;
               clk : in STD_LOGIC;
               pc_count : out STD_LOGIC_VECTOR (9 downto 0));
    end component;
    
    -- intermediate signal declaration --
    signal D_IN : STD_LOGIC_VECTOR (9 downto 0);

begin
    mux1 : mux_4to1
    port map ( in1 => FROM_IMMED,
               in2 => FROM_STACK,
               in3 => MAX_HEX,
               sel => PC_MUX_SEL,
               d_out => D_IN);
               
    pc1 : pc
    port map ( d_in => D_IN,
               pc_ld => PC_LD,
               pc_inc => PC_INC,
               rst => RST,
               clk => CLK,
               pc_count => PC_COUNT);
   
end Behavioral;

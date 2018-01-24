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
           0x3FF      : in STD_LOGIC_VECTOR (9 downto 0); -- input to mux_4t1
           PC_MUX_SEL : in STD_LOGIC_VECTOR (1 downto 0); -- input to mux_4t1
           PC_LD      : in STD_LOGIC; -- input to PC
           PC_INC     : in STD_LOGIC; -- input to PC
           RST        : in STD_LOGIC; -- input to PC
           CLK        : in STD_LOGIC; -- input to PC
           PC_COUNT   : out STD_LOGIC_VECTOR (9 downto 0));

end rat2;

architecture Behavioral of rat2 is

    -- mux_4t1 --
    component mux_4t1
        Port ( FROM_IMMED, FROM_STACK, 0x3FF : in STD_LOGIC_VECTOR(9 downto 0);
               PC_MUX_SEL : in STD_LOGIC_VECTOR (1 downto 0);
               MUX_OUT : out STD_LOGIC_VECTOR (9 downto 0));
    end component;
    
    -- PC --
    component pc
        port ( PC_IN : in STD_LOGIC_VECTOR (9 downto 0);
               PC_LD : in STD_LOGIC;
               PC_INC : in STD_LOGIC;
               RST : in STD_LOGIC;
               CLK : in STD_LOGIC;
               PC_COUNT : out STD_LOGIC_VECTOR (9 downto 0));
    end component;
    
    -- intermediate signal declaration --
    signal D_IN : STD_LOGIC_VECTOR (9 downto 0);

begin
    mux1 : mux_4t1
    port map ( FROM_IMMED => FROM_IMMED,
               FROM_STACK => FROM_STACK,
               0x3FF => 0x3FF,
               PC_MUX_SEL => PC_MUX_SEL,
               MUX_OUT => D_IN);
               
    pc1 : pc
    port map ( PC_IN => D_IN,
               PC_LD => PC_LD,
               PC_INC => PC_INC,
               RST => RST,
               CLK => CLK,
               PC_COUNT => PC_COUNT);
   
end Behavioral;

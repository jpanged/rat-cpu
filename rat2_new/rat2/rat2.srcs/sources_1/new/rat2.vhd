----------------------------------------------------------------------------------
-- Company: CPE 233 Winter 2018
-- Engineer: Russell Caletena, Josiah Pang, & Nathan Wang
--
-- Create Date: 01/24/2018 12:07:52 AM
-- Design Name: PC Wrapper
-- Module Name: pc_wrapper - Behavioral
-- Project Name: RAT Assignment 2
-- Target Devices: Basys 3
-- Description: Wrapper class that pulls the components for the RAT Program Counter

----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- defines signed / unsigned vectors

entity pc_wrapper is
    Port ( FROM_IMMED : in STD_LOGIC_VECTOR (9 downto 0); -- input to mux_4t1
           FROM_STACK : in STD_LOGIC_VECTOR (9 downto 0); -- input to mux_4t1
           PC_MUX_SEL : in STD_LOGIC_VECTOR (1 downto 0); -- input to mux_4t1
           PC_LD      : in STD_LOGIC; -- input to PC
           PC_INC     : in STD_LOGIC; -- input to PC
           RST        : in STD_LOGIC; -- input to PC
           CLK        : in STD_LOGIC; -- input to PC
           PC_COUNT   : out STD_LOGIC_VECTOR (9 downto 0));

end pc_wrapper;

architecture Behavioral of pc_wrapper is

    -- 4-to-1 10-bit mux --
    component mux_4to1
        Port ( sel  : in  std_logic_vector (1 downto 0);
                  in1 : in  std_logic_vector (9 downto 0);
                  in2 : in  std_logic_vector (9 downto 0);
                  in3 : in  std_logic_vector (9 downto 0);
                  d_out    : out std_logic_vector(9 downto 0));
    end component;

    -- Program Counter --
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

-- Port map components
    mux1 : mux_4to1
    port map ( in1 => FROM_IMMED,
               in2 => FROM_STACK,
               in3 => (others => '1'), -- Equals 3FF
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

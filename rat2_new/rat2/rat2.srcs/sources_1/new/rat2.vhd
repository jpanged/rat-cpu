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
    Port ( from_immed : in STD_LOGIC_VECTOR (9 downto 0); -- input to mux_4t1
           from_stack : in STD_LOGIC_VECTOR (9 downto 0); -- input to mux_4t1
           pc_mux_sel : in STD_LOGIC_VECTOR (1 downto 0); -- input to mux_4t1
           pc_ld      : in STD_LOGIC; -- input to PC
           pc_inc     : in STD_LOGIC; -- input to PC
           rst        : in STD_LOGIC; -- input to PC
           clk        : in STD_LOGIC; -- input to PC
           pc_count   : out STD_LOGIC_VECTOR (9 downto 0));

end pc_wrapper;

architecture Behavioral of pc_wrapper is

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
    port map ( in1 => from_immed,
               in2 => from_stack,
               in3 => (others => '1'),
               sel => pc_mux_sel,
               d_out => D_IN);

    pc1 : pc
    port map ( d_in => D_IN,
               pc_ld => PC_LD,
               pc_inc => PC_INC,
               rst => RST,
               clk => CLK,
               pc_count => PC_COUNT);

end Behavioral;

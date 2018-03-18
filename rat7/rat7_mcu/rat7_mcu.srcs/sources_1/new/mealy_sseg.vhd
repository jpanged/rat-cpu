------------------------------------------------------------------------
-- CPE 133 VHDL File: sseg_dec.vhd
-- Description: Special seven segment display driver;
--      
--
-- Author: bryan mealy (12-16-10)
--
-- revisions: 
------------------------------------------------------------------------

-----------------------------------------------------------------------
-----------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-------------------------------------------------------------
-- 4 digit seven-segment display driver. Outputs are active
-- low and configured ABCEDFG in "segment" output. 
--------------------------------------------------------------
entity mealy_sseg is
    Port (     ALU_VAL : in std_logic_vector(7 downto 0); 
               CLK : in std_logic;
               DISP_EN : out std_logic_vector(3 downto 0);
               SEGMENTS : out std_logic_vector(7 downto 0));
end mealy_sseg;

-------------------------------------------------------------
-- description of ssegment decoder
-------------------------------------------------------------
architecture my_sseg of mealy_sseg is

   -- declaration of 8-bit binary to 2-digit BCD converter --
   component mealy_bin2bcdconv 
       Port ( BIN_CNT_IN : in std_logic_vector(7 downto 0);
                 LSD_OUT : out std_logic_vector(3 downto 0);
                 MSD_OUT : out std_logic_vector(3 downto 0);
                MMSD_OUT : out std_logic_vector(3 downto 0));
   end component;

	component mealy_clk_div
		 Port (  clk : in std_logic;
				  sclk : out std_logic);
	end component;
	
   -- intermediate signal declaration -----------------------
   signal   cnt_dig : std_logic_vector(1 downto 0); 
   signal   digit : std_logic_vector (3 downto 0); 
   signal   lsd,msd,mmsd : std_logic_vector(3 downto 0); 
   signal   sclk : std_logic; 

begin

   -- instantiation of bin to bcd converter -----------------
   my_conv: mealy_bin2bcdconv 
	port map ( BIN_CNT_IN => ALU_VAL, 
               LSD_OUT => lsd, 
               MSD_OUT => msd, 
               MMSD_OUT => mmsd); 

   my_clk: mealy_clk_div 
	port map (clk => clk,
	          sclk => sclk ); 

   -- advance the count (used for display multiplexing) -----
   process (SCLK)
   begin
      if (rising_edge(SCLK)) then 
         cnt_dig <= cnt_dig + 1; 
      end if; 
   end process; 


   -- select the display sseg data abcdefg (active low) -----
   segments <= "00000011" when digit = "0000"  else
               "10011111" when digit = "0001"  else
               "00100101" when digit = "0010"  else
               "00001101" when digit = "0011"  else
               "10011001" when digit = "0100"  else
               "01001001" when digit = "0101"  else
               "01000001" when digit = "0110"  else
               "00011111" when digit = "0111"  else
               "00000001" when digit = "1000"  else
               "00001001" when digit = "1001"  else
			   "11111101" when digit = "1110" else   -- dash
			   "11111111" when digit = "1110" else   -- blank
               "11111111"; 

   -- actuate the correct display --------------------------
   disp_en <= "1110" when cnt_dig = "00" else 
              "1101" when cnt_dig = "01" else
              "1011" when cnt_dig = "10" else
              "0111" when cnt_dig = "11" else
              "1111"; 

 
	process (cnt_dig, lsd, msd, mmsd)
	   variable mmsd_v, msd_v : std_logic_vector(3 downto 0);    
	begin
	    mmsd_v := mmsd; 
		msd_v := msd; 
		
		-- do the lead zero blanking for two msb's
		if (mmsd_v = X"0") then 
		   if (msd_v = X"0") then 
			   msd_v := X"F"; 
			end if; 
		   mmsd_v := X"F"; 
		end if; 
		
		case cnt_dig is
			when "00" => digit <= "1111"; 
			when "01" => digit <= mmsd_v; 
			when "10" => digit <= msd_v; 
			when "11" => digit <= lsd; 
			when others => digit <= "0000"; 
		end case; 
		
	end process;
			

end my_sseg;

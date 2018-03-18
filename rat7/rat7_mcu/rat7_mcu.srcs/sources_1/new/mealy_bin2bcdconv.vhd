--------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--------------------------------------------------------------------
-- interface description for bin to bcd converter 
--------------------------------------------------------------------
entity mealy_bin2bcdconv is
    Port ( BIN_CNT_IN : in std_logic_vector(7 downto 0);
              LSD_OUT : out std_logic_vector(3 downto 0);
              MSD_OUT : out std_logic_vector(3 downto 0);
             MMSD_OUT : out std_logic_vector(3 downto 0));
end mealy_bin2bcdconv;

---------------------------------------------------------------------
-- description of 8-bit binary to 3-digit BCD converter 
---------------------------------------------------------------------
architecture my_ckt of mealy_bin2bcdconv is
begin
   process(bin_cnt_in)
       variable cnt_tot : INTEGER range 0 to 255 := 0; 
	    variable lsd,msd,mmsd : INTEGER range 0 to 9 := 0; 
   begin
	 
	 -- convert input binary value to decimal
	 cnt_tot := 0; 
    if (bin_cnt_in(7) = '1') then cnt_tot := cnt_tot + 128;  end if; 
    if (bin_cnt_in(6) = '1') then cnt_tot := cnt_tot +  64;  end if; 
    if (bin_cnt_in(5) = '1') then cnt_tot := cnt_tot +  32;  end if; 
    if (bin_cnt_in(4) = '1') then cnt_tot := cnt_tot +  16;  end if; 
    if (bin_cnt_in(3) = '1') then cnt_tot := cnt_tot +   8;  end if; 
    if (bin_cnt_in(2) = '1') then cnt_tot := cnt_tot +   4;  end if; 
    if (bin_cnt_in(1) = '1') then cnt_tot := cnt_tot +   2;  end if; 
    if (bin_cnt_in(0) = '1') then cnt_tot := cnt_tot +   1;  end if; 

	 -- initialize intermediate signals
    msd  := 0; 
	 mmsd := 0; 
	 lsd  := 0;
           
    --  calculate the MMSB
    for I in 1 to 2 loop
	    exit when (cnt_tot >= 0 and cnt_tot < 100); 
	    mmsd := mmsd + 1; -- increment the mmds count
	    cnt_tot := cnt_tot - 100;
    end loop; 
      	         
     --  calculate the MSB
    for I in 1 to 9 loop	     
       exit when (cnt_tot >= 0 and cnt_tot < 10); 
       msd := msd + 1; -- increment the mds count
	    cnt_tot := cnt_tot - 10;
    end loop; 
      	    
	 lsd := cnt_tot;   -- lsd is what is left over

	 -- convert lsd to binary
	 case lsd is 
	    when 9 =>  lsd_out <= "1001"; 
	    when 8 =>  lsd_out <= "1000"; 
	    when 7 =>  lsd_out <= "0111"; 
	    when 6 =>  lsd_out <= "0110"; 
	    when 5 =>  lsd_out <= "0101"; 
	    when 4 =>  lsd_out <= "0100"; 
	    when 3 =>  lsd_out <= "0011"; 
	    when 2 =>  lsd_out <= "0010"; 
	    when 1 =>  lsd_out <= "0001"; 
	    when 0 =>  lsd_out <= "0000"; 
	    when others =>  lsd_out <= "0000"; 
    end case; 

	 -- convert msd to binary
	 case msd is 
	    when 9 =>  msd_out <= "1001"; 
	    when 8 =>  msd_out <= "1000"; 
	    when 7 =>  msd_out <= "0111"; 
	    when 6 =>  msd_out <= "0110"; 
	    when 5 =>  msd_out <= "0101"; 
	    when 4 =>  msd_out <= "0100"; 
	    when 3 =>  msd_out <= "0011"; 
	    when 2 =>  msd_out <= "0010"; 
	    when 1 =>  msd_out <= "0001"; 
	    when 0 =>  msd_out <= "0000"; 
	    when others =>  msd_out <= "0000"; 
      end case; 

	 -- convert msd to binary
	 case mmsd is  
	    when 2 =>  mmsd_out <= "0010"; 
	    when 1 =>  mmsd_out <= "0001"; 
	    when 0 =>  mmsd_out <= "0000"; 
	    when others =>  mmsd_out <= "0000"; 
    end case; 

   end process; 
end my_ckt;



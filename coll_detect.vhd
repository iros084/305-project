library IEEE;
use  IEEE.STD_LOGIC_1164.all;
use  IEEE.STD_LOGIC_ARITH.all;
use  IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY coll_detect is
  	PORT (
		clk, bouncy_ball_on, pipe_on : IN std_logic;
		input: OUT std_logic
	);	
end coll_detect;


ARCHITECTURE Behaviour of coll_detect is  

 signal input_latch, coin_latch1, coin_latch2, coin_latch3 : std_logic := '0';
 
begin
  
    process(clk)
    begin
      
        if (rising_edge(clk)) then
       
          
          if(bouncy_ball_on = '1' and pipe_on = '1' and input_latch = '1') then 
            input <= '1';
            input_latch <= '0';
          else
              input <= '0';
              input_latch <= '1';
          end if;
        end if;     
    end process;
end architecture;
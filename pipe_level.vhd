library IEEE;
use  IEEE.STD_LOGIC_1164.all;
use  IEEE.STD_LOGIC_ARITH.all;
use  IEEE.STD_LOGIC_UNSIGNED.all;

entity pipe_level is
 port(clk, reset, count : IN std_logic;
	speed : OUT std_logic_vector(8 downto 0));
end entity;	

ARCHITECTURE Behaviour of pipe_level is
    signal level : std_logic;
    signal speed_out : std_logic_vector(8 downto 0);
    signal count_out : std_logic_vector(3 DOWNTO 0) := conv_std_logic_vector(0, 4);
begin
    process(clk)
        begin
           if(rising_edge(clk)) then
             if(level = '1' and count = '1' and (speed_out > conv_std_logic_vector(50, 9))) then
                if(count_out = conv_std_logic_vector(4, 4)) then
                    count_out <= conv_std_logic_vector(0, 4);
                    speed_out <= speed_out - conv_std_logic_vector(50, 9);
                else
                    count_out <= count_out + '1';
                end if;
            
                level <= '0';
            
             elsif(level = '0') then
                  level <= '1';
             end if;
          
             if(reset = '1') then
               count_out <= conv_std_logic_vector(0, 4);
               speed_out <= conv_std_logic_vector(300, 9);
               level <= '0';
             end if;
           end if;
         end process;
       speed <= speed_out;
end architecture;
    
library IEEE;
use  IEEE.STD_LOGIC_1164.all;
use  IEEE.STD_LOGIC_ARITH.all;
use  IEEE.STD_LOGIC_UNSIGNED.all;


entity rand_gen is 
  port(clk,rand_st: in std_logic;
        psudo: out std_logic_vector(8 downto 0);
end entity rang_gen;

architecture b1 of rand_gen is
   function lfsr(a : std_logic_vector(8 downto 0)) return std_logic_vector is
    begin
         return a(7 downto 0) & (a(0) xnor a(1) xnor a(5) xnor a(7));
   end function;
   
   signal s1: std_logic_vector(8 downto 0) := (others => '0');
   signal t_psudo: std_logic_vector(8 downto 0) := (others => '0');
begin
    process(clk,rand_st)
      begin 
          if(rising_edge(clk)) then
            s1 <= s1+1;
            t_psudo <= lfsr(t_psudo);
          elsif(rand_st = '0') then
               t_psudo <= s1;
          end if
       end process;
      psudo <= t_psudo
end architecture b1;



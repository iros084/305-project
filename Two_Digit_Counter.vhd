library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Two_Digit_Counter is
    port (clk, Init, Enable : in std_logic;
          t_out, f_out : out std_logic_vector(3 downto 0);
          display1, display2 : out std_logic_vector(6 downto 0)
    );
end entity;

architecture behaviour of Two_Digit_Counter is

signal f_d : std_logic := '1';
signal t_enable, f_enable : std_logic := '0';
signal t_t_enable, t_f_enable, t_t_latch, t_start : std_logic := '0';
signal s_t_out : std_logic_vector(3 downto 0) := "0000";
signal s_f_out : std_logic_vector(3 downto 0) := "0000";


component Four_bit_Counter is
    port (clk, Dir, Initial, Enable : in std_logic;
          Q_out : out std_logic_vector(3 downto 0));
end component Four_bit_Counter;

component BCD_to_7Seg is
     port (BCD_digit : in std_logic_vector(3 downto 0);
           SevenSeg_out : out std_logic_vector(6 downto 0));
end component BCD_to_7Seg;

begin
	tenth_counter : Four_bit_Counter port map(clk, f_d, Init, t_enable, s_t_out);
	first_counter : Four_bit_Counter port map(clk, f_d, Init, f_Enable, s_f_out);
	  
  --d_1: BCD_to_7Seg port map (BCD_digit => s_first_out, SevenSeg_out => display1);
 -- d_2: BCD_to_7Seg port map (BCD_digit => s_tenth_out, SevenSeg_out => display2);

  process(clk)
    begin
    
    if(rising_edge(clk)) then 
      if(enable = '1') then
        t_f_enable <= '1';
        
        if(s_f_out = "0000" and t_t_enable <= '0' and t_t_latch <= '0' and t_start = '1') then
          t_t_enable <= '1';
          t_t_latch <= '1';
        end if;
        
        if(s_f_out = "0001" and t_t_latch <= '1') then
          t_t_latch <= '0';
          t_start <= '0';
        end if;
        
        if(s_f_out = "1001") then
          t_start <= '1';
        end if;
        
      else
        t_f_enable <= '0';
        t_t_enable <= '0';
      end if;
    end if;
      
  end process;
  
  f_enable <= t_f_enable;
  t_enable <= t_t_enable;
	t_out <= s_t_out;
	f_out <= s_f_out;

end architecture;
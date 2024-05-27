library IEEE;
use  IEEE.STD_LOGIC_1164.all;
use  IEEE.STD_LOGIC_ARITH.all;
use  IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY life is
  	PORT (
		clk, rst, dir, col_detect: IN std_logic;
		pixel_row, pixel_col : IN std_logic_vector(9 downto 0);
		red, green, blue, ending : OUT std_logic
	);	
end life;

ARCHITECTURE Behaviour of life is
  

component SPRITE_PRINTER is
  port(pixel_row, pixel_col, a_row, a_col : in std_logic_vector(9 downto 0);
       s_red, s_green, s_blue : in std_logic;
       multiplier : in integer range 1 to 4;
       address : in std_logic_vector (5 downto 0);
       enable, clk : in std_logic;
       red_out, green_out, blue_out : out std_logic);
end component;
    
    component Four_bit_Counter is
       port (clk, Dir, Initial, Enable : in std_logic;
       Q_out : out std_logic_vector(3 downto 0));
    end component Four_bit_Counter;
    
    signal t_add_in : std_logic_vector(5 downto 0);
    signal t_count_out : std_logic_vector(3 downto 0);
    signal t_sprite_enable : std_logic := '1';
    signal multiplier : integer range 1 to 4 := 3;   
    signal t_red : std_logic := '0';
    signal t_green : std_logic := '1';
    signal t_blue : std_logic := '1';
    signal t_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(68, 10);
    signal t_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(540, 10); 
    signal t_red_out, t_green_out, t_blue_out : std_logic;      
    signal life_counter : std_logic_vector(3 downto 0) := "0011";	 
    
begin
   sprite_design: sprite_printer port map(pixel_row, pixel_col, 
                                           t_row, t_col,
                                           t_red, t_green, t_blue,
                                           multiplier, t_add_in,
                                           t_sprite_enable, clk,                           
                                           t_red_out, t_green_out, t_blue_out);
														 
														 
                                           
  -- counter : Four_bit_Counter port map(clk, '0', rst, col_detect, t_count_out);
	
	process (clk)
   begin
    if rising_edge(clk) then
        if rst = '1' then
            life_counter <= "0011"; -- or initial life value
        elsif (col_detect = '1') then
            if life_counter > "0000" then
                life_counter <= life_counter - 1;
            end if;
        end if;
    end if;
   end process;
     
   red <= t_red_out;
   green <= t_green_out;
   blue <= t_blue_out;
   
   t_add_in <= "11" & life_counter;
        
   ending <= '1' when (life_counter = "0000") else '0';   
	
                                                                                                                              
end architecture;
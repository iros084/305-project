LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;

entity BALL_SPRITE_PRINTER is
  
  port(pixel_row, pixel_col, a_row, a_col : in std_logic_vector(9 downto 0);
       s_red, s_green, s_blue             : in std_logic;
       multiplier                         : in integer range 1 to 4;
       address                            : in std_logic_vector (5 downto 0);
       enable, clk                        : in std_logic;
       red_out, green_out, blue_out       : out std_logic);
  
end entity;

architecture a of BALL_SPRITE_PRINTER is
  
  signal s_font_row : std_logic_vector(2 downto 0) := "000"; --row 0 is the top row
  signal s_font_col : std_logic_vector(2 downto 0) := "000"; --col 0 is the far right col
  signal s_rom_mux_output : std_logic;
  
  component ball_sprite is
    port (character_address	 :	in std_logic_vector (5 downto 0);
		      font_row, font_col :	in std_logic_vector (2 downto 0);
		      clock				    : in std_logic ;
		      rom_mux_output		 :	out std_logic);
	end component;
  
begin

	SPRITE_ROM: ball_sprite port map (character_address => address, font_row => s_font_row, font_col => s_font_col,  clock => clk, rom_mux_output => s_rom_mux_output);
	process (s_red, s_green, s_blue, pixel_row, a_row, pixel_col, a_col, s_rom_mux_output)
		variable range1 : integer range 0 to 8 := 0;
	begin
		 if(enable = '1') then      
			  case multiplier is
					when 1 => range1 := 1;
					when 2 => range1 := 2;
					when 3 => range1 := 4;
					when 4 => range1 := 8;
					when others => range1 := 0;
			  end case; 
			  
			  if (pixel_row < (a_row + 8*range1)) and (a_row <= pixel_row) then
					if(pixel_col < (a_col + 8*range1)) and (a_col <= pixel_col) then
						 s_font_row <= (pixel_row(multiplier+1 downto multiplier-1) - a_row(multiplier+1 downto multiplier-1));
						 s_font_col <= (pixel_col(multiplier+1 downto multiplier-1) - a_col(multiplier+1 downto multiplier-1));
					else
						 s_font_col <= "000";
						 s_font_row <= "000";
					end if;
			  else
					s_font_col <= "000";
					s_font_row <= "000";
			  end if;
			
			  red_out <= not(s_red and s_rom_mux_output);
			  green_out <= not(s_green and s_rom_mux_output);
			  blue_out <= not(s_blue and s_rom_mux_output); 
			  
		 else
			  red_out <= '1';
			  green_out <= '1';
			  blue_out <= '1';  
		 end if;
	end process;

end a;
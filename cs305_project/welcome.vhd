LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;


entity welcome is
  port (pixel_row, pixel_col : in std_logic_vector(9 downto 0);
        Enable, CLK : in std_logic;
        welcome_out: out std_logic);
end entity welcome;

architecture behaviour of welcome is 
  signal font_row : std_logic_vector(2 downto 0) := "000"; --row 0 is the top row
  signal font_col : std_logic_vector(2 downto 0) := "000"; --col 0 is the far right col
  signal cr_out : std_logic;
  signal character_address : std_logic_vector(5 downto 0);
  
  component CHAR_ROM is 
    port (character_address	:	in std_logic_vector (5 downto 0);
		      font_row, font_col	:	in std_logic_vector (2 downto 0);
		      clock				: 	in std_logic ;
		      rom_mux_output		:	out std_logic);
	end component;

begin
  SPRITE_ROM:CHAR_ROM port map (character_address, font_row, font_col,  clk, rom_mux_output=>cr_out);
  
  process (clk,Enable)
    begin
         if(rising_edge(clk) and Enable = '1') then
             if (pixel_row >= CONV_STD_LOGIC_VECTOR(160,10) and pixel_row < CONV_STD_LOGIC_VECTOR(192,10)
	     and pixel_col >= CONV_STD_LOGIC_VECTOR(224,10) and pixel_col < CONV_STD_LOGIC_VECTOR(256,10)) then 
             character_address <= "011011"; -- W
             welcome_out <= cr_out;
          
          elsif( pixel_row >=  CONV_STD_LOGIC_VECTOR(192,10) and pixel_row <  CONV_STD_LOGIC_VECTOR(224,10) 
	   and pixel_col >=  CONV_STD_LOGIC_VECTOR(224,10) and pixel_col <  CONV_STD_LOGIC_VECTOR(256,10)) then
              character_address <="000101"; -- E
              welcome_out <= cr_out;
  
          elsif( pixel_row >=  CONV_STD_LOGIC_VECTOR(224,10) and pixel_row <  CONV_STD_LOGIC_VECTOR(256,10) 
	    and pixel_col >=  CONV_STD_LOGIC_VECTOR(224,10) and pixel_col <  CONV_STD_LOGIC_VECTOR(256,10)) then
              character_address <="000101"; -- L
              welcome_out <= cr_out;
 
         elsif( pixel_row >=  CONV_STD_LOGIC_VECTOR(256,10) and pixel_row <  CONV_STD_LOGIC_VECTOR(288,10) 
	   and pixel_col >=  CONV_STD_LOGIC_VECTOR(224,10) and pixel_col <  CONV_STD_LOGIC_VECTOR(256,10)) then
              character_address <="000011"; -- C
              welcome_out <= cr_out;

         elsif (pixel_row >= CONV_STD_LOGIC_VECTOR(288,10) and pixel_row < CONV_STD_LOGIC_VECTOR(320,10)
	     and pixel_col >= CONV_STD_LOGIC_VECTOR(224,10) and pixel_col < CONV_STD_LOGIC_VECTOR(256,10)) then 
             character_address <= "010001"; -- 0
             welcome_out <= cr_out;


          elsif( pixel_row >=  CONV_STD_LOGIC_VECTOR(320,10) and pixel_row <  CONV_STD_LOGIC_VECTOR(352,10) 
	   and pixel_col >=  CONV_STD_LOGIC_VECTOR(224,10) and pixel_col <  CONV_STD_LOGIC_VECTOR(256,10)) then
              character_address <="001111"; -- M
              welcome_out <= cr_out;

          elsif( pixel_row >=  CONV_STD_LOGIC_VECTOR(352,10) and pixel_row <  CONV_STD_LOGIC_VECTOR(384,10) 
	   and pixel_col >=  CONV_STD_LOGIC_VECTOR(224,10) and pixel_col <  CONV_STD_LOGIC_VECTOR(256,10)) then
              character_address <="000101"; -- E
              welcome_out <= cr_out;
          else 
            welcome_out <= '0';
          end if; 
         end if;
      
  end process;
        font_row<=pixel_row(4 downto 2);
	font_col<=pixel_col(4 downto 2); 
end architecture;  
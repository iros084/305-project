LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;

entity start is
    port(pixel_row, pixel_col : in std_logic_vector(9 downto 0);
	       Clk, enable, mode_sel  : in std_logic;  -- if mode sel is '1', its game mode/ '0' is tutorial mode
         Red_out1, Green_out1, Blue_out1 : out std_logic);

end entity start;

architecture behaviour of start is

-- Signals for 2 digit counter
signal title_f_address : std_logic_vector(5 downto 0) := "000110";
signal title_l_address : std_logic_vector(5 downto 0) := "001100";
signal title_a_address : std_logic_vector(5 downto 0) := "000001";
signal title_p_address : std_logic_vector(5 downto 0) := "010000";
signal title_p1_address : std_logic_vector(5 downto 0) := "010000";
signal title_y_address : std_logic_vector(5 downto 0) := "011001";
signal title_b_address : std_logic_vector(5 downto 0) := "000010";
signal title_i_address : std_logic_vector(5 downto 0) := "001001";
signal title_r_address : std_logic_vector(5 downto 0) := "010010";
signal title_d_address : std_logic_vector(5 downto 0) := "000100";
signal t_a_address : std_logic_vector(5 downto 0) := "000001";


-- Signals for Sprite printing 
-- F L A P P Y B I R D
signal title_f_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(120, 10);
signal title_f_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(48, 10);
signal title_l_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(120, 10);
signal title_l_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(144, 10);
signal title_a_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(120, 10);
signal title_a_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(240, 10);
signal title_p_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(120, 10);
signal title_p_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(335, 10);
signal title_p1_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(120, 10);
signal title_p1_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(432, 10);
signal title_y_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(120, 10);
signal title_y_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(528, 10);
signal title_b_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(200, 10);
signal title_b_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(144, 10);
signal title_i_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(200, 10);
signal title_i_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(240, 10);
signal title_r_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(200, 10);
signal title_r_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(335, 10);
signal title_d_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(200, 10);
signal title_d_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(432, 10);

signal play_p_address : std_logic_vector(5 downto 0) := "010000";
signal play_l_address : std_logic_vector(5 downto 0) := "001100";
signal play_a_address : std_logic_vector(5 downto 0) := "000001";
signal play_y_address : std_logic_vector(5 downto 0) := "011001";
signal s1_ad : std_logic_vector(5 downto 0) := "010011";
signal w1_ad :  std_logic_vector(5 downto 0) := "010111";
signal o1_ad : std_logic_vector(5 downto 0) := "110000";
signal o11_ad : std_logic_vector(5 downto 0) := "110001";

signal tut_t_address : std_logic_vector(5 downto 0) := "010100";
signal tut_u_address : std_logic_vector(5 downto 0) := "010101";
signal tut_t1_address : std_logic_vector(5 downto 0) := "010100";
signal tut_o_address : std_logic_vector(5 downto 0) := "001111";
signal tut_r_address : std_logic_vector(5 downto 0) := "010010";
signal tut_i_address : std_logic_vector(5 downto 0) := "001001";
signal tut_a_address : std_logic_vector(5 downto 0) := "000001";
signal tut_l_address : std_logic_vector(5 downto 0) := "001100";
signal s2_ad : std_logic_vector(5 downto 0) := "010011";
signal w2_ad : std_logic_vector(5 downto 0) := "010111";
signal o12_ad : std_logic_vector(5 downto 0) := "110000";
signal o112_ad : std_logic_vector(5 downto 0) := "110000";

-- P L A Y
signal play_p_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(320, 10);
signal play_p_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(40, 10);
signal play_l_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(320, 10);
signal play_l_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(80,10);
signal play_a_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(320, 10);
signal play_a_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(120, 10);
signal play_y_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(320, 10);
signal play_y_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(160, 10);
signal s_a_row: std_logic_vector(9 downto 0) := conv_std_logic_vector(320, 10);
signal s_a_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(200, 10);
signal w_a_row: std_logic_vector(9 downto 0) := conv_std_logic_vector(320, 10);
signal w_a_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(232, 10);
signal o1_a_row: std_logic_vector(9 downto 0) := conv_std_logic_vector(320, 10);
signal o1_a_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(264, 10);
signal o11_a_row: std_logic_vector(9 downto 0) := conv_std_logic_vector(320, 10);
signal o11_a_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(300, 10);


-- T U T O R I A L
signal tut_t_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(400, 10);
signal tut_t_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(32, 10);
signal tut_u_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(400, 10);
signal tut_u_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(64,10);
signal tut_t1_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(400, 10);
signal tut_t1_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(96, 10);
signal tut_o_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(400, 10);
signal tut_o_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(128, 10);
signal tut_r_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(400, 10);
signal tut_r_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(160, 10);
signal tut_i_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(400, 10);
signal tut_i_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(192, 10);
signal tut_a_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(400, 10);
signal tut_a_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(224,10);
signal tut_l_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(400, 10);
signal tut_l_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(256, 10);
signal s1_a_row: std_logic_vector(9 downto 0) := conv_std_logic_vector(400, 10);
signal s1_a_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(300, 10);
signal w1_a_row: std_logic_vector(9 downto 0) := conv_std_logic_vector(400, 10);
signal w1_a_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(332, 10);
signal o112_a_row: std_logic_vector(9 downto 0) := conv_std_logic_vector(400, 10);
signal o112_a_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(364, 10);
signal o111_a_row: std_logic_vector(9 downto 0) := conv_std_logic_vector(400, 10);
signal o111_a_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(400, 10);

-- Flappy BIRD RGB
signal title_f_Red, title_f_Green, title_f_Blue,
       title_l_Red, title_l_Green, title_l_Blue,
       title_a_Red, title_a_Green, title_a_Blue,
       title_p_Red, title_p_Green, title_p_Blue,
       title_p1_Red, title_p1_Green, title_p1_Blue,
       title_y_Red, title_y_Green, title_y_Blue,
       title_b_Red, title_b_Green, title_b_Blue,
       title_i_Red, title_i_Green, title_i_Blue,
       title_r_Red, title_r_Green, title_r_Blue,
       title_d_Red, title_d_Green, title_d_Blue: std_logic;
		 
-- Play RGB
signal play_P_R_out, play_p_G_out, play_p_B_out,
       play_L_R_out, play_l_G_out, play_l_B_out,
       play_A_R_out, play_a_G_out, play_a_B_out,
       play_Y_R_out, play_y_G_out, play_y_B_out: std_logic;
       
-- PLAY RGB
signal tut_T_R_out, tut_T_G_out, tut_T_B_out,
       tut_U_R_out, tut_U_G_out, tut_U_B_out,
       tut_T1_R_out, tut_T1_G_out, tut_T1_B_out,
       tut_O_R_out, tut_O_G_out, tut_O_B_out,
       tut_R_R_out, tut_R_G_out, tut_R_B_out,
       tut_I_R_out, tut_I_G_out, tut_I_B_out,
       tut_A_R_out, tut_A_G_out, tut_A_B_out,
       tut_L_R_out, tut_L_G_out, tut_L_B_out : std_logic;
		 
signal s1_r,s1_g,s1_b,w1_r,w1_g,w1_b,o1_r,o1_g,o1_b,o11_r,o11_g,o11_b,s11_r,s11_g,s11_b,w11_r,w11_g,w11_b,o112_r,o112_g,o112_b,o111_r,o111_g,o111_b:std_logic;
            
signal Font_R : std_logic := '1';
Signal Font_G : std_logic := '1';
Signal Font_B : std_logic := '1';
signal t_enable : std_logic := '1';

Signal Font_Multiplier : integer := 4;
signal select_multiplier : integer := 3;

component Sprite_Printer is	
  port(pixel_row, pixel_col, a_row, a_col : in std_logic_vector(9 downto 0);
       s_red, s_green, s_blue : in std_logic;
       multiplier : in integer range 1 to 4;
       address : in std_logic_vector (5 downto 0);
       enable, clk : in std_logic;
       red_out, green_out, blue_out : out std_logic);
end component Sprite_printer;

	begin
     title_f: sprite_printer port map(pixel_row, pixel_col, title_f_row, title_f_col, Font_R, Font_G, Font_B, Font_Multiplier, title_f_address, t_enable, CLK, title_f_Red, title_f_Green, title_f_Blue);
	  title_l: sprite_printer port map(pixel_row, pixel_col, title_l_row, title_l_col, Font_R, Font_G, Font_B, Font_Multiplier, title_l_address, t_enable, CLK, title_l_Red, title_l_Green, title_l_Blue);
	  title_a: sprite_printer port map(pixel_row, pixel_col, title_a_row, title_a_col, Font_R, Font_G, Font_B, Font_Multiplier, title_a_address, t_enable, CLK, title_a_Red, title_a_Green, title_a_Blue);
	  title_p: sprite_printer port map(pixel_row, pixel_col, title_p_row, title_p_col, Font_R, Font_G, Font_B, Font_Multiplier, title_p_address, t_enable, CLK, title_p_Red, title_p_Green, title_p_Blue);
 	  title_p1: sprite_printer port map(pixel_row, pixel_col, title_p1_row, title_p1_col, Font_R, Font_G, Font_B, Font_Multiplier, title_p1_address, t_enable, CLK, title_p1_Red, title_p1_Green, title_p1_Blue);
	  title_y: sprite_printer port map(pixel_row, pixel_col, title_y_row, title_y_col, Font_R, Font_G, Font_B, Font_Multiplier, title_y_address, t_enable, CLK, title_y_Red, title_y_Green, title_y_Blue);
	  title_b: sprite_printer port map(pixel_row, pixel_col, title_b_row, title_b_col, Font_R, Font_G, Font_B, Font_Multiplier, title_b_address, t_enable, CLK, title_b_Red, title_b_Green, title_b_Blue);
	  title_i: sprite_printer port map(pixel_row, pixel_col, title_i_row, title_i_col, Font_R, Font_G, Font_B, Font_Multiplier, title_i_address, t_enable, CLK, title_i_Red, title_i_Green, title_i_Blue);
	  title_r: sprite_printer port map(pixel_row, pixel_col, title_r_row, title_r_col, Font_R, Font_G, Font_B, Font_Multiplier, title_r_address, t_enable, CLK, title_r_Red, title_r_Green, title_r_Blue);
	  title_d: sprite_printer port map(pixel_row, pixel_col, title_d_row, title_d_col, Font_R, Font_G, Font_B, Font_Multiplier, title_d_address, t_enable, CLK, title_d_Red, title_d_Green, title_d_Blue);
	 
	   play_p: sprite_printer port map(pixel_row, pixel_col, play_p_row, play_p_col, Font_R, Font_G, Font_B, select_Multiplier, play_p_address, enable, CLK, play_p_R_out, play_p_G_out, play_p_B_out);
		play_l: sprite_printer port map(pixel_row, pixel_col, play_l_row, play_l_col, Font_R, Font_G, Font_B, select_Multiplier, play_l_address, enable, CLK, play_l_R_out, play_l_G_out, play_l_B_out);
		play_a: sprite_printer port map(pixel_row, pixel_col, play_a_row, play_a_col, Font_R, Font_G, Font_B, select_Multiplier, play_a_address, enable, CLK, play_a_R_out, play_a_G_out, play_a_B_out);
		play_y: sprite_printer port map(pixel_row, pixel_col, play_y_row, play_y_col, Font_R, Font_G, Font_B, select_Multiplier, play_y_address, enable, CLK, play_y_R_out, play_y_G_out, play_y_B_out);
s1_a: sprite_printer port map(pixel_row, pixel_col, s_a_row, s_a_col, Font_R, Font_G, Font_B, select_Multiplier, s1_ad, enable, CLK, s1_r,s1_g,s1_b);
		w1_a: sprite_printer port map(pixel_row, pixel_col, w_a_row, w_a_col, Font_R, Font_G, Font_B, select_Multiplier, w1_ad, enable, CLK, w1_r,w1_g,w1_b);
		o1_a: sprite_printer port map(pixel_row, pixel_col, o1_a_row, o1_a_col, Font_R, Font_G, Font_B, select_Multiplier, o1_ad, enable, CLK, o1_r,o1_g,o1_b);
		o11_a: sprite_printer port map(pixel_row, pixel_col, o11_a_row, o11_a_col, Font_R, Font_G, Font_B, select_Multiplier, o11_ad, enable, CLK, o11_r,o11_g,o11_b);
		
		
		
		
		tut_t: sprite_printer port map(pixel_row, pixel_col, tut_t_row, tut_t_col, Font_R, Font_G, Font_B, select_Multiplier, tut_t_address, enable, CLK, tut_t_R_out, tut_t_G_out, tut_t_B_out);
		tut_u: sprite_printer port map(pixel_row, pixel_col, tut_u_row, tut_u_col, Font_R, Font_G, Font_B, select_Multiplier, tut_u_address, enable, CLK, tut_u_R_out, tut_u_G_out, tut_u_B_out);
		tut_t1: sprite_printer port map(pixel_row, pixel_col, tut_t1_row, tut_t1_col, Font_R, Font_G, Font_B, select_Multiplier, tut_t1_address, enable, CLK, tut_t1_R_out, tut_t1_G_out, tut_t1_B_out);
		tut_o: sprite_printer port map(pixel_row, pixel_col, tut_o_row, tut_o_col, Font_R, Font_G, Font_B, select_Multiplier, tut_o_address, enable, CLK, tut_o_R_out, tut_o_G_out, tut_o_B_out);
		tut_r: sprite_printer port map(pixel_row, pixel_col, tut_r_row, tut_r_col, Font_R, Font_G, Font_B, select_Multiplier, tut_r_address, enable, CLK, tut_r_R_out, tut_r_G_out, tut_r_B_out);
		tut_i: sprite_printer port map(pixel_row, pixel_col, tut_i_row, tut_i_col, Font_R, Font_G, Font_B, select_Multiplier, tut_i_address, enable, CLK, tut_i_R_out, tut_i_G_out, tut_i_B_out);
		tut_a: sprite_printer port map(pixel_row, pixel_col, tut_a_row, tut_a_col, Font_R, Font_G, Font_B, select_Multiplier, tut_a_address, enable, CLK, tut_a_R_out, tut_a_G_out, tut_a_B_out);
		tut_l: sprite_printer port map(pixel_row, pixel_col, tut_l_row, tut_l_col, Font_R, Font_G, Font_B, select_Multiplier, tut_l_address, enable, CLK, tut_l_R_out, tut_l_G_out, tut_l_B_out);
		s12_a: sprite_printer port map(pixel_row, pixel_col, s1_a_row, s1_a_col, Font_R, Font_G, Font_B, select_Multiplier, s1_ad, enable, CLK, s11_r,s11_g,s11_b);
		w12_a: sprite_printer port map(pixel_row, pixel_col, w1_a_row, w1_a_col, Font_R, Font_G, Font_B, select_Multiplier, w1_ad, enable, CLK, w11_r,w11_g,w11_b);
		o12_a: sprite_printer port map(pixel_row, pixel_col, o112_a_row, o112_a_col, Font_R, Font_G, Font_B, select_Multiplier, o1_ad, enable, CLK, o112_r,o112_g,o112_b);
		o112_a: sprite_printer port map(pixel_row, pixel_col, o111_a_row, o111_a_col, Font_R, Font_G, Font_B, select_Multiplier, o112_ad, enable, CLK, o111_r,o111_g,o111_b);
		
		
		
    Red_out1 <= title_f_Red and title_l_Red and title_a_Red and title_p_Red and title_p1_Red and title_y_Red and title_b_Red and title_i_Red and title_r_Red and title_d_Red and play_p_R_out and play_l_R_out and play_a_R_out and play_y_R_out and tut_t_R_out and tut_u_R_out and tut_t1_R_out and tut_o_R_out and tut_r_R_out and tut_i_R_out and tut_a_R_out and tut_l_R_out and s1_r and w1_r and o1_r and o11_r and s11_r and w11_r and o112_r and o111_r; 
    Green_out1 <= title_f_Green and title_l_Green and title_a_Green and title_p_Green and title_p1_Green and title_y_Green and title_b_Green and title_i_Green and title_r_Green and title_d_Green and play_p_G_out and play_l_G_out and play_a_G_out and play_y_G_out and tut_t_G_out and tut_u_G_out and tut_t1_G_out and tut_o_G_out and tut_r_G_out and tut_i_G_out and tut_a_G_out and tut_l_G_out and s1_g and w1_g and o1_g and o11_g and s11_g and w11_g and o112_g and o111_g ; 
    Blue_out1 <= title_f_Blue and title_l_Blue and title_a_Blue and title_p_Blue and title_p1_Blue and title_y_Blue and title_b_Blue and title_i_Blue and title_r_Blue and title_d_Blue and play_p_B_out and play_l_B_out and play_a_B_out and play_y_B_out and tut_t_B_out and tut_u_B_out and tut_t1_B_out and tut_o_B_out and tut_r_B_out and tut_i_B_out and tut_a_B_out and tut_l_B_out and s1_b and w1_b and o1_b and o11_b and s11_b and w11_b and o112_b and o111_b; 
end architecture;
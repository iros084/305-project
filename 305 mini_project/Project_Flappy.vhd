library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity Project_Flappy is
          port (CLK, pb1, pb2 : in std_logic;
          		  red_out, green_out, blue_out, horiz_sync_out, vert_sync_out	: OUT	STD_LOGIC);
end entity Project_Flappy;


architecture Test of Project_Flappy is

    signal t_pixel_row: STD_LOGIC_VECTOR(9 DOWNTO 0);
    signal t_pixel_column: STD_LOGIC_VECTOR(9 DOWNTO 0);
    signal t_red, t_green, t_blue, t_clkDiv, t_vert_sync_out, t_horiz_sync_out: STD_LOGIC;

    component VGA_SYNC is
	   PORT(	clock_25Mhz, red, green, blue		: IN	STD_LOGIC;
		  red_out, green_out, blue_out, horiz_sync_out, vert_sync_out	: OUT	STD_LOGIC;
		  pixel_row, pixel_column: OUT STD_LOGIC_VECTOR(9 DOWNTO 0));
    end component;

    begin 

    vert_sync_out <= t_vert_sync_out;
    horiz_sync_out <= t_horiz_sync_out;
    t_red <= '1';
    t_green <= '1';
    t_blue <= '1';

    vga_design: VGA_SYNC port map (t_clkDiv, t_red, t_green, t_blue,
		                              red_out, green_out, blue_out, t_horiz_sync_out, t_vert_sync_out,
			                            t_pixel_row, t_pixel_column);
    
end architecture Test;
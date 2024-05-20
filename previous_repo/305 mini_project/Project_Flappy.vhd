library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity miniproject is
    port (
        CLK, pb1, pb2 : in std_logic;
        red_out, green_out, blue_out, horiz_sync_out, vert_sync_out: out std_logic
    );
end entity miniproject;

architecture Test of miniproject is

    signal t_pixel_row: std_logic_vector(9 downto 0);
    signal t_pixel_column: std_logic_vector(9 downto 0);
    signal t_red, t_green, t_blue, t_clkDiv, t_vert_sync_out, t_horiz_sync_out: std_logic;

    component VGA_SYNC is
        port (
            clock_25Mhz, red, green, blue: in std_logic;
            red_out, green_out, blue_out, horiz_sync_out, vert_sync_out: out std_logic;
            pixel_row, pixel_column: out std_logic_vector(9 downto 0)
        );
    end component;
    component clk_25M is
      PORT(clk_in : in std_logic;
              clk_out : out std_logic);
    end component;

begin 

    vert_sync_out <= t_vert_sync_out;
    horiz_sync_out <= t_horiz_sync_out;
    t_red <= '1';
    t_green <= '1';
    t_blue <= '1';
   
	 div_design: clk_25M port map (CLK, t_clkDiv);
    vga_design: VGA_SYNC port map (t_clkDiv, t_red, t_green, t_blue, red_out, green_out, blue_out, t_horiz_sync_out, t_vert_sync_out, t_pixel_row, t_pixel_column);
    
end architecture Test;
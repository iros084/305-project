library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity cs305_project_tb is
end entity;

architecture testbench of cs305_project_tb is
    signal Clk, pb0, pb1, pb2, pb3 : std_logic := '0';
    signal red_out, green_out, blue_out, horiz_sync_out, vert_sync_out : std_logic;
    signal mouse_data, mouse_clk : std_logic;
    
    signal count_en_tb : std_logic := '0';
    signal count_ones_tb : std_logic_vector(3 downto 0);
    signal count_tens_tb : std_logic_vector(3 downto 0);
begin
    uut: entity work.cs305_project
        port map (
            Clk => Clk,
            pb0 => pb0,
            pb1 => pb1,
            pb2 => pb2,
            pb3 => pb3,
            red_out => red_out,
            green_out => green_out,
            blue_out => blue_out,
            horiz_sync_out => horiz_sync_out,
            vert_sync_out => vert_sync_out,
            mouse_data => mouse_data,
            mouse_clk => mouse_clk
        );

    -- Clock generation
    Clk_process : process
    begin
        Clk <= '0';
        wait for 10 ns;
        Clk <= '1';
        wait for 10 ns;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Apply reset
        pb0 <= '1';
        wait for 20 ns;
        pb0 <= '0';
        
        -- Simulate counting
        wait for 100 ns;
        
        -- Apply count enable signal
        count_en_tb <= '1';
        wait for 100 ns;
        count_en_tb <= '0';
        
        wait;
    end process;
    
end architecture;

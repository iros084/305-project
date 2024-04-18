library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity clk_1_1 is
    port (
        Clk_in, Start_in: in std_logic;
        Clk_out: out std_logic
    );
end entity clk_1_1;

architecture behaviour of clk_1_1 is
begin
    process(Clk_in, Start_in)
    begin
        if (Start_in = '1') then
            Clk_out <= '0', '1' after 1 ns, Clk_in after 2 ns;
        else
            Clk_out <= Clk_in;
        end if;
    end process;
end architecture behaviour;

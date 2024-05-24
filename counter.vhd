library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity counter is
    port(
        clk       : in std_logic;
        reset     : in std_logic;
        count_en  : in std_logic;
        count_ones: out std_logic_vector(3 downto 0);
        count_tens: out std_logic_vector(3 downto 0)
    );
end entity;

architecture Behavioral of counter is
    signal ones : std_logic_vector(3 downto 0) := (others => '0');
    signal tens : std_logic_vector(3 downto 0) := (others => '0');
begin
    process(clk, reset,count_en)
    begin
        if reset = '1' then
            ones <= (others => '0');
            tens <= (others => '0');
        elsif rising_edge(clk) then
            if count_en = '1' then
                if ones = "1001" then
                    ones <= "0000";
                    if tens = "1001" then
                        tens <= "0000";
                    else
                        tens <= tens + 1;
                    end if;
                else
                    ones <= ones + 1;
                end if;
            end if;
        end if;
    end process;

    count_ones <= ones;
    count_tens <= tens;
end architecture;


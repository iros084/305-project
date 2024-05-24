

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Binary_UpDownCounter is
     port(
        clk, direction, enable, init: in std_logic;
        counter: out std_logic_vector (3 downto 0)
     );
end Binary_UpDownCounter;

architecture behavior of Binary_UpDownCounter is
     signal counter_Binary: std_logic_vector (3 downto 0);
begin

    process(clk)
    begin
        if rising_edge(clk) then 
	if init = '1' then
                if direction = '0' then                    
                        counter_Binary <= "0000";                    
                else                    
                        counter_Binary <= "1001";
                   
                end if;
	elsif enable = '1' then 
                if direction = '0' then
                    if counter_Binary < "1001" then
                        counter_Binary <= counter_Binary + 1;
                    else
                        counter_Binary <= "0000";
                    end if;
                else
                    if counter_Binary > "0000" then
                        counter_Binary <= counter_Binary - 1;
                    else
                        counter_Binary <= "1001";
                    end if;
                end if;
            end if; 
        end if;
    end process;

    counter <= counter_Binary;
end architecture behavior;

                     
               
      
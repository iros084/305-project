library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Four_bit_Counter is
    port (clk, Direction, Init, Enable : in std_logic;
          Q_out : out std_logic_vector(3 downto 0)
    );
end entity;

architecture behaviour of Four_bit_Counter is

  signal enable_latch : std_logic;

begin
    	process (clk, init)
		variable v_Q : std_logic_vector(3 downto 0);
	begin
	  
		if(rising_edge(clk)) then
		
		  if (init = '1') then
			 case Direction is
					 when '0' =>	
						  v_Q := "1001";	
					 when '1' =>
						  v_Q := "0000";
					 when others => null;
				  end case;
		  end if;
		
		  if(enable = '1' and enable_latch = '1') then
				case Direction is
					when '0' =>	
						if(v_Q = "0000") then
							v_Q := "1001";	
						else
							v_Q := v_Q - 1;
						end if;
					when '1' =>
						if(v_Q = "1001") then
							v_Q := "0000";
						else
							v_Q := v_Q + 1;
						end if;
					when others => null;
				end case;
				
				enable_latch <= '0';
				
			elsif(enable = '0') then
			 enable_latch <= '1';
			end if;
			
			Q_out <= v_Q;
		end if;
	end process;
end architecture;
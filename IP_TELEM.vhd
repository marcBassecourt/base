library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity IP_TELEM is port( 
	echo, rst, clk : in std_logic; -- clk = 50 MHz -> Tclk = 20ns
	trig : out std_logic;
	LEDR : out std_logic_vector(7 downto 0));
end entity;

architecture RTL of IP_TELEM is
	signal Q1,flag, flag2 : std_logic;
	signal cpt1,taille,cpt2 : integer; --compteur pour signal echo
	begin
	process(rst,clk)
		begin
		if rst = '1' then
			trig <= '0'; 
			Q1<='0'; 
			taille <= 0;
			flag <='0';
			cpt1 <= 0;
			cpt2 <= 0;
		Elsif rising_edge(clk) then
			if (flag = '0') then
				if(cpt1 < 500) then
					trig <= '1';
					cpt1 <= cpt1 + 1;
				else
					flag <= '1';
					cpt1 <= 0;
					trig <= '0';
				End if;
			elsif (flag = '1') then
				Q1 <= echo;
				if(Q1 = '1') then
					cpt2 <= cpt2 + 1;
					flag2 <= '1';
				elsif(Q1 = '0' and flag2 = '1') then
					taille <= cpt2;
					flag <= '0';
					flag2 <= '0';
					cpt2 <= 0;
				End if;
			End if;
			LEDR <= std_logic_vector(to_unsigned(taille*255/2000000,8));
		End if;
	End process;
End architecture;
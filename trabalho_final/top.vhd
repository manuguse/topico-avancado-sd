library ieee;
use ieee.std_logic_1164.all;

entity top is
	port(
		SW: in std_logic_vector(17 downto 0);
		LEDR: out std_logic_vector(17 downto 0)
	);
end entity;

architecture tp of top is

	component mux2_1 is generic(n :positive:=4);
	port ( a : in std_logic_vector (n-1 downto 0);
			 b : in std_logic_vector (n-1 downto 0);
			 sel : in std_logic;
			 s : out std_logic_vector (n-1 downto 0));
	end component;

	component volume is 
	port(
		raio: in std_logic_vector(3 downto 0);
		volume_int: out std_logic_vector(13 downto 0);
		volume_dec: out std_logic_vector(1 downto 0));
	end component;

	component area is 
	port(    
		raio: in std_logic_vector(3 downto 0);
		area_int: out std_logic_vector(9 downto 0);
		area_dec: out std_logic_vector(2 downto 0));
	end component;
	
	signal out_area, out_volume: std_logic_vector(17 downto 0);

	signal area_int: std_logic_vector(9 downto 0);
	signal area_dec: std_logic_vector(2 downto 0);
	signal volume_int: std_logic_vector(13 downto 0);
	signal volume_dec: std_logic_vector(1 downto 0);
	
begin

	calculo_area: area port map(
		SW(3 downto 0), area_int, area_dec);
	
	calculo_volume: volume port map(
		SW(3 downto 0), volume_int, volume_dec);
		
	out_area <= "0000" & area_int & '0' & area_dec;
	out_volume <= volume_int & '0' & volume_dec & '0';

	mux_saida: mux2_1 
	generic map(n => 18)
	port map(
		out_area, out_volume, SW(17), LEDR(17 downto 0));
	

end architecture;
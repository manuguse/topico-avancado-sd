library IEEE;
use IEEE.STD_LOGIC_1164.all;
 
entity multiplier is
	port(
		SW: in std_logic_vector(15 downto 0);
		LEDR: out std_logic_vector(15 downto 0)
		HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,HEX6,HEX7: out std_logic_vector(6 downto 0)
		);
end entity;
 
architecture mult of multiplier is
 
component traditionalSystem_BinToRNS is
	generic (n : natural := 4);
	port(SW    : in STD_LOGIC_VECTOR(15 downto 0);
		  cpa17: out STD_LOGIC_VECTOR(4 downto 0);
		  cpa15: out STD_LOGIC_VECTOR(3 downto 0);
		  cpa256: out STD_LOGIC_VECTOR(8 downto 0);
end component;

component traditionalSystem_RNStoBin is
	generic (n : natural := 4);
	port(R1: in std_LOGIC_VECTOR(7 downto 0);
		  R2: in std_LOGIC_VECTOR(11 downto 0);
		  R3: in std_LOGIC_VECTOR(16 downto 12);
		  output : out STD_LOGIC_VECTOR(17 downto 0);
end component;

component mux4_1 is
	generic(n :positive:=8);
	port ( A, B, C, D : in STD_LOGIC_VECTOR (n-1 downto 0)
          sel : in STD_LOGIC;
          S : out STD_LOGIC_VECTOR (n-1 downto 0));
end component;

signal n256_out,: std_LOGIC_VECTOR(7 downto 0);
signal n15_out, n15_in: std_LOGIC_VECTOR(3 downto 0);
signal n17_out,: std_LOGIC_VECTOR(4 downto 0);
signal A_15, B_15, C_15, D_15(8 downto 0);
 
 begin
 
 n15_in <= -- calcular
 
 mux4: mux4_1 
 port map(
	A_15, B_15, C_15, D_15, SW(15 downto 14), n15_in -- descobrir o que btoar no sel
 );
 
 bin_rns: traditionalSystem_BinToRNS 
 port map (
	SW(15 downto 0), n17_out, n15_out, n256_out);
	
rns_bin: traditionalSystem_RNStoBin
port map (
	(SW(3 downto 0), others => '0'), n15_in, (SW(3 downto 0), others => '0'), LEDR(15 downto 0));
 
 end architecture;
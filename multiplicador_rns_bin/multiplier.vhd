library IEEE;
use IEEE.STD_LOGIC_1164.all;
 
entity multiplier is
	port(
		SW: in std_logic_vector(17 downto 0);
		KEY: in std_lOGIC_vector(1 downto 0);
		LEDR: out std_logic_vector(15 downto 0)
		);
end entity;
 
architecture mult of multiplier is
 
component traditionalSystem_BinToRNS is
	generic (n : natural := 4);
	port(SW    : in STD_LOGIC_VECTOR(4*n - 1 downto 0);
		  cpa17: out STD_LOGIC_VECTOR(4*n downto 3*n);
		  cpa15: out STD_LOGIC_VECTOR(3*n-1 downto 2*n);
		  cpa256: out STD_LOGIC_VECTOR(2*n-1 downto 0));
end component;

component traditionalSystem_RNStoBin is
	generic (n : natural := 4);
	port(R1: in std_LOGIC_VECTOR(7 downto 0);
		  R2: in std_LOGIC_VECTOR(11 downto 8);
		  R3: in std_LOGIC_VECTOR(16 downto 12);
		  output : out STD_LOGIC_VECTOR(15 downto 0));
end component;

component mux4_1 is
	generic(n :positive:=4);
	port ( A, B, C, D : in STD_LOGIC_VECTOR (n-1 downto 0);
          sel : in STD_LOGIC_vector(1 downto 0);
          S : out STD_LOGIC_VECTOR (n-1 downto 0));
end component;

signal n256_out, n256_in: std_LOGIC_VECTOR(7 downto 0);
signal n15_out, n15_in: std_LOGIC_VECTOR(3 downto 0);
signal n17_out, n17_in: std_LOGIC_VECTOR(4 downto 0);
signal A_15, B_15, C_15, D_15: std_LOGIC_vector(3 downto 0);
signal sel: std_LOGIC_vector(1 downto 0);
 
 begin
 
 A_15 <= n15_out(2 downto 0)&n15_out(3);
 B_15 <= not(n15_out(2 downto 0)&n15_out(3));
 C_15 <= not(n15_out(1 downto 0)&n15_out(3 downto 2));
 D_15 <= not(n15_out(0)&n15_out(3 downto 1));
 
 sel <= sw(17 downto 16);
 
 mux4: mux4_1 
 port map(
	A_15, B_15, C_15, D_15, sel, n15_in -- descobrir o que btoar no sel
 );
 
 bin_rns: traditionalSystem_BinToRNS 
 port map (
	SW(15 downto 0), n17_out, n15_out, n256_out);
	
rns_bin: traditionalSystem_RNStoBin
port map (
	n256_in, n15_in, n17_in, LEDR(15 downto 0));
 
 n256_in <= "0000" & n15_out;
 n17_in <=  '0' & n15_out;
 
end architecture;

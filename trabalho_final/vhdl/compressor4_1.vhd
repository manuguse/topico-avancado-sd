library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity compressor4_1 is
    generic(n : natural); -- 8
    port(
        A, B, C, D: in std_logic_vector(n - 1 downto 0); -- 8
        compressao: out std_logic_vector(n + 1 downto 0)); -- 10
end entity;

architecture compression of compressor4_1 is

component CSA is
	generic (n : natural);
  	port( I0 : in STD_LOGIC_VECTOR((n-1) downto 0);
			I1 : in STD_LOGIC_VECTOR((n-1) downto 0);
			I2 : in STD_LOGIC_VECTOR((n-1) downto 0);
			S : out STD_LOGIC_VECTOR((n-1) downto 0);
			C : out STD_LOGIC_VECTOR(n downto 0));
end component;

signal csa1_out_n: std_logic_vector(n-1 downto 0);
signal csa1_out_n1, csa2_out_n1: std_logic_vector(n downto 0);
signal csa1_out_n_1, D_1: std_logic_vector(n downto 0);
signal csa2_out_n2: std_logic_vector(n+1 downto 0);

begin 

csa1_out_n_1 <= '0' & csa1_out_n;
D_1 <= '0' & D;

csa1: csa generic map(n)
port map(A, B, C, csa1_out_n, csa1_out_n1);
--       8  8  8      8            9

csa2: csa generic map(n+1)
port map(csa1_out_n_1, csa1_out_n1, D_1, csa2_out_n1, csa2_out_n2);
--            9             9       9       9              10

compressao <= std_logic_vector((unsigned(csa1_out_n1)) + (unsigned(csa2_out_n2)));

end architecture;
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity compressor5_1 is
    generic(n : natural); -- 11
    port(
        A, B, C, D, E: in std_logic_vector(n - 1 downto 0); -- 11
        compressao: out std_logic_vector(n + 1 downto 0)); -- 13
end entity;

architecture compression of compressor5_1 is

    signal csa1_out_n, csa2_out_n: std_logic_vector(n - 1 downto 0); -- 11
    signal csa1_out_n1, csa2_out_n1, csa3_out_n1: std_logic_vector(n downto 0); -- 12
    signal csa2_out_n_1: std_logic_vector(n downto 0); -- 11
    signal csa3_out_n2: std_logic_vector(n + 1 downto 0); -- 12

component CSA is
	generic (n : natural);
  	port( I0 : in STD_LOGIC_VECTOR((n-1) downto 0);
			I1 : in STD_LOGIC_VECTOR((n-1) downto 0);
			I2 : in STD_LOGIC_VECTOR((n-1) downto 0);
			S : out STD_LOGIC_VECTOR((n-1) downto 0);
			C : out STD_LOGIC_VECTOR(n downto 0));
end component;

begin

    csa2_out_n_1 <= '0' & csa2_out_n;

    CSA_1: csa generic map(n) 
    port map(A, B, C, csa1_out_n, csa1_out_n1);

    CSA_2: csa generic map(n)
    port map(csa1_out_n, D, E, csa2_out_n, csa2_out_n1);

    CSA_3: csa generic map(n + 1)
    port map(csa1_out_n1, csa2_out_n1, csa2_out_n_1, csa3_out_n1, csa3_out_n2);

    compressao <= std_logic_vector(unsigned(csa3_out_n2) + unsigned(csa3_out_n1));

end compression;
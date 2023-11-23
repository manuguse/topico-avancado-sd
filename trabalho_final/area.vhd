library ieee;
use ieee.std_logic_1164.all;
USE IEEE.NUMERIC_STD.ALL;


entity area is 
port(
    raio: in std_logic_vector(3 downto 0);
    area_int: out std_logic_vector(9 downto 0);
	 area_dec: out std_logic_vector(2 downto 0));
end area;

architecture area_arch of area is

    signal A, B, C, D: std_logic;
    signal V1, V2, V3, V4: std_logic_vector(7 downto 0);
    signal compressao: std_logic_vector(9 downto 0);

    begin

    A <= raio(0);
    B <= raio(1);
    C <= raio(2);
    D <= raio(3);

    V1 <= (C and D) & (B and C) & (A and C) & ((not A) and (not B) and C) & ((not C) and D) & (A and D) & (A and (not D)) & (A and (not C));
    V2 <= (C and D) & ((not C) and D) & C & (A and B and (not C)) & B & ((not A) and B) & (A and C) & (A and B);
    V3 <= D & (B and D) & (B and D) & (C and D) & (A and C) & (B and C) & ((not B) and C) & '0';
    V4 <= "00" & (A and D) & (A and D) & '0' & (B and D) & "00";

    -- compressao <= V1 + V2 + V3 + V4;
    compressao(7 downto 0) <= std_logic_vector(unsigned(V1) + unsigned(V2) + unsigned(V3) + unsigned(V4)); -- algo errado com o num de bits disso
	 compressao(9 downto 8) <= "00";

    area_int <= compressao;
	 area_dec <= ((not A) and b) & '0' & A;

end area_arch;
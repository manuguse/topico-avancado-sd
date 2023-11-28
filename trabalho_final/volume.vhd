library ieee;
use ieee.std_logic_1164.all;
USE IEEE.NUMERIC_STD.ALL;

entity volume is 
port(
    raio: in std_logic_vector(3 downto 0);
    volume_int: out std_logic_vector(13 downto 0);
	volume_dec: out std_logic_vector(1 downto 0)
);
end volume;

architecture volume_arch of volume is

    signal A, B, C, D: std_logic;
    signal V1, V2, V3, V4, V5: std_logic_vector(10 downto 0);
    signal compressao: std_logic_vector(12 downto 0);

    component compressor5_1 is
        generic(n : natural); -- 11
        port(
            A, B, C, D, E: in std_logic_vector(n - 1 downto 0); -- 11
            compressao: out std_logic_vector(n + 1 downto 0)); -- 13
    end component;

    begin

        A <= raio(0);
        B <= raio(1);
        C <= raio(2);
        D <= raio(3);

        V1 <= (B and D) & (B and C and D) & (B and C) & (A and C) & (A and D) & (B and C and D) & (B and (not C)) & (A and B) & (A and B and C) & (A and (not B)) & (A and C);
        V2 <= D & (C and D) & (A and C and D) & (C and (not D)) & (B and C) & (B and D) & (A and C and D) & (A and B and D) & C & (A and D) & B;
        V3 <= (C and D) & '0' & (A and D) & (A and B and D) & ((not B) and D) & (A and B) & (B and D) & (A and C and D) & (B and D) & (A and B and C) & (A and D);
        V4 <= (C and D) & '0' & (B and C and D) & (A and C and D) & (A and B and C) & (A and B and C) & (B and C and D) & (A and D) & (A and B and D) & (A and C) & '0';
        V5 <= "000" & (A and D) & (A and B and D) & '0' & (C and D) & (B and D) & ((not A) and C) & (B and C) & '0';

        comp: compressor5_1
            generic map(n => 11)
            port map(
                A => V1, B => V2, C => V3, D => V4, E => V5,
                compressao => compressao);

        volume_int <= compressao & (A and C);
		volume_dec <= (A and B) & A;

end volume_arch;
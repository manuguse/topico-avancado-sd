library ieee;
use ieee.std_logic_1164.all;
USE IEEE.NUMERIC_STD.ALL;


entity cube is
port(
    SW: in std_logic_vector(3 downto 0);
    LEDR: out std_logic_vector(11 downto 0)
);
end cube;

architecture bhvr of cube is

    signal V0, V1, V2, V3, V4, V5, V6: std_logic_vector(6 downto 0); -- 7 bits, 6 linhas
    signal a, b, c, d: std_logic;
    signal outA, outB: std_logic_vector(7 downto 0);
    signal result: std_logic_vector(11 downto 0);

    component compressor7_2 is
        generic(n : natural); -- 7
        port(
            A, B, C, D, E, F, G: in std_logic_vector(n - 1 downto 0); -- 7
            valorA, valorB: out std_logic_vector(n + 2 downto 0) -- 10
        );
    end component;

begin

    a <= SW(0);
    b <= SW(1);
    c <= SW(2);
    d <= SW(3);

    V0 <= d & (b and c and d) & (b and c) & (a and b and d) & (a and b and c) & (a and b) & (a and c);
    V1 <= (c and d) & (b and d) & (a and c and d) & (a and c and d) & (a and c) & (a and d) & b;
    V2 <= (c and d) & '0' & (b and d) & (a and d) & (b and d) & (a and b and d) & (a and d);
    V3 <= "00" & (a and d) & (b and c) & '0' & (a and c) & '0';
    V4 <= "00" & (b and c and d) & c & '0' & (b and c) & '0';
    V5 <= "00" & (c and d) & ("0000");
    V6 <= "0000000";

    result(2 downto 0) <= (a and c) & (a and b) & (a);

    compressor: compressor7_2 
    generic map(n => 7)
    port map(
        A => V0, B => V1, C => V2, D => V3, E => V4, F => V5, G => V6,
        valorA => outA, valorB => outB
    );

    result(11 downto 3) <= std_logic_vector(unsigned(outA) + unsigned(outB));

    LEDR <= result(11 downto 0);

end bhvr;
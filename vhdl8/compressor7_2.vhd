library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity compressor7_2 is
    generic(n : natural); -- 12
    port(
        A, B, C, D, E, F, G: in std_logic_vector(n - 1 downto 0); -- 12
        valorA, valorB: out std_logic_vector(n + 2 downto 0) -- 15
    );
end entity;

architecture bhvr of compressor7_2 is

    component csa isñ
        generic (n : natural);
        port(
            I0 : in STD_LOGIC_VECTOR((n-1) downto 0);
			I1 : in STD_LOGIC_VECTOR((n-1) downto 0);
			I2 : in STD_LOGIC_VECTOR((n-1) downto 0);
			S : out STD_LOGIC_VECTOR((n-1) downto 0);
			C : out STD_LOGIC_VECTOR(n downto 0));
    end component;

    signal csa1_out_n, csa2_out_n, csa3_out_n, csa4_out_n: std_logic_vector(n-1 downto 0); -- 12 bits
    signal csa1_out_n1, csa2_out_n1, csa3_out_n1, csa4_out_n1,
            csa4_out_n_1, input1_n1: std_logic_vector(n downto 0); -- 13 bits
    signal final2_14_bits, final2: std_logic_vector(n+1 downto 0); -- 14 bits
    signal final1 : std_logic_vector(n downto 0); -- 13 bits
    

    begin

    csa_1: csa 
        generic map(n => n)
        port map(
            I0 => A, I1 => B, I2 => C, S => csa1_out_n, C => csa1_out_n1 );
            --    12       12       12            12            13

    csa_2: csa 
        generic map(n => n)
        port map(
            I0 => D, I1 => E, I2 => F, S => csa2_out_n, C => csa2_out_n1 );
            --    12       12       12            12            13

    csa_3: csa
        generic map(n => n)
        port map(
            I0 => csa1_out_n, I1 => csa2_out_n, I2 => G, S => csa3_out_n, C => csa3_out_n1 );
            --         12                12         12            12                13

    csa_4: csa
        generic map(n => n+1)
        port map(
            I0 => csa1_out_n1, I1 => csa2_out_n1, I2 => csa3_out_n1, S => csa4_out_n, C => csa4_out_n1 );
            --          13                13                13                13                14

    csa3_out_n1 <= '0' & csa3_out_n; -- 14
    csa4_out_n_1 <= '0' & csa4_out_n; -- 14

    csa_5: csa
        generic map(n => n+2)
        port map(
            I0 => csa4_out_n_1, I1 => csa4_out_n1, I2 => csa3_out_n1, S => final1, C => final2  );
            --          14               14                   14              14            15

    valorA <= '0'&final1; -- 15
    valorB <= final2(n + 2 downto 0); -- 15
    
end architecture;

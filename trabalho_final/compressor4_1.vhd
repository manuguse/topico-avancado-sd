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

signal sum1, sum2: std_logic_vector(n downto 0);
--signal sum3: unsigned(n-1 downto 0);

begin 

sum1 <= std_logic_vector(unsigned('0'&A) + unsigned('0'&B));
sum2 <= std_logic_vector(unsigned('0'&C) + unsigned('0'&D));

compressao <= std_logic_vector(unsigned('0'&sum1) + unsigned('0'&sum2)); -- 10

end architecture;

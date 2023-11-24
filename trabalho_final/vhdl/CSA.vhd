library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity CSA is
	generic (n : natural);
  	port(I0 : in STD_LOGIC_VECTOR((n-1) downto 0);
			I1 : in STD_LOGIC_VECTOR((n-1) downto 0);
			I2 : in STD_LOGIC_VECTOR((n-1) downto 0);
			S : out STD_LOGIC_VECTOR((n-1) downto 0);
			C : out STD_LOGIC_VECTOR(n downto 0));
end CSA;
  
architecture Structural of CSA is
 component fulladder is
 	 port(A : in STD_LOGIC;
			B : in STD_LOGIC;
			Cin : in STD_LOGIC;
			S : out STD_LOGIC;
			Cout : out STD_LOGIC);
 end component;
 
signal c_intermed : STD_LOGIC_VECTOR(n downto 0);

begin

  CSA_1: for j in 0 to n-1 generate
  csa1_1:	fulladder port map( A => I0(j),B => I1(j), Cin => I2(j), S =>S(j) , Cout =>c_intermed(j+1) );
  end generate CSA_1;
	C(n downto 0) <= c_intermed(n downto 1) & '0';
end Structural;
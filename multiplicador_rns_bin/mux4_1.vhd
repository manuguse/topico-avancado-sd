 library IEEE;
 use IEEE.STD_LOGIC_1164.all;
 
 entity mux4_1 is
	generic(n :positive:=4);
	port ( A, B, C, D : in STD_LOGIC_VECTOR (n-1 downto 0)
           sel : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (n-1 downto 0));
 end mux4_1;
 
 architecture mux of mux4_1 is
 
 begin
      S <= A when sel = "00" else 
			  B when sel = "01" else
			  C when sel = "10" else
			  D;
 end mux;
 
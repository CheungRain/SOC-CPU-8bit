----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2023/05/27 18:13:05
-- Design Name: 
-- Module Name: module_181 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity module_181 is
--  Port ( );
port(
    a: in std_logic_vector(4 downto 0);--数据输入
    b: in std_logic_vector(4 downto 0);--数据输入
    s: in std_logic_vector(3 downto 0);--操作选择输入
    c: in std_logic;--进位输入
    m: in std_logic;--运算类型选择输入
    f: inout std_logic_vector(4 downto 0);--结果
    c4:out std_logic;--进位输出
    fab:out std_logic --a=b 比较输出
);
end module_181;

architecture Behavioral of module_181 is

begin
process(s,a,b,c,m)
begin
    c4<='1';
    case s is 
        when "0000"=>
            if m='1' then
                f<='0' & (not a(3 downto 0));
            elsif c='1' then
                f<=a;
            else
                f<=a+1;
                if (a+1)>"01111" then 
                    c4<='0'; 
                end if;
            end if;   
        when "0001"=>
            if m='1' then
                f<=not(('0' & a(3 downto 0)) or b);
            elsif c='1' then
                f<=a or b;
            else
                f<=(a or b)+1;
                if ((a or b)+1)>"01111" then 
                    c4<='0'; 
                end if;
            end if;   
        when "0010"=>
            if m='1' then
                f<=(('0' & not a(3 downto 0))) and b;
            elsif c='1' then
                f<=a or ('0' & not b(3 downto 0));
            else
                f<=(a or ('0' & not b(3 downto 0)))+1;
                if ((a or ('0' & not b(3 downto 0)))+1)>"01111" then 
                    c4<='0'; 
                end if;
            end if;
        when "0011"=>
            if m='1' then
                f<="00000";
            elsif c='1' then
                f<="01111";
            else
                f<="00000";
            end if;
        when "0100"=>
            if m='1' then
                f<='0' & not(a(3 downto 0) and b(3 downto 0));
            elsif c='1' then
                f<=a+(a and ('0' & not b(3 downto 0)));
            else
                f<=a+(a and ('0' & not b(3 downto 0)))+1;
                if (a+(a and ('0' & not b(3 downto 0)))+1)>"01111" then 
                    c4<='0'; 
                end if;
            end if;
        when "0101"=>
            if m='1' then
                f<=not b;
            elsif c='1' then
                f<=(a or b)+(a and ('0' & not b(3 downto 0)));
                if ((a or b)+(a and ('0' & not b(3 downto 0))))>"01111" then 
                    c4<='0'; 
                end if;
            else
                f<=(a or b)+(a and ('0' & not b(3 downto 0)))+1;
                if ((a or b)+(a and ('0' & not b(3 downto 0)))+1)>"01111" then 
                    c4<='0'; 
                end if;
            end if;
        when "0110"=>
            if m='1' then
                f<= a xor b;
            elsif c='1' then
                f<=a+('0' & not b(3 downto 0));
                if (a+('0' & not b(3 downto 0)))>"01111" then 
                    c4<='0'; 
                end if;
            else
                f<=a+('0' & not b(3 downto 0))+1;
                if (a+('0' & not b(3 downto 0))+1)>"01111" then 
                    c4<='0'; 
                end if;
            end if;
        when "0111"=>
            if m='1' then
                f<=a and ('0' & not b(3 downto 0));
            elsif c='1' then
                f<=(a and ('0'&not b(3 downto 0)));
            else
                f<=(a and ('0'&not b(3 downto 0)));   
            end if;
        when "1000"=>
            if m='1' then
                f<=a or b;
            elsif c='1' then
                f<=a+(a and b);
                if (a+(a and b))>"01111" then 
                    c4<='0'; 
                end if;
            else
                f<=a+(a and b)+1;
                 if (a+(a and b)+1)>"01111" then 
                    c4<='0'; 
                end if;
            end if;
        when "1001"=>
            if m='1' then
                f<=not (a xor b);
            elsif c='1' then
                f<=(a+b);
                if (a+b)>"01111" then 
                    c4<='0'; 
                end if;
            else
                f<=a+b+1;
                if (a+b+1)>"01111" then 
                    c4<='0'; 
                end if;
            end if;
        when "1010"=>
            if m='1' then
                f<=b;
            elsif c='1' then
                f<=(a or ('0'&not b(3 downto 0)))+(a and b);
                if ((a or ('0'&not b(3 downto 0)))+(a and b))>"01111" then 
                    c4<='0'; 
                end if;
            else
                f<=(a or ('0'&not b(3 downto 0)))+(a and b)+1;
                if ((a or ('0'&not b(3 downto 0)))+(a and b)+1)>"01111" then 
                    c4<='0'; 
                end if;
            end if;
        when "1011"=>
            if m='1' then
                f<=a and b;
            elsif c='1' then
                f<=(a and b);
            else
                f<=a and b;
            end if;
        when "1100"=>
            if m='1' then
                f<="00001";
            elsif c='1' then
                f<=a+a;
                if (a+a)>"01111" then 
                    c4<='0'; 
                end if;
            else
                f<=a+a+1;
                if (a+a+1)>"01111" then 
                    c4<='0'; 
                end if;
            end if;
        when "1101"=>
            if m='1' then
                f<=a or ('0'&not b(3 downto 0));
            elsif c='1' then
                f<=(a or b)+a;
                if ((a or b)+a)>"01111" then 
                    c4<='0'; 
                end if;
            else
                f<=(a or ('0'&not b(3 downto 0)))+a+1;
                if ((a or ('0'&not b(3 downto 0)))+a+1)>"01111" then 
                    c4<='0'; 
                end if;
            end if;
        when "1110"=>
            if m='1' then
                f<=a or b;
            elsif c='1' then
                f<=(a or ('0'&not b(3 downto 0)))+a;
                 if ((a or ('0'&not b(3 downto 0)))+a)>"01111" then 
                    c4<='0'; 
                end if;
            else
                f<=(a or b)+a+1;
                 if ((a or b)+a+1)>"01111" then 
                    c4<='0'; 
                end if;
            end if;
        when "1111"=>
            if m='1' then
                f<=a;
            elsif c='1' then
                f<=a+"01111";
            else
                f<=a;
            end if;
        when others=>
    end case;
    if a=b then
        fab<='1';
    else
        fab<='0';
    end if;

end process;
end Behavioral;

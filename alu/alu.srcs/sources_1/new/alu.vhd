----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2023/05/29 15:07:52
-- Design Name: 
-- Module Name: alu - Behavioral
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
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alu is
--  Port ( );
port(
    clk_alu: in std_logic;--时钟信号
    nreset: in std_logic;--复位信号
    m_a: in std_logic;--暂存器控制信号
    m_b: in std_logic;--暂存器控制信号
    m_f: in std_logic;--程序状态字控制信号
    alu_en: in std_logic;--alu运算输出使能
    psw_en: in std_logic;--psw输出使能
    c0: in std_logic;--进位输入
    s: in std_logic_vector(4 downto 0);--运算类型和操作选择
    f_in: in std_logic_vector(1 downto 0);--移位功能选择 00直接传送 01右移 10左移 11取反
    data: in std_logic_vector(7 downto 0);--数据总线
    ac: out std_logic;--半进位标志
    cy: out std_logic;---进位标志
    zn: out std_logic;--零标志
    ov: out std_logic; --溢出标志
    ans:out std_logic_vector(7 downto 0)
);
end alu;

architecture Behavioral of alu is
component module_273
port(
    d:in std_logic_vector(7 downto 0);
    clk:in std_logic;
    q:out std_logic_vector(7 downto 0)
);
end component;

component module_181
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
end component;

signal clk1:std_logic;--暂存器a时钟
signal clk2:std_logic;
signal c1:std_logic;--181 低位进位
signal c2:std_logic;--181 高位进位
signal fab1:std_logic;
signal fab2:std_logic;
signal out1:std_logic_vector(7 downto 0);--暂存器a输出
signal out2:std_logic_vector(7 downto 0);--暂存器b输出
signal out_1:std_logic_vector(4 downto 0);--181 低四位结果
signal out_2:std_logic_vector(4 downto 0);--181 高四位结果
signal ina1:std_logic_vector(4 downto 0);
signal inb1:std_logic_vector(4 downto 0);
signal ina2:std_logic_vector(4 downto 0);
signal inb2:std_logic_vector(4 downto 0);
signal an: std_logic_vector(7 downto 0);--最终结果
begin
u1: module_273 port map(data,clk1,out1);
u2: module_273 port map(data,clk2,out2);
u3: module_181 port map(ina1,inb1,s(3 downto 0),c0,s(4),out_1,c1,fab1);
u4: module_181 port map(ina2,inb2,s(3 downto 0),c1,s(4),out_2,c2,fab2);
clk1<=m_a and clk_alu;
clk2<=m_b and clk_alu;
ina1<='0'&out1(3 downto 0);
inb1<='0'&out2(3 downto 0);
ina2<='0'&out1(7 downto 4);
inb2<='0'&out2(7 downto 4);
an<=out_2(3 downto 0) & out_1(3 downto 0);
process(clk_alu,nreset,psw_en,c1,c2,out_2,an,s)
begin
    if psw_en='0' or nreset='1' then
        ac<='0';
        cy<='0';
        zn<='0';
        ov<='0';
    elsif rising_edge(clk_alu) then
        ac<=not c1;
        cy<=not c2;
        if s(3 downto 0)="0110" or s(3 downto 0)="0111" or s(3 downto 0)="1011" or s(3 downto 0)="1111" then
            ov<='0';
        else
            ov<=out_2(4);    
        end if;
        if an="00000000" then
            zn<='1';
        else
            zn<='0';
        end if;
    end if;
end process;

process(clk_alu,nreset,alu_en,out_1,out_2,f_in)
begin
    if alu_en='0' or nreset='1' then
        ans<=(others=>'0');
    elsif rising_edge(clk_alu) then
        if f_in="00" then
            ans<=out_2(3 downto 0) & out_1(3 downto 0);
        elsif f_in="01" then
            ans<=out_1(0)&out_2(3 downto 0) & out_1(3 downto 1);
        elsif f_in="10" then
            ans<=out_2(2 downto 0) & out_1(3 downto 0)&out_2(3);
        elsif f_in="11" then
            ans<=not (out_2(3 downto 0) & out_1(3 downto 0));
        end if;
    end if;
end process;

end Behavioral;

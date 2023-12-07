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
    clk_alu: in std_logic;--ʱ���ź�
    nreset: in std_logic;--��λ�ź�
    m_a: in std_logic;--�ݴ��������ź�
    m_b: in std_logic;--�ݴ��������ź�
    m_f: in std_logic;--����״̬�ֿ����ź�
    alu_en: in std_logic;--alu�������ʹ��
    psw_en: in std_logic;--psw���ʹ��
    c0: in std_logic;--��λ����
    s: in std_logic_vector(4 downto 0);--�������ͺͲ���ѡ��
    f_in: in std_logic_vector(1 downto 0);--��λ����ѡ�� 00ֱ�Ӵ��� 01���� 10���� 11ȡ��
    data: in std_logic_vector(7 downto 0);--��������
    ac: out std_logic;--���λ��־
    cy: out std_logic;---��λ��־
    zn: out std_logic;--���־
    ov: out std_logic; --�����־
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
    a: in std_logic_vector(4 downto 0);--��������
    b: in std_logic_vector(4 downto 0);--��������
    s: in std_logic_vector(3 downto 0);--����ѡ������
    c: in std_logic;--��λ����
    m: in std_logic;--��������ѡ������
    f: inout std_logic_vector(4 downto 0);--���
    c4:out std_logic;--��λ���
    fab:out std_logic --a=b �Ƚ����
);
end component;

signal clk1:std_logic;--�ݴ���aʱ��
signal clk2:std_logic;
signal c1:std_logic;--181 ��λ��λ
signal c2:std_logic;--181 ��λ��λ
signal fab1:std_logic;
signal fab2:std_logic;
signal out1:std_logic_vector(7 downto 0);--�ݴ���a���
signal out2:std_logic_vector(7 downto 0);--�ݴ���b���
signal out_1:std_logic_vector(4 downto 0);--181 ����λ���
signal out_2:std_logic_vector(4 downto 0);--181 ����λ���
signal ina1:std_logic_vector(4 downto 0);
signal inb1:std_logic_vector(4 downto 0);
signal ina2:std_logic_vector(4 downto 0);
signal inb2:std_logic_vector(4 downto 0);
signal an: std_logic_vector(7 downto 0);--���ս��
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

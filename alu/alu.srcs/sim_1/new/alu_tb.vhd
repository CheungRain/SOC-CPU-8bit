----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2023/05/31 22:11:49
-- Design Name: 
-- Module Name: alu_tb - Behavioral
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

entity alu_tb is
--  Port ( );
end alu_tb;

architecture Behavioral of alu_tb is
component alu is
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
    f_in: in std_logic_vector(1 downto 0);--��λ����ѡ��
    data: inout std_logic_vector(7 downto 0);--��������
    ac: out std_logic;--���λ��־
    cy: out std_logic;---��λ��־
    zn: out std_logic;--���־
    ov: out std_logic; --�����־
    ans:out std_logic_vector(7 downto 0)
);
end component;
signal clk_alu: std_logic;--ʱ���ź�
signal nreset: std_logic;--��λ�ź�
signal m_a: std_logic:='1';--�ݴ��������ź�
signal m_b: std_logic:='0';--�ݴ��������ź�
signal m_f: std_logic:='0';--����״̬�ֿ����ź�
signal alu_en:  std_logic:='0';--alu�������ʹ��
signal psw_en:  std_logic:='0';--psw���ʹ��
signal c0:  std_logic:='0';--��λ����
signal s: std_logic_vector(4 downto 0):="00110";--�������ͺͲ���ѡ��
signal f_in:  std_logic_vector(1 downto 0):="00";--��λ����ѡ��
signal data:  std_logic_vector(7 downto 0):="00000000";--��������
signal ac: std_logic;--���λ��־
signal cy: std_logic;---��λ��־
signal zn: std_logic;--���־
signal ov: std_logic; --�����־
signal ans:std_logic_vector(7 downto 0);
begin
u1: alu port map(clk_alu,nreset,m_a,m_b,m_f,alu_en,psw_en,c0,s,f_in,data,ac,cy,zn,ov,ans);

process
begin
clk_alu<='0';
wait for 10 ns;
clk_alu<='1';
wait for 10 ns;
end process;

process
begin
nreset<='1';
wait for 20 ns;
nreset<='0';
m_a<='1';
m_b<='0';
wait for 40 ns;
data<="00000001";
m_a<='0';
m_b<='1';
wait for 40 ns;
m_a<='0';
m_b<='0';
wait for 20 ns;
alu_en<='1';
psw_en<='1';
wait for 20 ns;
nreset<='0';
wait for 60 ns;
f_in<="01";
wait for 20 ns;
f_in<="10";
wait for 20 ns;
f_in<="11";
wait;
end process;

end Behavioral;

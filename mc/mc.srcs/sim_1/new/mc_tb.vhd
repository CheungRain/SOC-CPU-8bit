----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2023/06/03 16:08:57
-- Design Name: 
-- Module Name: mc_tb - Behavioral
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

entity mc_tb is
--  Port ( );
end mc_tb;

architecture Behavioral of mc_tb is
component mc is
-- cm���΢���� uir�������΢ָ�� ΢��ַ�γɵ�·--�ṩ΢��ַ ΢��ַ�Ĵ���--�������΢��ַ
--΢������ϳ�΢ָ�΢ָ����ϳ�΢����΢ָ�����΢�����ֶΣ�������йأ���΢��ַ�ֶ�

port(
    clk_mc,clk: in std_logic;--΢���������ʱ���ź�
    nreset: in std_logic;--�첽��λ
    ir: in std_logic_vector(7 downto 2);--ir��������Ϣ 27��ָ�� 5λ���� 8λ΢��ַ
    m_ua: in std_logic;--΢��ַ�����ź�
    cmrom_cs: in std_logic;--���ƴ洢��ѡͨ�ź�
    cm_out:inout std_logic_vector(47 downto 0); --�����ź���� 39�������ź�(΢����)+8λ΢��ַ=47 ˮƽ΢ָ�� ֱ���ͱ��� 256*48bit
    sel:out std_logic_vector(15 downto 0);--�����ѡ���ź�
    dis:out std_logic_vector(7 downto 0)--�������ʾ�ź�
--    cm_out:inout std_logic_vector(47 downto 0); --�����ź���� 39�������ź�(΢����)+8λ΢��ַ=47 ˮƽ΢ָ�� ֱ���ͱ��� 256*48bit
--    LD_PC:out std_logic; --װ���µ�ַ
--    M_PC:out std_logic; --PC �� 1 �����ź�
--    nPCH,nPCL:out std_logic; --PC ������߿����ź�
--    M_ROM :out std_logic; --ROM Ƭѡ�ź�
--    ROM_EN :out std_logic --ROM ʹ���ź�
);
end component;
signal clk_mc,clk,clk_out:  std_logic:='0';--΢���������ʱ���ź�
signal nreset: std_logic:='1';--�첽��λ
signal ir:  std_logic_vector(7 downto 2):="001001";--ir��������Ϣ 27��ָ�� 5λ���� 8λ΢��ַ
signal m_ua:  std_logic:='0';--΢��ַ�����ź�
signal cmrom_cs:  std_logic:='0';--���ƴ洢��ѡͨ�ź�
signal cm_out: std_logic_vector(47 downto 0); --�����ź���� 39�������ź�(΢����)+8λ΢��ַ=47 ˮƽ΢ָ�� ֱ���ͱ��� 256*48bit
signal sel:std_logic_vector(15 downto 0);--�����ѡ���ź�
signal dis: std_logic_vector(7 downto 0);--�������ʾ�ź�
begin
u1: mc port map(clk_mc,clk,nreset,ir,m_ua,cmrom_cs,cm_out,sel,dis);
process
begin
    clk_mc<='0';
    wait for 12 ns;
    clk_mc<='1';
    wait for 12 ns;
end process;

process
begin
    clk<='1';
    wait for 1 ns;
    clk<='0';
    wait for 1 ns;
end process;

process
begin
    nreset<='1';
    wait for 12 ns;
    nreset<='0';
    wait;
end process;
end Behavioral;

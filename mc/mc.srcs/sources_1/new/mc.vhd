----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2023/06/03 11:37:54
-- Design Name: 
-- Module Name: mc - Behavioral
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
use IEEE.STD_LOGIC_TEXTIO.ALL;
use STD.TEXTIO.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mc is
-- cm���΢���� uir�������΢ָ�� ΢��ַ�γɵ�·--�ṩ΢��ַ ΢��ַ�Ĵ���--�������΢��ַ
--΢������ϳ�΢ָ�΢ָ����ϳ�΢����΢ָ�����΢�����ֶΣ�������йأ���΢��ַ�ֶ�
port(
    clk_mc,clk: in std_logic;--΢���������ʱ���ź�
    nreset: in std_logic;--�첽��λ
    ir: in std_logic_vector(7 downto 2);--ir��������Ϣ 27��ָ�� 5λ���� 8λ΢��ַ
    m_ua: in std_logic;--΢��ַ�����ź�
    cmrom_cs: in std_logic;--���ƴ洢��ѡͨ�ź�
    --cm_out:inout std_logic_vector(47 downto 0); --�����ź���� 39�������ź�(΢����)+8λ΢��ַ=47 ˮƽ΢ָ�� ֱ���ͱ��� 256*48bit ����ʹ��
    sel:out std_logic_vector(15 downto 0);--�����ѡ���ź�
    dis:out std_logic_vector(7 downto 0)--�������ʾ�ź�
);
end mc;

architecture Behavioral of mc is
component cm is --���ƴ洢��
Port (
    addr:in std_logic_vector(7 downto 0);
    oe:in std_logic;
    reset:in std_logic;
    dout:out std_logic_vector(47 downto 0)
  );
end component;

component DLED is
Port (
    clk,rst: in std_logic;
    cm_out:in std_logic_vector(47 downto 0);
    sel:out std_logic_vector(15 downto 0);   --ѡ���ź�
    dis:out std_logic_vector(7 downto 0)    --��������
   );
end component;

type state is(s0,s1,s2,s3,s4,s5);
signal s:state;
signal clk_out:std_logic;--�������ʱ���ź�
signal addr:std_logic_vector(7 downto 0);--΢������ڵ�ַ
signal uir:std_logic_vector(47 downto 0):=(others=>'0');--΢ָ��
signal uar: std_logic_vector(7 downto 0);--΢��ַ�Ĵ���
signal cm_out:std_logic_vector(47 downto 0);--΢ָ��Ĵ������

begin
u1:cm port map(addr,cmrom_cs,nreset,uir);
u2:DLED port map(clk,nreset,cm_out,sel,dis);


process(clk_out,nreset)
begin
    if nreset='1' then
        uar<="00000000";
        cm_out<=(others=>'0');
    elsif rising_edge(clk_out) and cmrom_cs='0' then
        addr<=uar;
        if m_ua='0' then --�ж��Ƿ�Ϊ������ڵ�ַ
            if uir="000000000011000100011001111100110111100100000000" or uir="000000000011000100011001111100110111100000000000" then
                    uar<=ir&"00"; --ָ��Ĵ�����6λ ��Ϊ΢ָ���׵�ַΪ4�ı���  
           else
                uar<=uir(7 downto 0);  
            end if;
        end if;
        cm_out<=uir;--΢ָ��Ĵ������
    end if;
end process;

process(nreset,clk_mc,clk)--��������
variable count:integer:=1000;
begin
    if nreset='1' then
       s<=s0; 
    elsif rising_edge(clk) then
        case s is
            when s0 =>
                if clk_mc='1' then
                    s<=s1;
                else
                    clk_out<='0';
                end if;
            when s1 =>
                count:=count-1;
                if count=0 then
                    count:=1000;
                    s<=s2;
                else 
                    null;
                end if;
            when s2 =>
                if clk_mc='1' then
                    s<=s3;
                else
                    s<=s0;
                end if;
            when s3 =>
                if clk_mc='1' then
                    s<=s4;
                else
                    s<=s0;
                end if;
            when s4 =>
                if clk_mc='1' then
                    clk_out<='1';
                    s<=s5;
                else
                    s<=s0;
                end if;
            when s5 =>
                if clk_mc='1' then
                    null;
                else
                    s<=s0;
                    clk_out<='0';
                end if;
        end case;
    end if;
end process;

end Behavioral;

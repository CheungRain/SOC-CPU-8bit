----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2023/06/03 17:12:17
-- Design Name: 
-- Module Name: control_seg - Behavioral
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

entity control_seg is
--  Port ( );
port(
    info: in std_logic_vector(39 downto 0);
    --pcģ��(4����
    LD_PC:out std_logic; --װ���µ�ַ
    M_PC:out std_logic; --PC �� 1 �����ź�
    nPCH,nPCL:out std_logic --PC ������߿����ź�
    --ROM ģ�飨2 ����
--    M_ROM :out std_logic; --ROM Ƭѡ�ź�
--    ROM_EN :out std_logic; --ROM ʹ���ź�
--    --IR ģ�飨4 ����
--    LD_IR1,LD_IR2,LD_IR3 :out std_logic; --IR ָ��洢�����ź�
--    nARen :out std_logic; --IR �� RAM ��ַ�����ź�
--    --RN ģ�飨4 ����
--    Ri_CS :out std_logic; --RN ѡ���ź�
--    Ri_EN :out std_logic; --RN �Ĵ���ʹ��
--    RDRi,WRRi :out std_logic; --RN ��д�ź�
--    --ALU ģ�飨13 ����
--    M_A,M_B :out std_logic; --�ݴ��������ź�
--    M_F :out std_logic; --����״̬�ֿ����ź�
--    nALU_EN :out std_logic; --ALU ���������ʹ��
--    nPSW_EN :out std_logic; --PSW ���ʹ��
--    C0 :out std_logic; --��λ����
--    S:out std_logic_vector(4 downto 0); --�������ͺͲ���ѡ��
--    F_in:out std_logic_vector(1 downto 0); --��λ����ѡ��
--    --RAM ģ�飨3 ����
--    RAM_CS :out std_logic; --RAM Ƭѡ�ź�
--    nRAM_EN :out std_logic; --RAM ���ʹ���ź�
--    wr_nRD :out std_logic -- ��д�ź�

);
end control_seg;

architecture Behavioral of control_seg is

begin

process
begin
    if info(39)='1' then
        LD_PC<='1';
    elsif info(38)='1' then
        M_PC<='1';
    elsif info(37)='1' then
        nPCH<='1';
    elsif info(36)='1' then
        nPCL<='1';
    end if;
    
    
end process;

end Behavioral;

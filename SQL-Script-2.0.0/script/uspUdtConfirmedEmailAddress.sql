
--Email �ּҸ� ���� ���� ���� üũ (�� ���� �ּҷ� �� ��ũ ������ ȸ������ �Ϸ�) �������� ���ͷ��� �ʿ�)	UdtConfirmedEmailAddress	"���� ���̺� member 
-- EmailConfirmedYN
--���� id"	"UDT Member
--Set EmailConfirmedYN = Y
--Where ID ��"

-----------------------------------------------------------------------
-- uspUdtConfirmedEmailAddress ���ν��� ����
--DROP PROC uspUdtConfirmedEmailAddress
CREATE PROC uspUdtConfirmedEmailAddress
@MemberID NVARCHAR(MAX)
,@MemberPWD NVARCHAR(MAX)
AS 
--set, lock option check
set nocount on
update Members Set EmailConfirmedYN = 'Y', UpdatedAt = sysutcdatetime()
where MemberID like @MemberID and MemberPWD like @MemberPWD and HideYN like 'N' and DeleteYN like 'N'
select @@rowcount as Result
GO

/*
-----------------------------------------------------------------------
EXEC uspUdtConfirmedEmailAddress 'ccc', 'MemberPWD'
EXEC uspUdtConfirmedEmailAddress 'adfsadsf', 'MemberPWD'
-----------------------------------------------------------------------
select * from Members

*/
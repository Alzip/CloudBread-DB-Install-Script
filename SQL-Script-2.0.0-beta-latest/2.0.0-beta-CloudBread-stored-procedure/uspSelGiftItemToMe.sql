--DROP PROC uspSelGiftItemToMe
CREATE PROC uspSelGiftItemToMe
@MemberID VARCHAR(MAX)
AS 
select top 1 GiftDepositoryID, ItemListID, ItemCount, FromMemberID, ToMemberID, sCol1, sCol2, sCol3, sCol4, sCol5, sCol6, sCol7, sCol8, sCol9, sCol10
from GiftDepositories
where ToMemberID like @MemberID and HideYN like 'N' and DeleteYN like 'N'
order by CreatedAt DESC  --order by here
GO

/*
-----------------------------------------------------------------------
EXEC uspSelGiftItemToMe 'aaa'
EXEC uspSelGiftItemToMe 'asfasdf'
--���� �ؼ� member ����(�̸�)�� item ������ ������ �����;� �ϳ�? �ƴϸ� ����? ���� ����.
-----------------------------------------------------------------------
select * from GiftDepositories
*/

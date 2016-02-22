/*
SELECT * FROM GiftDepositories
SELECT * FROM Members
SELECT * FROM ItemLists
SELECT * FROM MemberItems
SELECT * FROM MemberGameInfoes
SELECT * FROM MemberItemPurchases
SELECT * FROM Adminmembers
SELECT * FROM Coupon
SELECT * FROM CouponMember
SELECT * FROM GameEvents
SELECT * FROM GameEventMember
SELECT * FROM Notices
SELECT * FROM MemberGameInfoStages
SELECT * FROM MemberAccountBlockLog

SELECT CouponID, CouponCategory1, CouponCategory2, CouponCategory3, DupeYN, ItemListID, ItemCount, ItemStatus, TargetGroup, TargetOS, TargetDevice, OrderNumber, CouponDurationFrom, CouponDurationTo, title, content, CreateAdminID, HideYN, DeleteYN, sCol1, sCol2, sCol3, sCol4, sCol5, sCol6, sCol7, sCol8, sCol9, sCol10 
FROM Coupon

"�������̺��� DupeYN�� ���� ó��

 ��¥�� ������ ��¥ �ȿ� �ְ�
  coupon ���̺��� DeleteYN = N & DupeYN = Y�̸� 
    CouponMember �� Member ������ insert�� �Ѵ�
  coupon ���̺��� DeleteYN = N & DupeYN = N�̸� 
    coupon ���̺��� DeleteYN�� Y�� �ٲٰ� CouponMember �� Member ������ insert�� �Ѵ�
  coupon ���̺��� DeleteYN = Y ��
    ���� ��� �Ұ� �˸��� �ش�.
 ��
������ ������ �������� insert or update�Ѵ�"


SELECT CouponID, CouponCategory1, CouponCategory2, CouponCategory3, DupeYN, ItemListID, ItemCount, ItemStatus, TargetGroup, TargetOS, TargetDevice, OrderNumber, CouponDurationFrom, CouponDurationTo, title, content, CreateAdminID, HideYN, DeleteYN, sCol1, sCol2, sCol3, sCol4, sCol5, sCol6, sCol7, sCol8, sCol9, sCol10 
FROM Coupon
SELECT CouponMemberID, CouponID, MemberID, HideYN, DeleteYN, sCol1, sCol2, sCol3, sCol4, sCol5, sCol6, sCol7, sCol8, sCol9, sCol10
FROM CouponMember

update Coupon	-- �� ������ ���� ���� �÷� ó�� datetime ���� ó���� �ʿ� ����
set CouponDurationFrom = '2015-01-01', CouponDurationTo = '2016-01-01', HideYN = 'N', DeleteYN = 'N', DupeYN = 'Y', ItemListID = '7BF74075-FC72-4FC1-A1B9-7A0DFAD2E0DE', ItemCount = '10', Itemstatus = '���±�'

--NOT EXISTS ����� ó��
SELECT CouponID, CouponCategory1, CouponCategory2, CouponCategory3, DupeYN, ItemListID, ItemCount, ItemStatus, TargetGroup, TargetOS, TargetDevice, OrderNumber, CouponDurationFrom, CouponDurationTo, title, content, CreateAdminID, HideYN, DeleteYN, sCol1, sCol2, sCol3, sCol4, sCol5, sCol6, sCol7, sCol8, sCol9, sCol10 
FROM Coupon
WHERE NOT EXISTS 
(
  SELECT 1 
    FROM CouponMember
    WHERE CouponMember.CouponID = Coupon.CouponID
	and CouponMember.MemberID like 'aaa'
);

*/

-----------------------------------------------------------------------
-- uspSelCoupons ���ν��� ����
--DROP PROC uspSelCoupons
CREATE PROC uspSelCoupons
@MemberID varchar(MAX)
--CouponDurationFrom�� �� �Ϸ��� ���� �κ��� ��ȣȭ ���� ���� ���̾�� ��.
--CouponDurationFrom �÷��� datetime ���·� ���� �Ǿ�� ��.
AS 
select CouponID, CouponCategory1, CouponCategory2, CouponCategory3, ItemListID, ItemCount, ItemStatus, TargetGroup, TargetOS, TargetDevice, Title, Content, sCol1, sCol2, sCol3, sCol4, sCol5, sCol6, sCol7, sCol8, sCol9, sCol10
FROM Coupon with(nolock)
WHERE NOT EXISTS 
(
  SELECT 1 
    FROM CouponMember  with(nolock)
    WHERE CouponMember.CouponID = Coupon.CouponID
	and CouponMember.MemberID like @MemberID
		--���� ���� ���ǿ� �´� �� and HideYN, DeleteYN�� N �ΰ�
)
and sysutcdatetime() between CouponDurationFrom and CouponDurationTo
and Coupon.HideYN like 'N'
and Coupon.DeleteYN like 'N'
order by OrderNumber asc, CreatedAt desc		-- ������ ���� �÷� ���� asc, ���� ������ �ֽ� ��
GO

/*
-----------------------------------------------------------------------
EXEC uspSelCoupons 'aaa'	--get valid coupon
EXEC uspSelCoupons 'bbb'	
-----------------------------------------------------------------------
SELECT * FROM Coupon
SELECT * FROM CouponMember
*/

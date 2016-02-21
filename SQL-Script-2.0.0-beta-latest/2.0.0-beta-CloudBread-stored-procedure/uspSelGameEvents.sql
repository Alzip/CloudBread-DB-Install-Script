
/*
SELECT * FROM GiftDepositories
SELECT * FROM ItemLists
SELECT * FROM MemberItems
SELECT * FROM MemberGameInfoes
SELECT * FROM MemberItemPurchases
SELECT * FROM Adminmembers
SELECT * FROM Coupon
SELECT * FROM CouponMember
SELECT * FROM Notices
SELECT * FROM MemberGameInfoStages
SELECT * FROM MemberAccountBlockLog
SELECT * FROM Members
SELECT * FROM GameEvents
SELECT * FROM GameEventMember

select GameEventID, eventCategory1, eventCategory2, eventCategory3, ItemListID, ItemCount, Itemstatus, TargetGroup, TargetOS, TargetDevice, OrderNumber, EventDurationFrom, EventDurationTo, EventImageLink, title, content, CreateAdminID, HideYN, DeleteYN, sCol1, sCol2, sCol3, sCol4, sCol5, sCol6, sCol7, sCol8, sCol9, sCol10 
from GameEvents
select GameEventMemberID, eventID, MemberID, HideYN, DeleteYN, sCol1, sCol2, sCol3, sCol4, sCol5, sCol6, sCol7, sCol8, sCol9, sCol10
from GameEventMember
update GameEvents		-- �� ������ ���� ���� �÷� ó�� datetime ���� ó���� �ʿ� ����
set EventDurationFrom = '2015-01-01', EventDurationTo = '2016-01-01', HideYN = 'N', DeleteYN = 'N'
update GameEventMember
set HideYN = 'N', DeleteYN = 'N'


--NOT EXISTS ����� ó�� �׽�Ʈ
SELECT GameEventID, eventCategory1, eventCategory2, eventCategory3, ItemListID, ItemCount, Itemstatus, TargetGroup, TargetOS, TargetDevice, OrderNumber, EventDurationFrom, EventDurationTo, EventImageLink, title, content, CreateAdminID, HideYN, DeleteYN, sCol1, sCol2, sCol3, sCol4, sCol5, sCol6, sCol7, sCol8, sCol9, sCol10  
FROM GameEvents
WHERE NOT EXISTS 
(
  SELECT 1 
    FROM GameEventMember
    WHERE GameEventMember.eventID = GameEvents.GameEventID
	and MemberID like 'aaa'
);



--Left Outer Join ��� ó�� �׽�Ʈ
SELECT 
 GameEvents.GameEventID,
 GameEvents.eventCategory1,
 GameEvents.eventCategory2,
 GameEvents.eventCategory3,
 GameEvents.ItemListID,
 GameEvents.ItemCount,
 GameEvents.Itemstatus,
 GameEvents.TargetGroup,
 GameEvents.TargetOS,
 GameEvents.TargetDevice,
 GameEvents.OrderNumber,
 GameEvents.EventDurationFrom,
 GameEvents.EventDurationTo,
 GameEvents.EventImageLink,
 GameEvents.title,
 GameEvents.content,
 GameEvents.CreateAdminID,
 GameEvents.HideYN,
 GameEvents.DeleteYN,
 GameEvents.sCol1,
 GameEvents.sCol2,
 GameEvents.sCol3,
 GameEvents.sCol4,
 GameEvents.sCol5,
 GameEvents.sCol6,
 GameEvents.sCol7,
 GameEvents.sCol8,
 GameEvents.sCol9,
 GameEvents.sCol10,
 isnull(GameEventMember.GameEventMemberID, '') as GameEventMemberID,
 isnull(GameEventMember.eventID, '') as eventID,
 isnull(GameEventMember.MemberID, '') as MemberID
 FROM GameEvents with (nolock)   left outer join  GameEventMember with (nolock)  
on GameEvents.GameEventID = GameEventMember.EventID
where 
--ȸ�� ���� �ʿ�
sysutcdatetime() between convert(datetime,GameEvents.EventDurationFrom) and convert(datetime, GameEvents.EventDurationTo)
and GameEvents.HideYN like 'N'
and GameEvents.DeleteYN like 'N'	
--and GameEventMember.memberid like 'bbb'		// member ���� ���߱� �����.

--not in �׽�Ʈ
select gameeventid 
from GameEvents where gameeventid not in (select eventid from GameEventMember where memberid like 'aaa')

--not in ����� �������� ����.
--letf outer join�� ��� memberid ���� ���߱� �����.

-- except �� �̿��ϴ� ��� �׽�Ʈ - �÷� ����Ʈ ����ȭ �������� ���� ������ �÷� �������� �� �� ����.
select GameEventID from GameEvents with (nolock)  
except select eventid from GameEventMember where memberid like 'aaa'
GO

-----------------------------------------------------------------------------------------------
--NOT EXISTS �� ���� ����
SELECT GameEventID, eventCategory1, eventCategory2, eventCategory3, ItemListID, ItemCount, Itemstatus, TargetGroup, TargetOS, TargetDevice, OrderNumber, EventDurationFrom, EventDurationTo, EventImageLink, title, content, CreateAdminID, HideYN, DeleteYN, sCol1, sCol2, sCol3, sCol4, sCol5, sCol6, sCol7, sCol8, sCol9, sCol10  
FROM GameEvents
WHERE NOT EXISTS 
(
  SELECT 1 
    FROM GameEventMember
    WHERE GameEventMember.eventID = GameEvents.GameEventID
	and MemberID like 'aaa'
)
GO

*/

-----------------------------------------------------------------------
-- uspSelGameEvents ���ν��� ����
--DROP PROC uspSelGameEvents
CREATE PROC uspSelGameEvents
@MemberID VARCHAR(MAX)
AS 
--set, lock �ɼ� �� üũ
SELECT GameEventID, EventCategory1, EventCategory2, EventCategory3, ItemListID, ItemCount, Itemstatus, TargetGroup, TargetOS, TargetDevice, EventImageLink, Title, Content, sCol1, sCol2, sCol3, sCol4, sCol5, sCol6, sCol7, sCol8, sCol9, sCol10  
FROM GameEvents
WHERE NOT EXISTS 
(
  SELECT 1 
    FROM GameEventMember
    WHERE GameEventMember.eventID = GameEvents.GameEventID
	and MemberID like @MemberID
)
and sysutcdatetime() between GameEvents.EventDurationFrom and GameEvents.EventDurationTo
and GameEvents.HideYN like 'N'
and GameEvents.DeleteYN like 'N'
order by OrderNumber asc, CreatedAt desc		-- ������ ���� �÷� ���� asc, ���� ������ �ֽ� ��
GO

/*
-----------------------------------------------------------------------
--���� MemberID�� �������� ���� �̺�Ʈ ����Ʈ
EXEC uspSelGameEvents 'bbb'
EXEC uspSelGameEvents 'aaa'
-----------------------------------------------------------------------
*/

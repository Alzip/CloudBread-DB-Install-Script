
-----------------------------------------------------------------------
-- uspSelGameEvents ���ν��� ����
--DROP PROC uspUdtGameEventMemberToItem
CREATE PROC uspUdtGameEventMemberToItem
@InsertORUpdate nvarchar(MAX) = NULL
,	@MemberItemID_MemberItems nvarchar(MAX) = NULL  --update�� ��쿡�� ���
,	@MemberID_MemberItems nvarchar(MAX) = NULL
,	@ItemListID_MemberItems nvarchar(MAX) = NULL
,	@ItemCount_MemberItems nvarchar(MAX) = NULL
,	@ItemStatus_MemberItems nvarchar(MAX) = NULL
,	@sCol1_MemberItems nvarchar(MAX) = NULL
,	@sCol2_MemberItems nvarchar(MAX) = NULL
,	@sCol3_MemberItems nvarchar(MAX) = NULL
,	@sCol4_MemberItems nvarchar(MAX) = NULL
,	@sCol5_MemberItems nvarchar(MAX) = NULL
,	@sCol6_MemberItems nvarchar(MAX) = NULL
,	@sCol7_MemberItems nvarchar(MAX) = NULL
,	@sCol8_MemberItems nvarchar(MAX) = NULL
,	@sCol9_MemberItems nvarchar(MAX) = NULL
,	@sCol10_MemberItems nvarchar(MAX) = NULL

--,	@GameEventMemberID_GameEventMember nvarchar(MAX) = NULL  --insert �����̶� ����
,	@eventID_GameEventMember nvarchar(MAX) = NULL
,	@MemberID_GameEventMember nvarchar(MAX) = NULL
,	@sCol1_GameEventMember nvarchar(MAX) = NULL
,	@sCol2_GameEventMember nvarchar(MAX) = NULL
,	@sCol3_GameEventMember nvarchar(MAX) = NULL
,	@sCol4_GameEventMember nvarchar(MAX) = NULL
,	@sCol5_GameEventMember nvarchar(MAX) = NULL
,	@sCol6_GameEventMember nvarchar(MAX) = NULL
,	@sCol7_GameEventMember nvarchar(MAX) = NULL
,	@sCol8_GameEventMember nvarchar(MAX) = NULL
,	@sCol9_GameEventMember nvarchar(MAX) = NULL
,	@sCol10_GameEventMember nvarchar(MAX) = NULL
AS 
--��ȸ�� event�� itemid�� ������ �̿��� MemberItem�� insert or update �ϰ� �̾ GameEventMember�� insert�ؼ� �̺�Ʈ ���� ������ Ȯ��	
--itemID�� �κ��� ���� ��� MemberItem�� update
--itemID�� �κ��� ���� ��� MemberItem�� insert
--set, lock �ɼ� �� üũ
set nocount on
set xact_abort on
declare @rowcount int
set @rowcount = 0
if exists(select GameEventID from GameEvents where GameEventID like @eventID_GameEventMember and sysutcdatetime() between EventDurationFrom and EventDurationTo and HideYN like 'N' and DeleteYN like 'N' )
begin
	if upper(@InsertORUpdate) = 'INSERT' 
		begin
			begin tran
				--INSERT �� ��� MemberItems�� �߰��ϰ�,  EventMember�� ����
				--MemberItems�� �߰�
				--MemberItemID�� �⺻������ GUID ó��
				insert into MemberItems(MemberItemID, MemberID, ItemListID, ItemCount, ItemStatus, sCol1, sCol2, sCol3, sCol4, sCol5, sCol6, sCol7, sCol8, sCol9, sCol10)
				values(newid(), @MemberID_MemberItems,@ItemListID_MemberItems,@ItemCount_MemberItems,@ItemStatus_MemberItems,@sCol1_MemberItems,@sCol2_MemberItems,@sCol3_MemberItems,@sCol4_MemberItems,@sCol5_MemberItems,@sCol6_MemberItems,@sCol7_MemberItems,@sCol8_MemberItems,@sCol9_MemberItems,@sCol10_MemberItems)
				set @rowcount = @rowcount + (select @@ROWCOUNT)

				-- EventMember�� �߰� ������ �̺�Ʈ GameEventMemberID�� GUID�� �ڵ� ���Ե�
				insert into GameEventMember(GameEventMemberID, eventID, MemberID, sCol1, sCol2, sCol3, sCol4, sCol5, sCol6, sCol7, sCol8, sCol9, sCol10)
				values(newid(), @eventID_GameEventMember,@MemberID_GameEventMember,@sCol1_GameEventMember,@sCol2_GameEventMember,@sCol3_GameEventMember,@sCol4_GameEventMember,@sCol5_GameEventMember,@sCol6_GameEventMember,@sCol7_GameEventMember,@sCol8_GameEventMember,@sCol9_GameEventMember,@sCol10_GameEventMember)
				set @rowcount = @rowcount + (select @@ROWCOUNT)
			commit tran
		end
	if upper(@InsertORUpdate) = 'UPDATE'
		begin
			begin tran
				--MemberItems�� �����ϰ�,  EventMember�� �߰�
				--MemberItems�� ����
				update MemberItems set
					--, MemberItemID = CASE WHEN @MemberItemID_MemberItems is not null THEN @MemberItemID_MemberItems ELSE  MemberItemID END
					MemberID = CASE WHEN @MemberID_MemberItems is not null THEN @MemberID_MemberItems ELSE  MemberID END
					, ItemListID = CASE WHEN @ItemListID_MemberItems is not null THEN @ItemListID_MemberItems ELSE  ItemListID END
					, ItemCount = CASE WHEN @ItemCount_MemberItems is not null THEN @ItemCount_MemberItems ELSE  ItemCount END
					, ItemStatus = CASE WHEN @ItemStatus_MemberItems is not null THEN @ItemStatus_MemberItems ELSE  ItemStatus END
					, sCol1 = CASE WHEN @sCol1_MemberItems is not null THEN @sCol1_MemberItems ELSE  sCol1 END
					, sCol2 = CASE WHEN @sCol2_MemberItems is not null THEN @sCol2_MemberItems ELSE  sCol2 END
					, sCol3 = CASE WHEN @sCol3_MemberItems is not null THEN @sCol3_MemberItems ELSE  sCol3 END
					, sCol4 = CASE WHEN @sCol4_MemberItems is not null THEN @sCol4_MemberItems ELSE  sCol4 END
					, sCol5 = CASE WHEN @sCol5_MemberItems is not null THEN @sCol5_MemberItems ELSE  sCol5 END
					, sCol6 = CASE WHEN @sCol6_MemberItems is not null THEN @sCol6_MemberItems ELSE  sCol6 END
					, sCol7 = CASE WHEN @sCol7_MemberItems is not null THEN @sCol7_MemberItems ELSE  sCol7 END
					, sCol8 = CASE WHEN @sCol8_MemberItems is not null THEN @sCol8_MemberItems ELSE  sCol8 END
					, sCol9 = CASE WHEN @sCol9_MemberItems is not null THEN @sCol9_MemberItems ELSE  sCol9 END
					, sCol10 = CASE WHEN @sCol10_MemberItems is not null THEN @sCol10_MemberItems ELSE  sCol10 END
					,UpdatedAt = sysutcdatetime()
				where MemberItemID like @MemberItemID_MemberItems and MemberID like @MemberID_MemberItems
				set @rowcount = @rowcount + (select @@ROWCOUNT)

				--  GameEventMember�� �߰�	GameEventMemberID�� insert�� ������ ����
				insert into GameEventMember(GameEventMemberID, eventID, MemberID, sCol1, sCol2, sCol3, sCol4, sCol5, sCol6, sCol7, sCol8, sCol9, sCol10)
				values(newid(), @eventID_GameEventMember,@MemberID_GameEventMember,@sCol1_GameEventMember,@sCol2_GameEventMember,@sCol3_GameEventMember,@sCol4_GameEventMember,@sCol5_GameEventMember,@sCol6_GameEventMember,@sCol7_GameEventMember,@sCol8_GameEventMember,@sCol9_GameEventMember,@sCol10_GameEventMember)

				set @rowcount = @rowcount + (select @@ROWCOUNT)
			commit tran
		end

	select @rowcount as Result
end
else
	select 0 as Result	--�̺�Ʈ�� �������� �ʰų� ����
GO

/*
-----------------------------------------------------------------------
--GameEventMemberID, eventID, MemberID, sCol1, sCol2, sCol3, sCol4, sCol5, sCol6, sCol7, sCol8, sCol9, sCol10, HideYN, DeleteYN, CreatedAt, UpdatedAt, DataFromRegion, DataFromRegionDT, 
--MemberItemID, MemberID, ItemListID, ItemCount, ItemStatus, sCol1, sCol2, sCol3, sCol4, sCol5, sCol6, sCol7, sCol8, sCol9, sCol10, HideYN, DeleteYN, CreatedAt, UpdatedAt, DataFromRegion, DataFromRegionDT, 
--values(newid(), 'aaa', 'A2C03A61-41C8-496C-823B-F7B2255DE55D', '1', 'ItemStatus', 'sCol1', 'sCol2', 'sCol3', 'sCol4', 'sCol5', 'sCol6', 'sCol7', 'sCol8', 'sCol9', 'sCol10', 'N', 'N', '', '', '', '')
--values(newid(), '7A411FA7-18BC-4383-99B3-AD57FEF3AF7E', 'aaa', 'sCol1', 'sCol2', 'sCol3', 'sCol4', 'sCol5', 'sCol6', 'sCol7', 'sCol8', 'sCol9', 'sCol10', 'N', 'N', '', '', '', '' )

EXEC uspUdtGameEventMemberToItem 'INSERT',NULL,'bbb', 'A2D24A56-9314-40C4-AD5E-12F6A08C8DD9', '77', 'ItemStatus', 'sCol1', 'sCol2', 'sCol3', 'sCol4', 'sCol5', 'sCol6', 'sCol7', 'sCol8', 'sCol9', 'sCol10',    'A2C03A61-41C8-496C-823B-F7B2255DE55D' ,'bbb', 'sCol1', 'sCol2', 'sCol3', 'sCol4', 'sCol5', 'sCol6', 'sCol7', 'sCol8', 'sCol9', 'sCol10'
EXEC uspUdtGameEventMemberToItem 'UPDATE','D6B10044-7195-447C-807E-D6F52F56C03A','bbb', 'A2D24A56-9314-40C4-AD5E-12F6A08C8DD9', '1', 'ItemStatus', 'sCol1', 'sCol2', 'sCol3', 'sCol4', 'sCol5', 'sCol6', 'sCol7', 'sCol8', 'sCol9', 'sCol10', '7A411FA7-18BC-4383-99B3-AD57FEF3AF7E', 'bbb', 'sCol1', 'sCol2', 'sCol3', 'sCol4', 'sCol5', 'sCol6', 'sCol7', 'sCol8', 'sCol9', 'sCol10'
-----------------------------------------------------------------------

SELECT * FROM ItemLists
SELECT * FROM MemberItems
SELECT * FROM GameEvents
SELECT * FROM GameEventMember
*/

--DROP PROC uspSelNotices
CREATE PROC uspSelNotices
--NoticeDurationFrom�� �� �Ϸ��� ���� �κ��� ��ȣȭ ���� ���� ���̾�� ��.
--NoticeDurationFrom / To �÷��� datetimeoffset ���·� �񱳸� ���� ���� �Ǿ�� ��.
AS 
select NoticeID, NoticeCategory1, NoticeCategory2, NoticeCategory3, TargetGroup, TargetOS, TargetDevice, NoticeImageLink, title, content, sCol1, sCol2, sCol3, sCol4, sCol5, sCol6, sCol7, sCol8, sCol9, sCol10
from Notices with(nolock)
where
	--���� ���� ���ǿ� �´� �� and HideYN, DeleteYN�� N �ΰ�
	sysutcdatetime() between NoticeDurationFrom and NoticeDurationTo
and HideYN like 'N'
and DeleteYN like 'N'
order by OrderNumber asc, CreatedAt desc		-- ������ ���� �÷� ���� asc, ���� ������ �ֽ� ��
GO

/*
-----------------------------------------------------------------------
EXEC uspSelNotices 
-----------------------------------------------------------------------
SELECT * FROM Notices where sysutcdatetime() between NoticeDurationFrom and NoticeDurationTo

update Notices set DeleteYN = 'Y' ,HideYN = 'N'  where noticeID like '0F96BD6B-4237-42A5-A292-1AC12A51775A'
update Notices set DeleteYN = 'N', HideYN = 'Y' where noticeID like '6FAB7BFC-0D82-430C-A22A-175A1F05B75F'
update Notices set DeleteYN = 'N', HideYN = 'N' where noticeID like '764DABF6-9B22-4B2F-9BD2-0B785948004F'
update Notices set DeleteYN = 'Y' ,HideYN = 'Y' where noticeID like '9DC9D704-0344-4769-A818-68B761F02815'
*/

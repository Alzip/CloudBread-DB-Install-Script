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
SELECT * FROM Notices 
SELECT * FROM Notices where sysutcdatetime() between NoticeDurationFrom and NoticeDurationTo
*/

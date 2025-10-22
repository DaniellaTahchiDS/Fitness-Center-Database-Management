WITH MemberPatterns AS (
    SELECT * FROM fn_GetMemberAttendancePatterns(6)
)
SELECT 
    member_name,
    COUNT(DISTINCT class_name) as different_classes_attended,
    MAX(attendance_count) as max_class_attendance,
    STRING_AGG(class_name + ' (' + CAST(attendance_count as varchar) + ' times)', '; ') as class_preference
FROM MemberPatterns
GROUP BY member_id, member_name
HAVING COUNT(DISTINCT class_name) > 1
ORDER BY different_classes_attended DESC;
CREATE FUNCTION dbo.GetClassOpenCount
(
    @ClassID INT  -- Input parameter for the class ID
)
RETURNS INT  -- Return type
AS
BEGIN
    DECLARE @Result INT;

    SELECT
        @Result = COUNT( sbm.schedule_id)  -- Count distinct schedule IDs
    FROM
        classes c
    JOIN
        class_schedule s ON c.class_id = s.class_id  -- Join on the schedule table
    JOIN
        schedule_by_month sbm ON s.schedule_id = sbm.schedule_id  -- Join on the schedule_by_month table
    WHERE
        c.class_id = @ClassID;  -- Filter by class ID

    RETURN @Result;  -- Return the count
END;

;  -- Replace 1 with the desired class ID
CREATE FUNCTION fn_tot_revenue()
RETURNS 
DECIMAL(10,2) 
AS 
BEGIN
	DECLARE @tot_rev DECIMAL(10,2);
	SELECT @tot_rev= SUM(CASE
		WHEN p.session_status='Complete' THEN p.fee
		WHEN p.session_status='Scheduled' THEN 0
		WHEN p.session_status='Cancelled' THEN 0
		WHEN p.session_status='No-Show' THEN p.fee/2
		END) 
	FROM personal_training_sessions p;
	RETURN @tot_rev;

END;


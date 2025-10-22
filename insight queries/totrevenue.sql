SELECT 
	dbo.fn_tot_revenue() as total_revenue,
	CAST((dbo.fn_tot_revenue()/1.25) AS DECIMAL(10,1)) as profit,
	CAST((dbo.fn_tot_revenue()/1.25)*100/dbo.fn_tot_revenue() AS DECIMAL(10,1)) as profit_margin

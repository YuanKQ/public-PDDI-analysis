  
	--QT Prolong Set Drugbank IDs
	UPDATE o
	SET o.DrugbankID = d.[drugbankid] 
	FROM [PDDI_Databases].[dbo].[QTDrugs_CredibleMed]  o	
		INNER JOIN [PDDI_Databases].[dbo].[DrugbankDrugs] d ON d.name= o.[Generic Name] 
	WHERE o.DrugbankID IS NULL


	 
	 --Levomethadyl (Levomethadyl Not In USA, it is also known as levomethadyl acetate) 
	UPDATE o
	SET DrugbankID = 'DB01227'
	FROM [PDDI_Databases].[dbo].[QTDrugs_CredibleMed] o
	WHERE [Generic Name] = 'Levomethadyl' 
	
	SELECT *
	FROM [PDDI_Databases].[dbo].[QTDrugs_CredibleMed]  o	
		LEFT JOIN [PDDI_Databases].[dbo].[DrugbankDrugs] d ON d.name= o.[Generic Name] 
	WHERE o.DrugbankID IS NULL


	--Insert QT Prolonging Agents
	INSERT INTO  [PDDI_Databases].[dbo].[ONC_High_Priority]
	([ID],[Object_Class] ,[Object_Drug],[Obj_DrugbankID],[Preciptiant_Class],[Precipitant_Drug],[Pre_DrugbankID])
	SELECT  DISTINCT
			'21',
			'QT prolonging agents',
			a.[Generic Name],
			a.DrugbankID,
			'QT prolonging agents',
			b.[Generic Name],
			b.DrugbankID
	FROM [PDDI_Databases].[dbo].[QTDrugs_CredibleMed] a
		cross join [PDDI_Databases].[dbo].[QTDrugs_CredibleMed] b 
	where a.[Generic Name]<>b.[Generic Name]


  -- Remove Class placehoder
  --DELETE FROM [PDDI_Databases].[dbo].[ONC_High_Priority] where [Object_Class]='QT prolonging agents' and [Obj_DrugbankID] is null

  SELECT  [ID]
      ,[Object_Class]
      ,[Object_Drug]
      ,[Obj_DrugbankID]
      ,[Preciptiant_Class]
      ,[Precipitant_Drug]
      ,[Pre_DrugbankID]
  FROM [PDDI_Databases].[dbo].[ONC_High_Priority]
  where [Object_Class]='QT prolonging agents' 

Config = {}

-- Ped Configuration
Config.PedModel = 'a_m_m_business_01'  -- Change this to the model you want
Config.PedLocation = vector4(-25.58, -1255.88, 29.19, 38.31)

-- QB-Target Configuration
Config.TargetLabel = "Wash Black Money"
Config.InteractionEvent = "260-moneywash"  -- Event triggered when selecting the option

-- Money Washing Configuration
Config.BlackMoneyItem = "black_money"  -- The item representing black money
Config.WashRate = 0.8  -- Rate at which black money is converted to clean cash (e.g., 80%)
Config.ProgressBarTime = 5000  -- Time in milliseconds for the progress bar (5 seconds)
Config.ProgressBarLabel = "Washing Money"
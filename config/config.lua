Config = {}

Config.Framework = 'ESX' -- Options: 'ESX', 'QBCore'

Config.Debug = true
Config.checkForUpdates = true
Config.Webhook = "https://discord.com/api/webhooks/1230924865368756285/rVjEew3Gk_kBIMLPjHgmLPtPCXwwsDGb6q6QNcMhovmPMONvCLgT7GpVx8aILATR6hO9"

Config.Declared = 'Declared Dead. Please Respawn!' -- This Msg appeared when the player died using /med [id] to display blood = 0 - 5% and Hurt area is Head
Config.Timer = 8   -- Timer to Remove Med Display after using Med System

Config.jobs = {
	names = {
		ambulance = true, 
		police =  true, 
		kmar = true,
	}
}

-- This is used for the radial menu (hw_radialmenu)
Config.IDmode = 'own' -- If Config.IDmode is 'own', it defines a function SendMedicalRequest to send medical requests for the player themselves.
                      -- If Config.IDmode is 'player', it checks nearby players and sends medical requests for the nearest one.
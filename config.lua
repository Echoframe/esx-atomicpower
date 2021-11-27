Config                      = {}
Config.DrawDistance         = 10
Config.InteractionDistance	= 2.5
Config.Locale				='de'

Config.Zones = {
	quarryLocation = {coords = vector3(2942.1, 2794.2, 40.52), name = _U('uran_s1'), color = 25, sprite = 51},
	carParkInside = {coords = vector3(3613.47, 3741, 28.69), name = _U('uran_s2'), color = 25, sprite = 402}, --heading = 322.22},
	changingRoom = {coords = vector3(3561.3, 3682.51, 28.12), name = _U('uran_s3'), color = 25, sprite = 402},
	placeBox = {coords = vector3(3559.25, 3671.98, 28.12), name = _U('uran_s4'), color = 25, sprite = 51}, --heading = 345.24},
	cleanUranium = {coords = vector3(3561.59, 3670.62, 28.12), name = _U('uran_s5'), color = 25, sprite = 402}, --heading = 260.41},
	processUranium = {coords = vector3(3536.84, 3662.93, 28.12), name = _U('uran_s5'), color = 25, sprite = 51}, --heading = 172.33},
	liftTPLevel1 = {coords = vector3(3540.7, 3675.64, 28.12), name = _U('uran_s6'), color = 25, sprite = 51},
	liftTPLevel2 = {coords = vector3(3532.19, 3672.83, 20.99), name = _U('uran_s7'), color = 25, sprite = 51},
	tpArrivalUG = {coords = vector3(3529.3, 3697.7, 20.99), name = _U('placeholder'), color = 25, sprite = 402},
	tpArrivalOG = {coords = vector3(3540.1, 3671.32, 28.12), name = _U('placeholder'), color = 25, sprite = 402}, --heading = 74.27},
	sellUranium = {coords = vector3(3521.37, 3706.51, 20.99), name = _U('uran_s8'), color = 25, sprite = 51}, --actually press location
	hustleUranium = {coords = vector3(-261.44, 4731.62, 136.94), name = _U('uran_s9a'), color = 25, sprite = 272, isBoss = true},
}


--currently useless
Config.Delays = {
	upackUranium = 1,
	--collectUranium = 30,
	cleanUranium = 1,
	processUranium = 1,
	sellUranium = 1,
	hustleUranium = 1
}

Config.Pay = 500

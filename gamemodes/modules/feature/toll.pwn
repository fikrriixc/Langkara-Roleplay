new tolgate[10];
new PaytollAreaid[11];

CreatePaytollAreaid()
{
	//TOL LV
	tolgate[0] = CreateDynamicObject(968, 1807.947021, 821.503417, 10.610667, 0.000000, 89.899971, 0.000000, -1, -1, -1, 200.00, 200.00); //TOLL LV1 23
	tolgate[1] = CreateDynamicObject(968, 1805.447753, 821.524658, 10.560406, 0.000000, -90.299957, -0.000000, -1, -1, -1, 200.00, 200.00); //TOL LV2 25
	tolgate[2] = CreateDynamicObject(968, 1788.649291, 803.113159, 10.900191, 0.000000, 90.299942, -0.099992, -1, -1, -1, 200.00, 200.00); //TOLL LV3 28
	tolgate[3] = CreateDynamicObject(968, 1787.745727, 803.114807, 10.881714, 0.000000, -90.299926, 0.000000, -1, -1, -1, 200.00, 200.00); //TOLL LV4 29

	//TOL FLINT
	tolgate[4] = CreateDynamicObject(968, 41.159236, -1526.555419, 5.092908, 0.000000, 89.999961, 80.200096, -1, -1, -1, 200.00, 200.00); //TOLL FLINT1 92
	tolgate[5] = CreateDynamicObject(968, 65.120658, -1536.429077, 4.809195, 0.000000, -90.199958, 82.400070, -1, -1, -1, 200.00, 200.00); //TOLL FLINT2 91

	//TOL RED BRIDGE
	tolgate[6] = CreateDynamicObject(968, -165.864074, 374.415924, 11.875398, 0.000000, -89.999954, 163.700042, -1, -1, -1, 200.00, 200.00); //TOLL RED BRIDGE1 112
	tolgate[7] = CreateDynamicObject(968, -172.951614, 349.509979, 11.878129, 0.000000, -89.999961, -15.499999, -1, -1, -1, 200.00, 200.00); //TOLL RED BRIDGE2 109

	//TOL GREY BRIDGE
	tolgate[8] = CreateDynamicObject(968, 509.552917, 488.096923, 18.707580, 0.000000, -89.800018, -144.800003, -1, -1, -1, 200.00, 200.00); //TOLL GREY BRIDGE 122
	tolgate[9] = CreateDynamicObject(968, 524.426269, 467.211395, 18.679878, 0.000000, -89.800010, 35.199996, -1, -1, -1, 200.00, 200.00); //TOLL GREY BRIDGE 121
	
	PaytollAreaid[0] = CreateDynamicSphere(1811.87, 816.24, 10.80, 10.0, 0); //GERBANG TOL LV 1
	PaytollAreaid[2] = CreateDynamicSphere(1801.70, 816.45, 10.80, 10.0, 0); //GERBANG TOL LV 2
	PaytollAreaid[3] = CreateDynamicSphere(1792.55, 807.30, 10.99, 10.0, 0); //GERBANG TOL LV 3
	PaytollAreaid[4] = CreateDynamicSphere(1784.32, 807.17, 10.99, 10.0, 0); //GERBANG TOL LV 4
	PaytollAreaid[5] = CreateDynamicSphere(47.19, -1523.98, 5.10, 10.0, 0); //GERBANG TOL FLINT 1
	PaytollAreaid[6] = CreateDynamicSphere(59.95, -1539.47, 5.08, 10.0, 0); //GERBANG TOL FLINT 2
	PaytollAreaid[7] = CreateDynamicSphere(-163.65, 369.43, 12.07, 10.0, 0); //GERBANG TOL RED BRIDGE 1
	PaytollAreaid[8] = CreateDynamicSphere(-175.23, 354.51, 12.07, 10.0, 0); //GERBANG TOL RED BRIDGE 2
	PaytollAreaid[9] = CreateDynamicSphere(514.60, 486.95, 18.92, 10.0, 0); //GERBANG TOL RED BRIDGE 3
	PaytollAreaid[10] = CreateDynamicSphere(519.32, 468.13, 18.92, 10.0, 0); //GERBANG TOL RED BRIDGE 4
}

CMD:paytoll(playerid, params[])
{
	OpenPaytoll(playerid);
	return 1;
}

OpenPaytoll(playerid)
{
	if(PlayerData[playerid][pMoney] < 5)
		return SendErrorMessage(playerid, "Kamu harus memiliki uang $5.00 untuk membayar toll");

	if(IsPlayerInRangeOfPoint(playerid, 5.5, 1811.87, 816.24, 10.80)) //GERBANG TOL LV1
	{
		MoveDynamicObject(tolgate[0], 1807.947021, 821.503417, 10.610667, 2.00, 0.000000, 8.099967, 0.000000);
		SetTimerEx("ClosePaytol", 6000, false, "i", 0);

		GivePlayerMoneyEx(playerid, -5);
		SendInfoMessage(playerid, "Kamu telah membuka gerbang Tol Las Venturas 1 dengan biaya "RED_E"$5,00");

		Server_AddMoney(5);
	}
	else if(IsPlayerInRangeOfPoint(playerid, 5.5, 1801.70, 816.45, 10.80)) //GERBANG TOL LV2
	{
		MoveDynamicObject(tolgate[1], 1805.447753, 821.524658, 10.560406, 2.00, 0.000000, -8.999938, -0.000000);
		SetTimerEx("ClosePaytol", 6000, false, "i", 1);

		GivePlayerMoneyEx(playerid, -5);
		SendInfoMessage(playerid, "Kamu telah membuka gerbang Tol Las Venturas 2 dengan biaya "RED_E"$5,00");

		Server_AddMoney(5);
	}
	else if(IsPlayerInRangeOfPoint(playerid, 5.5, 1792.55, 807.30, 10.99)) //GERBANG TOL LV3
	{
		MoveDynamicObject(tolgate[2], 1788.649291, 803.113159, 10.900191, 2.00, 0.000000, 8.999918, -0.099992);
		SetTimerEx("ClosePaytol", 6000, false, "i", 2);

		GivePlayerMoneyEx(playerid, -5);
		SendInfoMessage(playerid, "Kamu telah membuka gerbang Tol Las Venturas 3 dengan biaya "RED_E"$5,00"); 

		Server_AddMoney(5);
	}
	else if(IsPlayerInRangeOfPoint(playerid, 5.5, 1784.32, 807.17, 10.99)) //GERBANG TOL LV4
	{
		MoveDynamicObject(tolgate[3], 1787.745727, 803.114807, 10.881713, 2.00, 0.000000, -16.699935, 0.000000);
		SetTimerEx("ClosePaytol", 6000, false, "i", 3);

		GivePlayerMoneyEx(playerid, -5);
		SendInfoMessage(playerid, "Kamu telah membuka gerbang Tol Las Venturas 4 dengan biaya "RED_E"$5,00");

		Server_AddMoney(5);
	}
	else if(IsPlayerInRangeOfPoint(playerid, 5.5, 47.19, -1523.98, 5.10)) //GERBANG FLINT1
	{
		MoveDynamicObject(tolgate[4], 41.159236, -1526.555419, 5.092907, 2.00, 0.000000, 9.799967, 80.200096);
		SetTimerEx("ClosePaytol", 6000, false, "i", 4);

		GivePlayerMoneyEx(playerid, -5);
		SendInfoMessage(playerid, "Kamu telah membuka gerbang Tol Flint 1 dengan biaya "RED_E"$5,00");

		Server_AddMoney(5);
	}
	else if(IsPlayerInRangeOfPoint(playerid, 5.5, 59.95, -1539.47, 5.08)) //GERBANG FLINT2
	{
		MoveDynamicObject(tolgate[5], 65.120658, -1536.429077, 4.809195, 2.00, 0.000000, -11.799952, 82.400070);
		SetTimerEx("ClosePaytol", 6000, false, "i", 5);

		GivePlayerMoneyEx(playerid, -5);
		SendInfoMessage(playerid, "Kamu telah membuka gerbang Tol Flint 2 dengan biaya "RED_E"$5,00");

		Server_AddMoney(5);
	}
	else if(IsPlayerInRangeOfPoint(playerid, 5.5, -163.65, 369.43, 12.07)) //GERBANG RED BRIDGE1
	{
		MoveDynamicObject(tolgate[6], -165.864074, 374.415924, 11.875398, 2.00, 0.000000, -8.199937, 163.700042);
		SetTimerEx("ClosePaytol", 6000, false, "i", 6);

		GivePlayerMoneyEx(playerid, -5);
		SendInfoMessage(playerid, "Kamu telah membuka gerbang Tol Red Bridge 1 dengan biaya "RED_E"$5,00");

		Server_AddMoney(5);
	}
	else if(IsPlayerInRangeOfPoint(playerid, 5.5, -175.23, 354.51, 12.07)) //GERBANG RED BRIDGE2
	{
		MoveDynamicObject(tolgate[7], -172.951614, 349.509979, 11.878129, 2.00, 0.000000, -10.199941, -15.499999);
		SetTimerEx("ClosePaytol", 6000, false, "i", 7);

		GivePlayerMoneyEx(playerid, -5);
		SendInfoMessage(playerid, "Kamu telah membuka gerbang Tol Red Bridge 2 dengan biaya "RED_E"$5,00");

		Server_AddMoney(5);
	}
	else if(IsPlayerInRangeOfPoint(playerid, 5.5, 514.60, 486.95, 18.92)) //GERBANG GREY BRIDGE1
	{
		MoveDynamicObject(tolgate[8], 509.552917, 488.096923, 18.707580, 2.00, 0.000000, -7.999981, -144.800003);
		SetTimerEx("ClosePaytol", 6000, false, "i", 8);

		GivePlayerMoneyEx(playerid, -5);
		SendInfoMessage(playerid, "Kamu telah membuka gerbang Tol Grey Bridge 1 dengan biaya "RED_E"$5,00");

		Server_AddMoney(5);
	}
	else if(IsPlayerInRangeOfPoint(playerid, 5.5, 519.32, 468.13, 18.92)) //GERBANG GREY BRIDGE2
	{
		MoveDynamicObject(tolgate[9], 524.426269, 467.211395, 18.679878, 2.00, 0.000000, -13.800021, 35.199996);
		SetTimerEx("ClosePaytol", 6000, false, "i", 9);

		GivePlayerMoneyEx(playerid, -5);
		SendInfoMessage(playerid, "Kamu telah membuka gerbang Tol Grey Bridge 2 dengan biaya "RED_E"$5,00");

		Server_AddMoney(5);
	}
	else
	{
		SendErrorMessage(playerid, "Kamu tidak berada dipintu toll manapun");
	}
	return 1;
}

public:ClosePaytol(tolid)
{
	switch(tolid)
	{
		case 0:
		{
			MoveDynamicObject(tolgate[0], 1807.947021, 821.503417, 10.610667, 2.00, 0.000000, 89.899971, 0.000000);
		}
		case 1:
		{
			MoveDynamicObject(tolgate[1], 1805.447753, 821.524658, 10.560406, 2.00, 0.000000, -90.299957, -0.000000);
		}
		case 2:
		{
			MoveDynamicObject(tolgate[2], 1788.649291, 803.113159, 10.900191, 2.00, 0.000000, 90.299942, -0.099992);
		}
		case 3:
		{
			MoveDynamicObject(tolgate[3], 1787.745727, 803.114807, 10.881714, 2.00, 0.000000, -90.299926, 0.000000);
		}
		case 4:
		{
			MoveDynamicObject(tolgate[4], 41.159236, -1526.555419, 5.092908, 2.00, 0.000000, 89.999961, 80.200096);
		}
		case 5:
		{
			MoveDynamicObject(tolgate[5], 65.120658, -1536.429077, 4.809195, 2.00, 0.000000, -90.199958, 82.400070);
		}
		case 6:
		{
			MoveDynamicObject(tolgate[6], -165.864074, 374.415924, 11.875398, 2.00, 0.000000, -89.999954, 163.700042);
		}
		case 7:
		{
			MoveDynamicObject(tolgate[7], -172.951614, 349.509979, 11.878129, 2.00, 0.000000, -89.999961, -15.499999);
		}
		case 8:
		{
			MoveDynamicObject(tolgate[8], 509.552917, 488.096923, 18.707580, 2.00, 0.000000, -89.800018, -144.800003);
		}
		case 9:
		{
			MoveDynamicObject(tolgate[9], 524.426269, 467.211395, 18.679878, 2.00, 0.000000, -89.800010, 35.199996);
		}
	}
}

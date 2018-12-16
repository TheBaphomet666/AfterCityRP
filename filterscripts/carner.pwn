#define FILTERSCRIPT

#include <a_samp>

#if defined FILTERSCRIPT
new turismo;
new journey;
new greenwood;
new train;
new burrito;
new coach;
new banshee;
new bullet;
new reefer;
new anotherreefer;
new beagle;
#define red 0xff0000ff
public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Veh Rent by Patch");
	print("--------------------------------------\n");
    turismo = AddStaticVehicle(451,521.4819,-1884.0389,2.9543,175.7823,0,1);
    journey = AddStaticVehicle(508,527.7382,-1892.7366,3.0804,40.0446,0,1);
    greenwood = AddStaticVehicle(492,517.9128,-1890.2708,2.3596,271.0002,0,1);
    train = AddStaticVehicle(515,507.6303,-1891.5265,3.0404,305.2104,0,1);
    burrito = AddStaticVehicle(482,515.8115,-1877.8397,3.5063,325.7825,0,1);
    coach = AddStaticVehicle(437,523.9806,-1878.1846,3.6595,30.4993,0,1);
    banshee = AddStaticVehicle(429,510.2533,-1877.4541,3.0302,217.2429,0,1);
    bullet = AddStaticVehicle(541,516.1109,-1872.2650,3.2366,121.5277,0,1);
    reefer = AddStaticVehicle(453,522.4061,-1913.4445,-0.1351,332.3892,0,1);
    anotherreefer = AddStaticVehicle(453,502.3423,-1914.6558,-0.1494,353.5470,0,1);
    beagle = AddStaticVehicle(511,518.8189,-1838.2225,6.3908,180.2943,0,1);
	return 1;
}

public OnFilterScriptExit()
{
	DestroyVehicle(turismo);
	DestroyVehicle(journey);
	DestroyVehicle(greenwood);
	DestroyVehicle(train);
	DestroyVehicle(burrito);
	DestroyVehicle(coach);
	DestroyVehicle(banshee);
	DestroyVehicle(bullet);
	DestroyVehicle(reefer);
	DestroyVehicle(anotherreefer);
	DestroyVehicle(beagle);
	return 1;
}





#endif





public OnPlayerCommandText(playerid, cmdtext[])
{
if (strcmp("/rent", cmdtext, true, 10) == 0)
{
	new Vehicle = GetPlayerVehicleID(playerid);
	if(Vehicle == turismo)
{
	new Money = GetPlayerMoney(playerid);
	if(Money <= 299)
{
		SendClientMessage(playerid,red,"You Dont have Enough Money");
}
	else
{
		SendClientMessage(playerid,red,"You Rented this Vehicle");
		TogglePlayerControllable(playerid,1);
		GivePlayerMoney(playerid,-300);
}
}
	if(Vehicle == greenwood)
{
	new Money = GetPlayerMoney(playerid);
	if(Money <= 349)
{
		SendClientMessage(playerid,red,"You Dont Have Enough Money");
}
	else
{
		SendClientMessage(playerid,red,"You Rented this Vehicle");
		TogglePlayerControllable(playerid,1);
		GivePlayerMoney(playerid,-350);
}
}
	if(Vehicle == train)
{
	new Money = GetPlayerMoney(playerid);
	if(Money <= 599)
{
		SendClientMessage(playerid,red,"You Dont Have Enough Money");
}
	else
{
		SendClientMessage(playerid,red,"You Rented this Vehicle");
		TogglePlayerControllable(playerid,1);
		GivePlayerMoney(playerid,-600);
}
}
	if(Vehicle == burrito)
{
	new Money = GetPlayerMoney(playerid);
	if(Money <= 199)
{
		SendClientMessage(playerid,red,"You Dont Have Enough Money");
}
	else
{
		SendClientMessage(playerid,red,"You Rented this Vehicle");
		TogglePlayerControllable(playerid,1);
		GivePlayerMoney(playerid,-200);
}
}
	if(Vehicle == coach)
{
	new Money = GetPlayerMoney(playerid);
	if(Money <= 299)
{
		SendClientMessage(playerid,red,"You Dont Have Enough Money");
}
	else
{
		SendClientMessage(playerid,red,"You Rented this Vehicle");
		TogglePlayerControllable(playerid,1);
		GivePlayerMoney(playerid,-300);
}
}
	if(Vehicle == banshee)
{
	new Money = GetPlayerMoney(playerid);
	if(Money <= 499)
{
		SendClientMessage(playerid,red,"You Dont Have Enough Money");
}
	else
{
		SendClientMessage(playerid,red,"You Rented this Vehicle");
		TogglePlayerControllable(playerid,1);
		GivePlayerMoney(playerid,-500);
}
}
	if(Vehicle == bullet)
{
	new Money = GetPlayerMoney(playerid);
	if(Money <= 499)
{
		SendClientMessage(playerid,red,"You Dont Have Enough Money");
}
	else
{
		SendClientMessage(playerid,red,"You Rented this Vehicle");
		TogglePlayerControllable(playerid,1);
		GivePlayerMoney(playerid,-500);
}
}
	if(Vehicle == reefer)
{
	new Money = GetPlayerMoney(playerid);
	if(Money <= 499)
{
		SendClientMessage(playerid,red,"You Dont Have Enough Money");
}
	else
{
		SendClientMessage(playerid,red,"You Rented this Vehicle");
		TogglePlayerControllable(playerid,1);
		GivePlayerMoney(playerid,-500);
}
}
	if(Vehicle == anotherreefer)
{
	new Money = GetPlayerMoney(playerid);
	if(Money <= 499)
{
		SendClientMessage(playerid,red,"You Dont Have Enough Money");
}
	else
{
		SendClientMessage(playerid,red,"You Rented this Vehicle");
		TogglePlayerControllable(playerid,1);
		GivePlayerMoney(playerid,-500);
}
}
	if(Vehicle == beagle)
{
	new Money = GetPlayerMoney(playerid);
	if(Money <= 799)
{
		SendClientMessage(playerid,red,"You Dont Have Enough Money");
}
	else
{
		SendClientMessage(playerid,red,"You Rented this Vehicle");
		TogglePlayerControllable(playerid,1);
		GivePlayerMoney(playerid,-600);
}
}
	if(Vehicle == journey)
{
	new Money = GetPlayerMoney(playerid);
	if(Money <= 399)
{
		SendClientMessage(playerid,red,"You Dont have Enough Money");
}
	else
{
		SendClientMessage(playerid,red,"You Rented this Vehicle");
		TogglePlayerControllable(playerid,1);
		GivePlayerMoney(playerid,-400);
}
}
	return 1;
}
if (strcmp("/exit", cmdtext, true, 10) == 0)
{
		RemovePlayerFromVehicle(playerid);
		TogglePlayerControllable(playerid,1);
		return 1;
}
if (strcmp("/help", cmdtext, true, 10) == 0)
{
		SendClientMessage(playerid,red,"/carrental");
		return 1;
}
if (strcmp("/carrental", cmdtext, true, 10) == 0)
{
		if(IsPlayerInAnyVehicle(playerid))
		{
		RemovePlayerFromVehicle(playerid);
		SetPlayerPos(playerid,505.9222,-1844.0022,4.6405);
		}
		else
		{
		SetPlayerPos(playerid,505.9222,-1844.0022,4.6405);
		}
		return 1;
}
return 0;
}


public OnPlayerExitVehicle(playerid, vehicleid)
{
    new Vehicle = GetPlayerVehicleID(playerid);
   	if(Vehicle == turismo)
   	{
		SetVehicleHealth(vehicleid,0);
	}
	if(Vehicle == journey)
   	{
		SetVehicleHealth(vehicleid,0);
	}
	if(Vehicle == greenwood)
	{
	    SetVehicleHealth(vehicleid,0);
	}
	if(Vehicle == train)
	{
	    SetVehicleHealth(vehicleid,0);
	}
	if(Vehicle == burrito)
	{
	    SetVehicleHealth(vehicleid,0);
	}
	if(Vehicle == coach)
	{
	    SetVehicleHealth(vehicleid,0);
	}
	if(Vehicle == banshee)
	{
	    SetVehicleHealth(vehicleid,0);
	}
	if(Vehicle == bullet)
	{
	    SetVehicleHealth(vehicleid,0);
	}
	if(Vehicle == reefer)
	{
	    SetVehicleHealth(vehicleid,0);
	}
	if(Vehicle == anotherreefer)
	{
	    SetVehicleHealth(vehicleid,0);
	}
	if(Vehicle == beagle)
	{
	    SetVehicleHealth(vehicleid,0);
	}
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_DRIVER)
	{
	new Vehicle = GetPlayerVehicleID(playerid);
	if(Vehicle == turismo)
	{
	SendClientMessage(playerid,red,"To Rent This car for 300$ Type /rent  If you dont wish to rent it, write /exit");
	TogglePlayerControllable(playerid,0);
	}
	if(Vehicle == journey)
	{
	SendClientMessage(playerid,red,"To Rent This car for 400$ Type /rent  If you dont wish to rent it, write /exit");
	TogglePlayerControllable(playerid,0);
	}
	if(Vehicle == greenwood)
	{
	SendClientMessage(playerid,red,"To Rent This car for 350$ Type /rent  If you dont wish to rent it, write /exit");
	TogglePlayerControllable(playerid,0);
	}
	if(Vehicle == train)
	{
	SendClientMessage(playerid,red,"To Rent This car for 600$ Type /rent  If you dont wish to rent it, write /exit");
	TogglePlayerControllable(playerid,0);
	}
	if(Vehicle == burrito)
	{
	SendClientMessage(playerid,red,"To Rent This car for 200$ Type /rent  If you dont wish to rent it, write /exit");
	TogglePlayerControllable(playerid,0);
	}
 	if(Vehicle == coach)
	{
	SendClientMessage(playerid,red,"To Rent This car for 300$ Type /rent  If you dont wish to rent it, write /exit");
	TogglePlayerControllable(playerid,0);
	}
	if(Vehicle == banshee)
	{
	SendClientMessage(playerid,red,"To Rent This car for 500$ Type /rent  If you dont wish to rent it, write /exit");
	TogglePlayerControllable(playerid,0);
	}
    if(Vehicle == bullet)
	{
	SendClientMessage(playerid,red,"To Rent This car for 500$ Type /rent  If you dont wish to rent it, write /exit");
	TogglePlayerControllable(playerid,0);
	}
	if(Vehicle == reefer)
	{
	SendClientMessage(playerid,red,"To Rent This car for 500$ Type /rent  If you dont wish to rent it, write /exit");
	TogglePlayerControllable(playerid,0);
	}
    if(Vehicle == anotherreefer)
	{
	SendClientMessage(playerid,red,"To Rent This car for 500$ Type /rent  If you dont wish to rent it, write /exit");
	TogglePlayerControllable(playerid,0);
	}
    if(Vehicle == beagle)
	{
	SendClientMessage(playerid,red,"To Rent This car for 800$ Type /rent  If you dont wish to rent it, write /exit");
	TogglePlayerControllable(playerid,0);
	}

	}
	return 1;
}



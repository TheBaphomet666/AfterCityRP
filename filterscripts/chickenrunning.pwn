// Chicken Run Detector

#include <a_samp>
#include <foreach>

#define FILTERSCRIPT
#define COLOR_LIGHTRED 0xFF6347FF

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Chicken Run Detector Loaded");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	print("\n--------------------------------------");
	print(" Chicken Run Detector Unloaded");
	print("--------------------------------------\n");
	return 1;
}

public OnPlayerConnect(playerid)
{
	SetTimerEx("ChickenRun", 1000, true, "i", playerid);
	return 1;
}

forward ChickenRun(playerid);
public ChickenRun(playerid)
{
	foreach(Player, i)
	{
		if(IsPlayerNearPlayer(i, playerid, 10))
		{
		    new Float:Velocity[3];
			GetPlayerVelocity(i, Velocity[0], Velocity[1], Velocity[2]);
			if(Velocity[0] > 10 && Velocity[1] > 10)
			{
			    TogglePlayerControllable(i, false);
			    SetTimerEx("Unfreeze", 1000, false, "i", i);
                GameTextForPlayer(playerid, "Stop Chicken Running!", 3000, 1);
            }
        }
    }
}

forward Unfreeze(playerid);
public Unfreeze(playerid)
{
	TogglePlayerControllable(playerid, true);
}

stock IsPlayerNearPlayer(playerid, targetid, Float:radius)
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(targetid, x, y, z);
	if(IsPlayerInRangeOfPoint(playerid, radius ,x, y, z))
	{
	    return 1;
	}
	return 0;
}

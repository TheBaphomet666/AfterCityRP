// Mask System

#include <a_samp>
#include <foreach>
#include <streamer>

#define FILTERSCRIPT
#define COLOR_LIGHTRED 0xFF6347FF

//You need to add these at the top obviously
new Text3D:MaskText[MAX_PLAYERS];
new Masked[

//These functions need to be added to the file saving system (I believe MySQL in your case)
	// to enum as well
	Mask,
	Masked,
	MaskID,

// Make sure that when a player buys a mask you set it to do these things:


accountInformation[playerid][Mask] = 1;
new rand = 100 + random(1254);
accountInformation[playerid][MaskID] = rand;

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Mask System for Bone County Roleplay");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}
//Add this stuff to where it corresponds
public OnPlayerText(playerid, text)
{
	if(PlayerInfo[playerid][Masked] == 1)
    {
        format(string, sizeof(string), "Stranger %d says: %s", accountInformation[playerid][MaskID], text);
        // Accent with the mask if you wish
    }
}

public OnPlayerConnect(playerid)
{
	accountInformation[playerid][Masked] = 0;
	return 1;
}

CMD:mask(playerid, params[])
{
    if(accountInformation[playerid][Mask] != 1) return SendClientMessage(playerid, COLOR_GREY, "You need to buy a mask from a 24/7!.");
    if(accountInformation[playerid][Masked] == 0)
    {
		SendClientMessage(playerid, COLOR_WHITE, "You have put on a mask! (/mask to remove it)");
		new string[128];
		format(string, sizeof(string), "* %s pulls out a mask and places it over their face", RemoveUnderScore(playerid));
		//Or whatever your message function is
		SendNearbyMessage(playerid, 15, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
		accountInformation[playerid][Masked] = 1;
		if(IsValidDynamic3DTextLabel(MaskText[playerid])) DestroyDynamic3DTextLabel(MaskText[playerid]);
        format(string, sizeof(string), "Stranger %d",  accountInformation[playerid][pMaskID]);
  		MaskText[playerid] = CreateDynamic3DTextLabel(string, COLOR_GREY, 0, 0, -20, 25, playerid);
    	Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, MaskText[playerid] , E_STREAMER_ATTACH_OFFSET_Z, 0.25);
		for(new i = 0; i < MAX_PLAYERS; i++)
        {
            ShowPlayerNameTagForPlayer(i, playerid, 0);
        }
    }
    else
    {
        accountInformation[playerid][Masked] = 0;
        SendClientMessage(playerid, COLOR_WHITE, "You have removed your mask!"); // This is message what was send when you remove your mask
        new string[128];
		format(string, sizeof(string), "* %s pulls off their mask", RemoveUnderScore(playerid));
		SendNearbyMessage(playerid, 15, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
		DestroyDynamic3DTextLabel(MaskText[playerid]);
		{
        	for(new i = 0; i < MAX_PLAYERS; i++)
         	{
          		ShowPlayerNameTagForPlayer(i, playerid, 1);
            }
            return 1;
        }
    }
    return 1;
}

CMD:masked(playerid, params[])
{
    new string[128];
	if(accountInformation[playerid][Admin] < 2) return SendClientMessage(playerid, COLOR_GREY, "You are not authorized to use this command.");
	SendClientMessage(playerid, COLOR_WHITE, "<---Masked Players--->");
	for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i))
        {
            if(PlayerInfo[i][Masked])
            {
                format(string, sizeof(string), "ID: %s, Name: %s", i, RemoveUnderScore(playerid));
                SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
            }
        }
    }
	return 1;
}

stock RemoveUnderScore(playerid)
{
    new name[MAX_PLAYER_NAME];
    GetPlayerName(playerid,name,sizeof(name));
    for(new i = 0; i < MAX_PLAYER_NAME; i++) {
        if(name[i] == '_') name[i] = ' ';
    }
    if(PlayerInfo[playerid][pMasked] == 1)
    {
    	format(name, sizeof(name), "Stranger %d", accountInformation[playerid][MaskID]));
    }
    return name;
}

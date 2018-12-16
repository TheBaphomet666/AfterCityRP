//
// Barricade by Joshman543 keep the credits
//
#include <a_samp>
#include <zcmd>
#include <foreach>
#include <sscanf2>

#define FILTERSCRIPT
// Colors
#define COLOR_WHITE 0xFFFFFFFF
#define COLOR_FADE1 0xE6E6E6E6
#define COLOR_PM1 0xA65FC7FF
#define COLOR_PM2 0xD35FC7FF
#define COLOR_FADE2 0xC8C8C8C8
#define COLOR_FADE3 0xAAAAAAAA
#define COLOR_FADE4 0x8C8C8C8C
#define COLOR_FADE5 0x6E6E6E6E
#define TEAM_GROVE_COLOR 0x00AA00FF
#define COLOR_OOC 0xE0FFFFFF
#define COLOR_GREY 0xAFAFAFFF
#define COLOR_LIGHTGREEN 0xADFF2FFF
#define COLOR_LIGHTRED 0xFF6347FF
#define COLOR_ALLDEPT 0xFF8282AA
#define COLOR_DARKRED 0xAA3333FF
#define COLOR_RED 0xFF0606FF
#define TCOLOR_YELLOW 0xFFFF0000
#define COLOR_TWPINK 0xE75480AA
#define TEAM_HIT_COLOR 0xFFFFFF00
#define COLOR_DBLUE 0x2641FEAA
#define TEAM_CYAN_COLOR 0xFF8282AA
#define COLOR_LIGHTBLUE 0x33CCFFFF
#define COLOR_GREEN 0x33AA33FF
#define COLOR_INDIGO 0x4B00B000
#define COLOR_PINK 0xFF66FF00
#define COLOR_BLACK 0x00000000
#define COLOR_YELLOW 0xFFFF00FF
#define COLOR_PURPLE 0xC2A2DAFF
#define COLOR_ORANGE 0xFF9900FF
#define COLOR_REPORT 0xFFFF91FF
#define COLOR_RADIO 0x8D8DFFFF
#define COLOR_DEPTRADIO 0xFFD700FF
#define COLOR_BLUE 0x2641FEFF
#define COLOR_MEDIC 0xFF8282FF
#define COLOR_NEWBIE 0x7DAEFFFF
#define COLOR_LIME 0x00FF00FF
#define COLOR_NEWS 0x049C7100
#define COLOR_CYAN 0x01FCFFFF
#define COLOR_VIP 0xC93CCEFF

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Barricades by Josh Loaded");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	print("\n----------------------------------");
	print(" Barricades by Josh Unloaded");
	print("----------------------------------\n");
	return 1;
}

//Barricade Enum and Info
#define	MAX_BARRICADES 11 //Ignore 1 //Changing that = fuckign up the serevr, so please do not change that!! You will fuck up the server! DO NOT DO THIS!!!!!!
enum barricadeInfo
{
	barricadeID,
	Float:barricadePosX,
	Float:barricadePosY,
	Float:barricadePosZ,
	Float:barricadeAngle,
	barricadeExist1,
	barricadeExist2,
	barricadeExist3,
	barricadeExist4,
	barricadeExist5,
	barricadeExist6,
	barricadeExist7,
	barricadeExist8,
	barricadeExist9,
	barricadeExist10
}

new BarricadeInfo[MAX_BARRICADES][barricadeInfo];

public OnPlayerConnect(playerid)
{
	return 1;
}

CMD:barricadehelp(playerid, params[])
{
	SendClientMessage(playerid, COLOR_GREEN, "_____________Barricade System by Josh!______________");
	SendClientMessage(playerid, COLOR_YELLOW, "HELP: {FFFFFF}/barricade -Create a new one, or delete an old one");
	SendClientMessage(playerid, COLOR_YELLOW, "CREDITS: {FFFFFF}Nick Derlos- base creator");
	SendClientMessage(playerid, COLOR_YELLOW, "CREDITS: {FFFFFF}Joshman543 editor");
	return 1;
}

CMD:barricade(playerid, params[])
{
	if(IsPlayerInAnyVehicle(playerid))
	{
		SendClientMessage(playerid, COLOR_GREY, "You must be on foot to use this command.");
		return 1;
	}
	ShowPlayerDialog(playerid, 300, DIALOG_STYLE_LIST, "LSPD Baricades", "Deploy new one\nRemove existing one", "Select", "Close");
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == 300 && response)
	{
		switch(listitem)
		{
		    case 0:
		    {
		        ShowPlayerDialog(playerid, 302, DIALOG_STYLE_LIST, "LSPD Baricades", "Deploy Barricade 1\nDeploy Barricade 2\nDeploy Barricade 3\nDeploy Barricade 4\nDeploy Barricade 5\nDeploy Barricade 6\nDeploy Barricade 7\nDeploy Barricade 8\nDeploy Barricade 9\nDeploy Barricade 10\n", "Select", "Close");
		    }
		    case 1:
		    {
		        ShowPlayerDialog(playerid, 301, DIALOG_STYLE_LIST, "LSPD Baricades", "Remove Barricade 1\nRemove Barricade 2\nRemove Barricade 3\nRemove Barricade 4\nRemove Barricade 5\nRemove Barricade 6\nRemove Barricade 7\nRemove Barricade 8\nRemove Barricade 9\nRemove Barricade 10\n", "Select", "Close");
		    }
		}
	}
	else if(dialogid == 301 && response)
	{
		switch(listitem)
		{
		    case 0:
		    {
		        DestroyObject(BarricadeInfo[1][barricadeID]);
		    }
		    case 1:
		    {
		        DestroyObject(BarricadeInfo[2][barricadeID]);
		    }
		    case 2:
		    {
		        DestroyObject(BarricadeInfo[3][barricadeID]);
		    }
		    case 3:
		    {
		        DestroyObject(BarricadeInfo[4][barricadeID]);
		    }
		    case 4:
		    {
		        DestroyObject(BarricadeInfo[5][barricadeID]);
		    }
		    case 5:
		    {
		        DestroyObject(BarricadeInfo[6][barricadeID]);
		    }
		    case 6:
		    {
		        DestroyObject(BarricadeInfo[7][barricadeID]);
		    }
		    case 7:
		    {
		        DestroyObject(BarricadeInfo[8][barricadeID]);
		    }
		    case 8:
		    {
		        DestroyObject(BarricadeInfo[9][barricadeID]);
		    }
		    case 9:
		    {
		        DestroyObject(BarricadeInfo[10][barricadeID]);
		    }
		}
	}
	else if(dialogid == 302 && response)
	{
	    switch(listitem)
	    {
	        case 0:
	        {
	            ShowPlayerDialog(playerid, 321, DIALOG_STYLE_LIST, "LSPD Baricades", "Water Filled Roadblock\nDETOUR sign\n5 Blocks at row\nCone", "Deploy", "Cancel");
	        }
	        case 1:
	        {
	            ShowPlayerDialog(playerid, 322, DIALOG_STYLE_LIST, "LSPD Baricades", "Water Filled Roadblock\nDETOUR sign\n5 Blocks at row\nCone", "Deploy", "Cancel");
	        }
	        case 2:
	        {
	            ShowPlayerDialog(playerid, 323, DIALOG_STYLE_LIST, "LSPD Baricades", "Water Filled Roadblock\nDETOUR sign\n5 Blocks at row\nCone", "Deploy", "Cancel");
	        }
	        case 3:
	        {
	            ShowPlayerDialog(playerid, 324, DIALOG_STYLE_LIST, "LSPD Baricades", "Water Filled Roadblock\nDETOUR sign\n5 Blocks at row\nCone", "Deploy", "Cancel");
	        }
	        case 4:
	        {
	            ShowPlayerDialog(playerid, 325, DIALOG_STYLE_LIST, "LSPD Baricades", "Water Filled Roadblock\nDETOUR sign\n5 Blocks at row\nCone", "Deploy", "Cancel");
	        }
	        case 5:
	        {
	            ShowPlayerDialog(playerid, 326, DIALOG_STYLE_LIST, "LSPD Baricades", "Water Filled Roadblock\nDETOUR sign\n5 Blocks at row\nCone", "Deploy", "Cancel");
	        }
	        case 6:
	        {
	            ShowPlayerDialog(playerid, 327, DIALOG_STYLE_LIST, "LSPD Baricades", "Water Filled Roadblock\nDETOUR sign\n5 Blocks at row\nCone", "Deploy", "Cancel");
	        }
	        case 7:
	        {
	            ShowPlayerDialog(playerid, 328, DIALOG_STYLE_LIST, "LSPD Baricades", "Water Filled Roadblock\nDETOUR sign\n5 Blocks at row\nCone", "Deploy", "Cancel");
	        }
	        case 8:
	        {
	            ShowPlayerDialog(playerid, 329, DIALOG_STYLE_LIST, "LSPD Baricades", "Water Filled Roadblock\nDETOUR sign\n5 Blocks at row\nCone", "Deploy", "Cancel");
	        }
	        case 9:
	        {
	            ShowPlayerDialog(playerid, 330, DIALOG_STYLE_LIST, "LSPD Baricades", "Water Filled Roadblock\nDETOUR sign\n5 Blocks at row\nCone", "Deploy", "Cancel");
	        }
	    }
	}
	else if(dialogid == 321 && response)
	{
	    switch(listitem)
	    {
	        case 0:
	        {
	            if(BarricadeInfo[1][barricadeExist1] == 0)
	            {
		            new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[1][barricadeID] = CreateObject(1434, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[1][barricadeExist1] = 1;
				}
				else if(BarricadeInfo[1][barricadeExist1] == 1)
				{
				    DestroyObject(BarricadeInfo[1][barricadeID]);
				    new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[1][barricadeID] = CreateObject(1434, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[1][barricadeExist1] = 1;
				}
	        }
	        case 1:
	        {
	            if(BarricadeInfo[1][barricadeExist1] == 0)
	            {
		            new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[1][barricadeID] = CreateObject(1425, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[1][barricadeExist1] = 1;
				}
				else if(BarricadeInfo[1][barricadeExist1] == 1)
				{
				    DestroyObject(BarricadeInfo[1][barricadeID]);
				    new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[1][barricadeID] = CreateObject(1425, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[1][barricadeExist1] = 1;
				}
			}
	        case 2:
			{
			    if(BarricadeInfo[1][barricadeExist1] == 0)
	            {
		            new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[1][barricadeID] = CreateObject(981, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[1][barricadeExist1] = 1;
				}
				else if(BarricadeInfo[1][barricadeExist1] == 1)
				{
				    DestroyObject(BarricadeInfo[1][barricadeID]);
				    new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[1][barricadeID] = CreateObject(981, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[1][barricadeExist1] = 1;
				}
			}
			case 3:
	        {
	            if(BarricadeInfo[1][barricadeExist1] == 0)
	            {
		            new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[1][barricadeID] = CreateObject(1238, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[1][barricadeExist1] = 1;
				}
				else if(BarricadeInfo[1][barricadeExist1] == 1)
				{
				    DestroyObject(BarricadeInfo[1][barricadeID]);
				    new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[1][barricadeID] = CreateObject(1238, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[1][barricadeExist1] = 1;
				}
			}
	    }
	}
	else if(dialogid == 322 && response)
	{
	    switch(listitem)
	    {
	        case 0:
	        {
	            if(BarricadeInfo[2][barricadeExist2] == 0)
	            {
		            new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[2][barricadeID] = CreateObject(1434, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[2][barricadeExist2] = 1;
				}
				else if(BarricadeInfo[2][barricadeExist2] == 1)
				{
				    DestroyObject(BarricadeInfo[2][barricadeID]);
				    new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[2][barricadeID] = CreateObject(1434, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[2][barricadeExist2] = 1;
				}
	        }
	        case 1:
	        {
	            if(BarricadeInfo[2][barricadeExist2] == 0)
	            {
		            new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[2][barricadeID] = CreateObject(1425, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[2][barricadeExist2] = 1;
				}
				else if(BarricadeInfo[2][barricadeExist2] == 1)
				{
				    DestroyObject(BarricadeInfo[2][barricadeID]);
				    new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[2][barricadeID] = CreateObject(1425, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[2][barricadeExist2] = 1;
				}
			}
	        case 2:
			{
			    if(BarricadeInfo[2][barricadeExist2] == 0)
	            {
		            new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[2][barricadeID] = CreateObject(981, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[2][barricadeExist2] = 1;
				}
				else if(BarricadeInfo[2][barricadeExist2] == 1)
				{
				    DestroyObject(BarricadeInfo[1][barricadeID]);
				    new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[2][barricadeID] = CreateObject(981, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[2][barricadeExist2] = 1;
				}
			}
			case 3:
	        {
	            if(BarricadeInfo[2][barricadeExist2] == 0)
	            {
		            new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[2][barricadeID] = CreateObject(1238, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[2][barricadeExist2] = 1;
				}
				else if(BarricadeInfo[2][barricadeExist2] == 1)
				{
				    DestroyObject(BarricadeInfo[2][barricadeID]);
				    new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[2][barricadeID] = CreateObject(1238, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[2][barricadeExist2] = 1;
				}
			}
	    }
	}
	else if(dialogid == 323 && response)
	{
	    switch(listitem)
	    {
	        case 0:
	        {
	            if(BarricadeInfo[3][barricadeExist3] == 0)
	            {
		            new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[3][barricadeID] = CreateObject(1434, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[3][barricadeExist3] = 1;
				}
				else if(BarricadeInfo[3][barricadeExist3] == 1)
				{
				    DestroyObject(BarricadeInfo[3][barricadeID]);
				    new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[3][barricadeID] = CreateObject(1434, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[3][barricadeExist3] = 1;
				}
	        }
	        case 1:
	        {
	            if(BarricadeInfo[3][barricadeExist3] == 0)
	            {
		            new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[3][barricadeID] = CreateObject(1425, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[3][barricadeExist3] = 1;
				}
				else if(BarricadeInfo[3][barricadeExist3] == 1)
				{
				    DestroyObject(BarricadeInfo[3][barricadeID]);
				    new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[3][barricadeID] = CreateObject(1425, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[3][barricadeExist3] = 1;
				}
			}
	        case 2:
			{
			    if(BarricadeInfo[3][barricadeExist3] == 0)
	            {
		            new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[3][barricadeID] = CreateObject(981, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[3][barricadeExist3] = 1;
				}
				else if(BarricadeInfo[3][barricadeExist3] == 1)
				{
				    DestroyObject(BarricadeInfo[1][barricadeID]);
				    new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[3][barricadeID] = CreateObject(981, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[3][barricadeExist3] = 1;
				}
			}
			case 3:
	        {
	            if(BarricadeInfo[3][barricadeExist3] == 0)
	            {
		            new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[3][barricadeID] = CreateObject(1238, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[3][barricadeExist3] = 1;
				}
				else if(BarricadeInfo[3][barricadeExist3] == 1)
				{
				    DestroyObject(BarricadeInfo[3][barricadeID]);
				    new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[3][barricadeID] = CreateObject(1238, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[3][barricadeExist3] = 1;
				}
			}
	    }
	}
	else if(dialogid == 324 && response)
	{
	    switch(listitem)
	    {
	        case 0:
	        {
	            if(BarricadeInfo[4][barricadeExist4] == 0)
	            {
		            new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[4][barricadeID] = CreateObject(1434, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[4][barricadeExist4] = 1;
				}
				else if(BarricadeInfo[4][barricadeExist4] == 1)
				{
				    DestroyObject(BarricadeInfo[4][barricadeID]);
				    new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[4][barricadeID] = CreateObject(1434, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[4][barricadeExist4] = 1;
				}
	        }
	        case 1:
	        {
	            if(BarricadeInfo[4][barricadeExist4] == 0)
	            {
		            new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[4][barricadeID] = CreateObject(1425, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[4][barricadeExist4] = 1;
				}
				else if(BarricadeInfo[4][barricadeExist4] == 1)
				{
				    DestroyObject(BarricadeInfo[4][barricadeID]);
				    new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[4][barricadeID] = CreateObject(1425, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[4][barricadeExist4] = 1;
				}
			}
	        case 2:
			{
			    if(BarricadeInfo[4][barricadeExist4] == 0)
	            {
		            new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[4][barricadeID] = CreateObject(981, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[4][barricadeExist4] = 1;
				}
				else if(BarricadeInfo[4][barricadeExist4] == 1)
				{
				    DestroyObject(BarricadeInfo[1][barricadeID]);
				    new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[4][barricadeID] = CreateObject(981, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[4][barricadeExist4] = 1;
				}
			}
			case 3:
	        {
	            if(BarricadeInfo[4][barricadeExist4] == 0)
	            {
		            new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[4][barricadeID] = CreateObject(1238, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[4][barricadeExist4] = 1;
				}
				else if(BarricadeInfo[4][barricadeExist4] == 1)
				{
				    DestroyObject(BarricadeInfo[4][barricadeID]);
				    new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[4][barricadeID] = CreateObject(1238, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[4][barricadeExist4] = 1;
				}
			}
	    }
	}
	else if(dialogid == 325 && response)
	{
	    switch(listitem)
	    {
	        case 0:
	        {
	            if(BarricadeInfo[5][barricadeExist5] == 0)
	            {
		            new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[5][barricadeID] = CreateObject(1434, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[5][barricadeExist5] = 1;
				}
				else if(BarricadeInfo[5][barricadeExist5] == 1)
				{
				    DestroyObject(BarricadeInfo[5][barricadeID]);
				    new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[5][barricadeID] = CreateObject(1434, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[5][barricadeExist5] = 1;
				}
	        }
	        case 1:
	        {
	            if(BarricadeInfo[5][barricadeExist5] == 0)
	            {
		            new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[5][barricadeID] = CreateObject(1425, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[5][barricadeExist5] = 1;
				}
				else if(BarricadeInfo[5][barricadeExist5] == 1)
				{
				    DestroyObject(BarricadeInfo[5][barricadeID]);
				    new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[5][barricadeID] = CreateObject(1425, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[5][barricadeExist5] = 1;
				}
			}
	        case 2:
			{
			    if(BarricadeInfo[5][barricadeExist5] == 0)
	            {
		            new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[5][barricadeID] = CreateObject(981, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[5][barricadeExist5] = 1;
				}
				else if(BarricadeInfo[5][barricadeExist5] == 1)
				{
				    DestroyObject(BarricadeInfo[5][barricadeID]);
				    new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[5][barricadeID] = CreateObject(981, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[5][barricadeExist5] = 1;
				}
			}
			case 3:
	        {
	            if(BarricadeInfo[5][barricadeExist5] == 0)
	            {
		            new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[5][barricadeID] = CreateObject(1238, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[5][barricadeExist5] = 1;
				}
				else if(BarricadeInfo[5][barricadeExist5] == 1)
				{
				    DestroyObject(BarricadeInfo[5][barricadeID]);
				    new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[5][barricadeID] = CreateObject(1238, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[5][barricadeExist5] = 1;
				}
			}
	    }
	}
	else if(dialogid == 326 && response)
	{
	    switch(listitem)
	    {
	        case 0:
	        {
	            if(BarricadeInfo[6][barricadeExist6] == 0)
	            {
		            new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[6][barricadeID] = CreateObject(1434, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[6][barricadeExist6] = 1;
				}
				else if(BarricadeInfo[6][barricadeExist6] == 1)
				{
				    DestroyObject(BarricadeInfo[6][barricadeID]);
				    new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[6][barricadeID] = CreateObject(1434, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[6][barricadeExist6] = 1;
				}
	        }
	        case 1:
	        {
	            if(BarricadeInfo[6][barricadeExist6] == 0)
	            {
		            new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[6][barricadeID] = CreateObject(1425, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[6][barricadeExist6] = 1;
				}
				else if(BarricadeInfo[6][barricadeExist6] == 1)
				{
				    DestroyObject(BarricadeInfo[6][barricadeID]);
				    new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[6][barricadeID] = CreateObject(1425, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[6][barricadeExist6] = 1;
				}
			}
	        case 2:
			{
			    if(BarricadeInfo[6][barricadeExist6] == 0)
	            {
		            new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[6][barricadeID] = CreateObject(981, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[6][barricadeExist6] = 1;
				}
				else if(BarricadeInfo[6][barricadeExist6] == 1)
				{
				    DestroyObject(BarricadeInfo[6][barricadeID]);
				    new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[6][barricadeID] = CreateObject(981, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[6][barricadeExist6] = 1;
				}
			}
			case 3:
	        {
	            if(BarricadeInfo[6][barricadeExist6] == 0)
	            {
		            new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[6][barricadeID] = CreateObject(1238, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[6][barricadeExist6] = 1;
				}
				else if(BarricadeInfo[6][barricadeExist6] == 1)
				{
				    DestroyObject(BarricadeInfo[6][barricadeID]);
				    new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[6][barricadeID] = CreateObject(1238, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[6][barricadeExist6] = 1;
				}
			}
	    }
	}
	else if(dialogid == 327 && response)
	{
	    switch(listitem)
	    {
	        case 0:
	        {
	            if(BarricadeInfo[7][barricadeExist7] == 0)
	            {
		            new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[7][barricadeID] = CreateObject(1434, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[7][barricadeExist7] = 1;
				}
				else if(BarricadeInfo[7][barricadeExist7] == 1)
				{
				    DestroyObject(BarricadeInfo[7][barricadeID]);
				    new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[7][barricadeID] = CreateObject(1434, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[7][barricadeExist7] = 1;
				}
	        }
	        case 1:
	        {
	            if(BarricadeInfo[7][barricadeExist7] == 0)
	            {
		            new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[7][barricadeID] = CreateObject(1425, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[7][barricadeExist7] = 1;
				}
				else if(BarricadeInfo[7][barricadeExist7] == 1)
				{
				    DestroyObject(BarricadeInfo[7][barricadeID]);
				    new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[7][barricadeID] = CreateObject(1425, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[7][barricadeExist7] = 1;
				}
			}
	        case 2:
			{
			    if(BarricadeInfo[7][barricadeExist7] == 0)
	            {
		            new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[7][barricadeID] = CreateObject(981, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[7][barricadeExist7] = 1;
				}
				else if(BarricadeInfo[7][barricadeExist7] == 1)
				{
				    DestroyObject(BarricadeInfo[7][barricadeID]);
				    new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[7][barricadeID] = CreateObject(981, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[7][barricadeExist7] = 1;
				}
			}
			case 3:
	        {
	            if(BarricadeInfo[7][barricadeExist7] == 0)
	            {
		            new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[7][barricadeID] = CreateObject(1238, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[7][barricadeExist7] = 1;
				}
				else if(BarricadeInfo[7][barricadeExist7] == 1)
				{
				    DestroyObject(BarricadeInfo[7][barricadeID]);
				    new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[7][barricadeID] = CreateObject(1238, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[7][barricadeExist7] = 1;
				}
			}
	    }
	}
	else if(dialogid == 328 && response)
	{
	    switch(listitem)
	    {
	        case 0:
	        {
	            if(BarricadeInfo[8][barricadeExist8] == 0)
	            {
		            new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[8][barricadeID] = CreateObject(1434, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[8][barricadeExist8] = 1;
				}
				else if(BarricadeInfo[8][barricadeExist8] == 1)
				{
				    DestroyObject(BarricadeInfo[8][barricadeID]);
				    new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[8][barricadeID] = CreateObject(1434, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[8][barricadeExist8] = 1;
				}
	        }
	        case 1:
	        {
	            if(BarricadeInfo[8][barricadeExist8] == 0)
	            {
		            new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[8][barricadeID] = CreateObject(1425, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[8][barricadeExist8] = 1;
				}
				else if(BarricadeInfo[8][barricadeExist8] == 1)
				{
				    DestroyObject(BarricadeInfo[8][barricadeID]);
				    new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[8][barricadeID] = CreateObject(1425, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[8][barricadeExist8] = 1;
				}
			}
	        case 2:
			{
			    if(BarricadeInfo[8][barricadeExist8] == 0)
	            {
		            new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[8][barricadeID] = CreateObject(981, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[8][barricadeExist8] = 1;
				}
				else if(BarricadeInfo[8][barricadeExist8] == 1)
				{
				    DestroyObject(BarricadeInfo[8][barricadeID]);
				    new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[8][barricadeID] = CreateObject(981, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[8][barricadeExist8] = 1;
				}
			}
			case 3:
	        {
	            if(BarricadeInfo[8][barricadeExist8] == 0)
	            {
		            new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[8][barricadeID] = CreateObject(1238, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[8][barricadeExist8] = 1;
				}
				else if(BarricadeInfo[8][barricadeExist8] == 1)
				{
				    DestroyObject(BarricadeInfo[8][barricadeID]);
				    new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[8][barricadeID] = CreateObject(1238, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[8][barricadeExist8] = 1;
				}
			}
	    }
	}
	else if(dialogid == 329 && response)
	{
	    switch(listitem)
	    {
	        case 0:
	        {
	            if(BarricadeInfo[9][barricadeExist9] == 0)
	            {
		            new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[9][barricadeID] = CreateObject(1434, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[9][barricadeExist9] = 1;
				}
				else if(BarricadeInfo[9][barricadeExist9] == 1)
				{
				    DestroyObject(BarricadeInfo[9][barricadeID]);
				    new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[9][barricadeID] = CreateObject(1434, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[9][barricadeExist9] = 1;
				}
	        }
	        case 1:
	        {
	            if(BarricadeInfo[9][barricadeExist9] == 0)
	            {
		            new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[9][barricadeID] = CreateObject(1425, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[9][barricadeExist9] = 1;
				}
				else if(BarricadeInfo[9][barricadeExist9] == 1)
				{
				    DestroyObject(BarricadeInfo[9][barricadeID]);
				    new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[9][barricadeID] = CreateObject(1425, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[9][barricadeExist9] = 1;
				}
			}
	        case 2:
			{
			    if(BarricadeInfo[9][barricadeExist9] == 0)
	            {
		            new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[9][barricadeID] = CreateObject(981, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[9][barricadeExist9] = 1;
				}
				else if(BarricadeInfo[9][barricadeExist9] == 1)
				{
				    DestroyObject(BarricadeInfo[9][barricadeID]);
				    new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[9][barricadeID] = CreateObject(981, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[9][barricadeExist9] = 1;
				}
			}
			case 3:
	        {
	            if(BarricadeInfo[9][barricadeExist9] == 0)
	            {
		            new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[9][barricadeID] = CreateObject(1238, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[9][barricadeExist9] = 1;
				}
				else if(BarricadeInfo[9][barricadeExist9] == 1)
				{
				    DestroyObject(BarricadeInfo[9][barricadeID]);
				    new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[9][barricadeID] = CreateObject(1238, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[9][barricadeExist9] = 1;
				}
			}
	    }
	}
	else if(dialogid == 330 && response)
	{
	    switch(listitem)
	    {
	        case 0:
	        {
	            if(BarricadeInfo[10][barricadeExist10] == 0)
	            {
		            new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[10][barricadeID] = CreateObject(1434, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[10][barricadeExist10] = 1;
				}
				else if(BarricadeInfo[10][barricadeExist10] == 1)
				{
				    DestroyObject(BarricadeInfo[10][barricadeID]);
				    new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[10][barricadeID] = CreateObject(1434, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[10][barricadeExist10] = 1;
				}
	        }
	        case 1:
	        {
	            if(BarricadeInfo[10][barricadeExist10] == 0)
	            {
		            new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[10][barricadeID] = CreateObject(1425, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[10][barricadeExist10] = 1;
				}
				else if(BarricadeInfo[10][barricadeExist10] == 1)
				{
				    DestroyObject(BarricadeInfo[10][barricadeID]);
				    new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[10][barricadeID] = CreateObject(1425, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[10][barricadeExist10] = 1;
				}
			}
	        case 2:
			{
			    if(BarricadeInfo[10][barricadeExist10] == 0)
	            {
		            new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[10][barricadeID] = CreateObject(981, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[10][barricadeExist10] = 1;
				}
				else if(BarricadeInfo[10][barricadeExist10] == 1)
				{
				    DestroyObject(BarricadeInfo[10][barricadeID]);
				    new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[10][barricadeID] = CreateObject(981, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[10][barricadeExist10] = 1;
				}
			}
			case 3:
	        {
	            if(BarricadeInfo[10][barricadeExist10] == 0)
	            {
		            new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[10][barricadeID] = CreateObject(1238, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[10][barricadeExist10] = 1;
				}
				else if(BarricadeInfo[10][barricadeExist10] == 1)
				{
				    DestroyObject(BarricadeInfo[10][barricadeID]);
				    new Float:PosX, Float:PosY, Float:PosZ, Float:Angle;
					GetPlayerPos(playerid, PosX, PosY, PosZ);
					GetPlayerFacingAngle(playerid, Angle);
					BarricadeInfo[10][barricadeID] = CreateObject(1238, PosX, PosY, PosZ - 0.52, 0.0, 0.0, Angle);
					BarricadeInfo[10][barricadeExist10] = 1;
				}
			}
	    }
	}
	return 1;
}

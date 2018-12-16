// MPM - Model Preview Menus system.(0.3x++)

// - Creator: Pasha97 (2013-...)
// - Thanks to Doefler and Kalcor

//Include version: 1.0


/*Available functions

LoadMPMenu(f_name[])
HideMPMenu(playerid)
ShowMPMenu(playerid, ListID, header_text[], titles_array[][],titles_amount = 0, dialogBGcolor = 0x34c924BB, previewBGcolor = 0xBEF57499 , tdSelectionColor = 0xCCFF00AA, tdTitleColor = 0xcd5700AA)
ShowDynamicMPMenu(playerid, items_array[], item_amount, header_text[], extraid, Float:Xrot = 0.0, Float:Yrot = 0.0, Float:Zrot = 0.0, Float:mZoom = 1.0, titles_array[][], dialogBGcolor = 0x34c924BB, previewBGcolor = 0xBEF57499, tdSelectionColor = 0xCCFF00AA,tdTitleColor = 0xcd5700AA)

//NEW
ShowColorMPMenu(playerid, items_array[], item_amount, header_text[], extraid, titles_array[][], dialogBGcolor = 0x34c924BB, previewBGcolor = 0xBEF57499, tdSelectionColor = 0xCCFF00AA,tdTitleColor = 0xcd5700AA)
//This function shows colorful selection, not with models.In this this function items_array[] must be an array of diffrent colors for each item.
*/

// Callbacks
forward OnMPMenuResponse(playerid, response, listid, modelid, listitem);
forward OnDynamicMPMenuResponse(playerid, response, extraid, modelid, listitem);

// Common settings
new MPM_TITLE_ALIGNMENT =				2 /*Alignment of titles (1-left 2-centered 3-right)*/;
new MPM_TITLE_POSITION =				1 /*Position of titles (1-top of the item 2-bottom of the item)*/;

#define MPM_NEXT_BUTTON   "Next"            //Text of 'Next' Button
#define MPM_BACK_BUTTON   "Back"            //Text of 'Back' Button
#define MPM_EXIT_BUTTON   "Exit"          //Text of 'Exit' Button

// Settings for static lists
#define MPM_TOTAL_ITEMS         	1000 // Max amount of items from all lists
#define MPM_TOTAL_LISTS			90 // Max amount of lists
#define MPM_TOTAL_ROT_ZOOM		100 // Max amount of items using extra information like zoom or rotations

// Settings for dynamic (per player) lists
#define MPM_DYNAMIC_MAX_ITEMS		1000

//All parts of script below are not for usual users!

#define MPM_INVALID_LISTID		MPM_TOTAL_LISTS
#define MPM_DYNAMIC_LISTID		(MPM_TOTAL_LISTS+1)
#define MPM_COLOR_LISTID		(MPM_TOTAL_LISTS+2)

new DynamicList[MAX_PLAYERS][MPM_DYNAMIC_MAX_ITEMS];
new ColorList[MAX_PLAYERS][MPM_DYNAMIC_MAX_ITEMS];

new MPM_previewBGcolor[MAX_PLAYERS][MPM_DYNAMIC_MAX_ITEMS];


new NO_TITLES[][]=
{
"                  ",
"                  "
};

#define MPM_SELECTION_ITEMS 		21
#define MPM_ITEMS_PER_LINE  		7
#define MPM_DIALOG_BASE_X   	75.0
#define MPM_DIALOG_BASE_Y   	120.0//130
#define MPM_DIALOG_WIDTH    	550.0
#define MPM_DIALOG_HEIGHT   	180.0
#define MPM_SPRITE_DIM_X    	60.0
#define MPM_SPRITE_DIM_Y    	70.0

new PlayerText:CurrentPageTextDraw[MAX_PLAYERS];
new PlayerText:HeaderTextDraw[MAX_PLAYERS];
new PlayerText:BackgroundTextDraw[MAX_PLAYERS];
new PlayerText:NextButtonTextDraw[MAX_PLAYERS];
new PlayerText:PrevButtonTextDraw[MAX_PLAYERS];
new PlayerText:CancelButtonTextDraw[MAX_PLAYERS];
new PlayerText:ItemsTD[MAX_PLAYERS][MPM_SELECTION_ITEMS];
new PreviewItemModel[MAX_PLAYERS][MPM_SELECTION_ITEMS];
new ItemID[MAX_PLAYERS][MPM_SELECTION_ITEMS];
new PlayerText:Title[MAX_PLAYERS][101];
new globalItemAt[MAX_PLAYERS];

#define MPM_LIST_START			0
#define MPM_LIST_END				1
new All_Lists[MPM_TOTAL_LISTS][2]; // list information start/end index

#define MPM_ITEM_MODEL			0
#define MPM_ITEM_ROT_ZOOM_ID 	1
new All_Items[MPM_TOTAL_ITEMS][2];

new Float:RotZoomInfo[MPM_TOTAL_ROT_ZOOM][4]; // Array for saving rotation and zoom info
new ItemAmount = 0; // Amount of items used
new ListAmount = 0; // Amount of lists used
new RotZoomInfoAmount = 0; // Amount of Rotation/Zoom informations used
#pragma tabsize 0
//------------------------------------------------

stock MPM_GetPagesAmount(ListID)
{
	new ItemAmount_m = MPM_GetAmountOfListItems(ListID);
	if((ItemAmount_m >= MPM_SELECTION_ITEMS) && (ItemAmount_m % MPM_SELECTION_ITEMS) == 0)
	{
		return (ItemAmount_m / MPM_SELECTION_ITEMS);
	}
	else return (ItemAmount_m / MPM_SELECTION_ITEMS) + 1;
}

//------------------------------------------------

stock MPM_GetPagesAmountEx(playerid)
{
	new ItemAmount_m = MPM_GetAmountOfListItemsEx(playerid);
	if((ItemAmount_m >= MPM_SELECTION_ITEMS) && (ItemAmount_m % MPM_SELECTION_ITEMS) == 0)
	{
		return (ItemAmount_m / MPM_SELECTION_ITEMS);
	}
	else return (ItemAmount_m / MPM_SELECTION_ITEMS) + 1;
}

//------------------------------------------------

stock MPM_GetAmountOfListItems(ListID)
{
	return (All_Lists[ListID][MPM_LIST_END] - All_Lists[ListID][MPM_LIST_START])+1;
}

//------------------------------------------------

stock MPM_GetAmountOfListItemsEx(playerid)
{
	return GetPVarInt(playerid, "MPM_DYNAMIC_item_amount");
}
stock MPM_GetAmountOfListItemsEx2(playerid)
{
	return GetPVarInt(playerid, "MPM_COLOR_item_amount");
}

//------------------------------------------------

stock MPM_GetPlayerCurrentListID(playerid)
{
	if(GetPVarInt(playerid, "MPM_list_active") == 1) return GetPVarInt(playerid, "MPM_list_id");
	else return MPM_INVALID_LISTID;
}

//------------------------------------------------

stock PlayerText:MPM_CreateCurrentPageTextDraw(playerid, Float:Xpos, Float:Ypos)
{
	new PlayerText:txtInit;
   	txtInit = CreatePlayerTextDraw(playerid, Xpos, Ypos, "0/0");
   	PlayerTextDrawUseBox(playerid, txtInit, 0);
	PlayerTextDrawLetterSize(playerid, txtInit, 0.4, 1.1);
	PlayerTextDrawFont(playerid, txtInit, 1);
	PlayerTextDrawSetShadow(playerid, txtInit, 0);
    PlayerTextDrawSetOutline(playerid, txtInit, 1);
    PlayerTextDrawColor(playerid, txtInit, 0xACCBF1FF);
    PlayerTextDrawShow(playerid, txtInit);
    return txtInit;
}

//------------------------------------------------
// Creates a button textdraw and returns the textdraw ID.

stock PlayerText:MPM_CreatePlayerDialogButton(playerid, Float:Xpos, Float:Ypos, Float:Width, Float:Height, button_text[])
{
 	new PlayerText:txtInit;
   	txtInit = CreatePlayerTextDraw(playerid, Xpos, Ypos, button_text);
   	PlayerTextDrawUseBox(playerid, txtInit, 1);
   	PlayerTextDrawBoxColor(playerid, txtInit, 0x000000FF);
   	PlayerTextDrawBackgroundColor(playerid, txtInit, 0x000000FF);
	PlayerTextDrawLetterSize(playerid, txtInit, 0.4, 1.1);
	PlayerTextDrawFont(playerid, txtInit, 1);
	PlayerTextDrawSetShadow(playerid, txtInit, 0); // no shadow
    PlayerTextDrawSetOutline(playerid, txtInit, 0);
    PlayerTextDrawColor(playerid, txtInit, 0x4A5A6BFF);
    PlayerTextDrawSetSelectable(playerid, txtInit, 1);
    PlayerTextDrawAlignment(playerid, txtInit, 2);
    PlayerTextDrawTextSize(playerid, txtInit, Height, Width); // The width and height are reversed for centering.. something the game does <g>
    PlayerTextDrawShow(playerid, txtInit);
    return txtInit;
}
 
//------------------------------------------------

stock PlayerText:MPM_CreatePlayerHeaderTextDraw(playerid, Float:Xpos, Float:Ypos, header_text[])
{
	new PlayerText:txtInit;
   	txtInit = CreatePlayerTextDraw(playerid, Xpos, Ypos, header_text);
   	PlayerTextDrawUseBox(playerid, txtInit, 0);
	PlayerTextDrawLetterSize(playerid, txtInit, 1.25, 3.0);
	PlayerTextDrawFont(playerid, txtInit, 1);
	PlayerTextDrawSetShadow(playerid, txtInit, 0);
    PlayerTextDrawSetOutline(playerid, txtInit, 1);
    PlayerTextDrawColor(playerid, txtInit, 0xACCBF1FF);
    PlayerTextDrawShow(playerid, txtInit);
    return txtInit;
}

//------------------------------------------------

stock PlayerText:MPM_CreatePlayerBGTextDraw(playerid, Float:Xpos, Float:Ypos, Float:Width, Float:Height, bgcolor)
{
	new PlayerText:txtBackground = CreatePlayerTextDraw(playerid, Xpos, Ypos,"                                            ~n~"); // enough space for everyone
    PlayerTextDrawUseBox(playerid, txtBackground, 1);
    PlayerTextDrawBoxColor(playerid, txtBackground, bgcolor);
	PlayerTextDrawLetterSize(playerid, txtBackground, 5.0, 5.0);
	PlayerTextDrawFont(playerid, txtBackground, 0);
	PlayerTextDrawSetShadow(playerid, txtBackground, 0);
    PlayerTextDrawSetOutline(playerid, txtBackground, 0);
    PlayerTextDrawColor(playerid, txtBackground,0x000000FF);
    PlayerTextDrawTextSize(playerid, txtBackground, Width, Height);
   	PlayerTextDrawBackgroundColor(playerid, txtBackground, bgcolor);
    PlayerTextDrawShow(playerid, txtBackground);
    return txtBackground;
}

//------------------------------------------------
// Creates a model preview sprite

stock PlayerText:MPM_CreateMPTextDraw(playerid, modelindex, Float:Xpos, Float:Ypos, Float:Xrot, Float:Yrot, Float:Zrot, Float:mZoom, Float:width, Float:height, bgcolor)
{
    new PlayerText:txtPlayerSprite = CreatePlayerTextDraw(playerid, Xpos, Ypos, ""); // it has to be set with SetText later
    PlayerTextDrawFont(playerid, txtPlayerSprite, TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawColor(playerid, txtPlayerSprite, 0xFFFFFFFF);
    PlayerTextDrawBackgroundColor(playerid, txtPlayerSprite, bgcolor);
    PlayerTextDrawTextSize(playerid, txtPlayerSprite, width, height); // Text size is the Width:Height
    PlayerTextDrawSetPreviewModel(playerid, txtPlayerSprite, modelindex);
    PlayerTextDrawSetPreviewRot(playerid,txtPlayerSprite, Xrot, Yrot, Zrot, mZoom);
    PlayerTextDrawSetSelectable(playerid, txtPlayerSprite, 1);
    PlayerTextDrawShow(playerid,txtPlayerSprite);
    return txtPlayerSprite;
}
stock PlayerText:MPM_CreateTitle(playerid, text[], Float:Xpos, Float:Ypos,tdTitleColor)
{
	new Float:XposF,Float:YposF;
	if(MPM_TITLE_POSITION == 1) YposF=Ypos;
	if(MPM_TITLE_POSITION == 2) YposF=Ypos+50;
	if(MPM_TITLE_ALIGNMENT == 1) XposF=Xpos;
	if(MPM_TITLE_ALIGNMENT == 2) XposF=Xpos+28;
	if(MPM_TITLE_ALIGNMENT == 3) XposF=Xpos+58;
	
    	new PlayerText:txtPlayerSprite = CreatePlayerTextDraw(playerid, XposF, YposF, text); // it has to be set with SetText later
    	PlayerTextDrawFont(playerid, txtPlayerSprite, 1);
	PlayerTextDrawAlignment(playerid, txtPlayerSprite, MPM_TITLE_ALIGNMENT);
	if(MPM_TITLE_ALIGNMENT == 2) PlayerTextDrawTextSize(playerid, txtPlayerSprite, 50, 60);
	PlayerTextDrawLetterSize(playerid, txtPlayerSprite, 0.35, 1.1);
   	PlayerTextDrawColor(playerid, txtPlayerSprite, tdTitleColor);
	PlayerTextDrawSetShadow(playerid,txtPlayerSprite,0);
	PlayerTextDrawSetOutline(playerid,txtPlayerSprite,1);
	PlayerTextDrawBackgroundColor(playerid,txtPlayerSprite ,0x000000FF);
    	PlayerTextDrawShow(playerid,txtPlayerSprite);
    	return txtPlayerSprite;
}
//------------------------------------------------

stock MPM_DestroyPlayerMPs(playerid)
{
	new x=0;
	while(x != MPM_SELECTION_ITEMS) {
	    if(ItemsTD[playerid][x] != PlayerText:INVALID_TEXT_DRAW) {
			PlayerTextDrawDestroy(playerid, ItemsTD[playerid][x]);
			ItemsTD[playerid][x] = PlayerText:INVALID_TEXT_DRAW;
		}
		x++;
	}
		for(new i=0;i<100;i++)
		{
			if(Title[playerid][i] != PlayerText:INVALID_TEXT_DRAW)
			{
			PlayerTextDrawDestroy(playerid, Title[playerid][i]);
			Title[playerid][i] = PlayerText:INVALID_TEXT_DRAW;
			}
		}
}

//------------------------------------------------

stock MPM_ShowPlayerMPs(playerid)
{
//print("showplayermps");
	new bgcolor = GetPVarInt(playerid, "MPM_previewBGcolor");
    new x=0;
	new Float:BaseX = MPM_DIALOG_BASE_X;
	new Float:BaseY = MPM_DIALOG_BASE_Y - (MPM_SPRITE_DIM_Y * 0.33); // down a bit
	new linetracker = 0;
	new itemid = 0;
	
	new MPM_listID = MPM_GetPlayerCurrentListID(playerid);
	if(MPM_listID == MPM_DYNAMIC_LISTID)
	{
//print("dynamic");
		new itemat = (GetPVarInt(playerid, "MPM_list_page") * MPM_SELECTION_ITEMS);
		new Float:rotzoom[4];
		rotzoom[0] = GetPVarFloat(playerid, "MPM_DYNAMIC_Xrot");
		rotzoom[1] = GetPVarFloat(playerid, "MPM_DYNAMIC_Yrot");
		rotzoom[2] = GetPVarFloat(playerid, "MPM_DYNAMIC_Zrot");
		rotzoom[3] = GetPVarFloat(playerid, "MPM_DYNAMIC_Zoom");
		new itemamount = MPM_GetAmountOfListItemsEx(playerid);
		// Destroy any previous ones created
		MPM_DestroyPlayerMPs(playerid);

		while(x != MPM_SELECTION_ITEMS && itemat < (itemamount)) {
			if(linetracker == 0) {
				BaseX = MPM_DIALOG_BASE_X + 25.0; // in a bit from the box
				BaseY += MPM_SPRITE_DIM_Y + 1.0; // move on the Y for the next line
			}
			ItemsTD[playerid][x] = MPM_CreateMPTextDraw(playerid, DynamicList[playerid][itemat], BaseX, BaseY, rotzoom[0], rotzoom[1], rotzoom[2], rotzoom[3], MPM_SPRITE_DIM_X, MPM_SPRITE_DIM_Y, bgcolor);
			PreviewItemModel[playerid][x] = DynamicList[playerid][itemat];
			ItemID[playerid][x] = itemid;
			BaseX += MPM_SPRITE_DIM_X + 1.0; // move on the X for the next sprite
			linetracker++;
			itemid++;
			if(linetracker == MPM_ITEMS_PER_LINE) linetracker = 0;
			itemat++;
			x++;
		}
	}
	if(MPM_listID == MPM_COLOR_LISTID)
	{
//print("color");
		new itemat = (GetPVarInt(playerid, "MPM_list_page") * MPM_SELECTION_ITEMS);
		new itemamount = MPM_GetAmountOfListItemsEx2(playerid);
		// Destroy any previous ones created
		MPM_DestroyPlayerMPs(playerid);
//printf("x=%d != 21, itemat=%d < itemamount=%d",x,itemat,itemamount);
		while(x != MPM_SELECTION_ITEMS && itemat < (itemamount)) {
			if(linetracker == 0) {
				BaseX = MPM_DIALOG_BASE_X + 25.0; // in a bit from the box
				BaseY += MPM_SPRITE_DIM_Y + 1.0; // move on the Y for the next line
			}
//printf("creating mp number %d, and something is %d",x,itemat);
			ItemsTD[playerid][x] = MPM_CreateMPTextDraw(playerid, 19300, BaseX, BaseY, 0, 0, 0, 0, MPM_SPRITE_DIM_X, MPM_SPRITE_DIM_Y, MPM_previewBGcolor[playerid][x]);
			PreviewItemModel[playerid][x] = ColorList[playerid][itemat];
			ItemID[playerid][x] = itemid;
			BaseX += MPM_SPRITE_DIM_X + 1.0; // move on the X for the next sprite
			linetracker++;
			itemid++;
			if(linetracker == MPM_ITEMS_PER_LINE) linetracker = 0;
			itemat++;
			x++;
		}
	}
	if(MPM_listID != MPM_COLOR_LISTID && MPM_listID != MPM_DYNAMIC_LISTID)
	{
//print("not color and not dynamic");
		new itemat = (All_Lists[MPM_listID][MPM_LIST_START] + (GetPVarInt(playerid, "MPM_list_page") * MPM_SELECTION_ITEMS));
		
		// Destroy any previous ones created
		MPM_DestroyPlayerMPs(playerid);

		while(x != MPM_SELECTION_ITEMS && itemat < (All_Lists[MPM_listID][MPM_LIST_END]+1)) {
			if(linetracker == 0) {
				BaseX = MPM_DIALOG_BASE_X + 25.0; // in a bit from the box
				BaseY += MPM_SPRITE_DIM_Y + 1.0; // move on the Y for the next line
			}
			new rzID = All_Items[itemat][MPM_ITEM_ROT_ZOOM_ID]; // avoid long line
			if(rzID > -1) ItemsTD[playerid][x] = MPM_CreateMPTextDraw(playerid, All_Items[itemat][MPM_ITEM_MODEL], BaseX, BaseY, RotZoomInfo[rzID][0], RotZoomInfo[rzID][1], RotZoomInfo[rzID][2], RotZoomInfo[rzID][3], MPM_SPRITE_DIM_X, MPM_SPRITE_DIM_Y, bgcolor);
			else ItemsTD[playerid][x] = MPM_CreateMPTextDraw(playerid, All_Items[itemat][MPM_ITEM_MODEL], BaseX, BaseY, 0.0, 0.0, 0.0, 1.0, MPM_SPRITE_DIM_X, MPM_SPRITE_DIM_Y, bgcolor);
			PreviewItemModel[playerid][x] = All_Items[itemat][MPM_ITEM_MODEL];
			ItemID[playerid][x] = itemid;
			BaseX += MPM_SPRITE_DIM_X + 1.0; // move on the X for the next sprite
			linetracker++;
			itemid++;
			if(linetracker == MPM_ITEMS_PER_LINE) linetracker = 0;
			itemat++;
			x++;
		}
	}
}

//------------------------------------------------

stock MPM_UpdatePageTextDraw(playerid)
{
	new PageText[64+1];
	new listID = MPM_GetPlayerCurrentListID(playerid);
	if(listID == MPM_DYNAMIC_LISTID || listID == MPM_COLOR_LISTID)
	{
		format(PageText, 64, "%d/%d", GetPVarInt(playerid,"MPM_list_page") + 1, MPM_GetPagesAmountEx(playerid));
		PlayerTextDrawSetString(playerid, CurrentPageTextDraw[playerid], PageText);
	}

	else
	{
		format(PageText, 64, "%d/%d", GetPVarInt(playerid,"MPM_list_page") + 1, MPM_GetPagesAmount(listID));
		PlayerTextDrawSetString(playerid, CurrentPageTextDraw[playerid], PageText);
	}
}

//------------------------------------------------
stock ShowMPMenu(playerid, ListID, header_text[], titles_array[][],titles_amount = 0, dialogBGcolor = 0x34c924BB, previewBGcolor = 0xBEF57499 , tdSelectionColor = 0xCCFF00AA, tdTitleColor = 0xcd5700AA)
{
	if(!(0 <= ListID < MPM_TOTAL_LISTS && All_Lists[ListID][MPM_LIST_START] != All_Lists[ListID][MPM_LIST_END])) return 0;
	MPM_DestroySelectionMenu(playerid);
	SetPVarInt(playerid, "MPM_list_page", 0);
	SetPVarInt(playerid, "MPM_list_id", ListID);
	SetPVarInt(playerid, "MPM_list_active", 1);
	SetPVarInt(playerid, "MPM_list_time", GetTickCount());

    BackgroundTextDraw[playerid] = MPM_CreatePlayerBGTextDraw(playerid, MPM_DIALOG_BASE_X, MPM_DIALOG_BASE_Y + 20.0, MPM_DIALOG_WIDTH, MPM_DIALOG_HEIGHT, dialogBGcolor);
    HeaderTextDraw[playerid] = MPM_CreatePlayerHeaderTextDraw(playerid, MPM_DIALOG_BASE_X, MPM_DIALOG_BASE_Y, header_text);
    CurrentPageTextDraw[playerid] = MPM_CreateCurrentPageTextDraw(playerid, MPM_DIALOG_WIDTH - 30.0, MPM_DIALOG_BASE_Y + 15.0);
    NextButtonTextDraw[playerid] = MPM_CreatePlayerDialogButton(playerid, MPM_DIALOG_WIDTH - 30.0, MPM_DIALOG_BASE_Y+MPM_DIALOG_HEIGHT+100.0, 50.0, 16.0, MPM_NEXT_BUTTON);
    PrevButtonTextDraw[playerid] = MPM_CreatePlayerDialogButton(playerid, MPM_DIALOG_WIDTH - 90.0, MPM_DIALOG_BASE_Y+MPM_DIALOG_HEIGHT+100.0, 50.0, 16.0, MPM_BACK_BUTTON);
    CancelButtonTextDraw[playerid] = MPM_CreatePlayerDialogButton(playerid, MPM_DIALOG_WIDTH - 440.0, MPM_DIALOG_BASE_Y+MPM_DIALOG_HEIGHT+100.0, 50.0, 16.0, MPM_EXIT_BUTTON);

	SetPVarInt(playerid, "MPM_previewBGcolor", previewBGcolor);
    MPM_ShowPlayerMPs(playerid);
    MPM_UpdatePageTextDraw(playerid);
if(titles_amount >21) 
{
print("-MPM system- WARNING: Too many titles given to \"ShowMPMenu\", Max titles: 21. This cannot be changed");
titles_amount=21;
}
if(titles_amount !=0)
{
new linetracker=0;
	new Float:BaseX = MPM_DIALOG_BASE_X;
	new Float:BaseY = MPM_DIALOG_BASE_Y - (MPM_SPRITE_DIM_Y * 0.33); // down a bit
		for(new i=0;i<titles_amount;i++)
		{
			if(linetracker == 0) {
				BaseX = MPM_DIALOG_BASE_X + 25.0; // in a bit from the box
				BaseY += MPM_SPRITE_DIM_Y + 1.0; // move on the Y for the next line
			}
			Title[playerid][i] = MPM_CreateTitle(playerid, titles_array[i], BaseX, BaseY,tdTitleColor);
			BaseX += MPM_SPRITE_DIM_X + 1.0; // move on the X for the next sprite
			linetracker++;
			if(linetracker == MPM_ITEMS_PER_LINE) linetracker = 0;
		}
}
else
{
		for(new i=0;i<100;i++)
		{
			
			Title[playerid][i] = PlayerText:INVALID_TEXT_DRAW;
		}
}
	SelectTextDraw(playerid, tdSelectionColor);
	return 1;
}

//------------------------------------------------------------



stock ShowDynamicMPMenu(playerid, items_array[], item_amount, header_text[], extraid, Float:Xrot = 0.0, Float:Yrot = 0.0, Float:Zrot = 0.0, Float:mZoom = 1.0, titles_array[][], dialogBGcolor = 0x34c924BB, previewBGcolor = 0xBEF57499, tdSelectionColor = 0xCCFF00AA,tdTitleColor = 0xcd5700AA)
{	MPM_DestroySelectionMenu(playerid);
	if(item_amount > MPM_DYNAMIC_MAX_ITEMS)
	{
		item_amount = MPM_DYNAMIC_MAX_ITEMS;
		print("-MPM system- WARNING: Too many items given to \"ShowDynamicMPMenu\", increase \"MPM_DYNAMIC_MAX_ITEMS\" to fix this");
	}
	if(item_amount > 0)
	{
		for(new i=0;i<item_amount;i++)
		{
			DynamicList[playerid][i] = items_array[i];
		}
		SetPVarInt(playerid, "MPM_list_page", 0);
		SetPVarInt(playerid, "MPM_list_id", MPM_DYNAMIC_LISTID);
		SetPVarInt(playerid, "MPM_list_active", 1);
		SetPVarInt(playerid, "MPM_list_time", GetTickCount());
	
		SetPVarInt(playerid, "MPM_DYNAMIC_item_amount", item_amount);
		SetPVarFloat(playerid, "MPM_DYNAMIC_Xrot", Xrot);
		SetPVarFloat(playerid, "MPM_DYNAMIC_Yrot", Yrot);
		SetPVarFloat(playerid, "MPM_DYNAMIC_Zrot", Zrot);
		SetPVarFloat(playerid, "MPM_DYNAMIC_Zoom", mZoom);
		SetPVarInt(playerid, "MPM_DYNAMIC_extraid", extraid);
		

		BackgroundTextDraw[playerid] = MPM_CreatePlayerBGTextDraw(playerid, MPM_DIALOG_BASE_X, MPM_DIALOG_BASE_Y + 20.0, MPM_DIALOG_WIDTH, MPM_DIALOG_HEIGHT, dialogBGcolor);
		HeaderTextDraw[playerid] = MPM_CreatePlayerHeaderTextDraw(playerid, MPM_DIALOG_BASE_X, MPM_DIALOG_BASE_Y, header_text);
		CurrentPageTextDraw[playerid] = MPM_CreateCurrentPageTextDraw(playerid, MPM_DIALOG_WIDTH - 30.0, MPM_DIALOG_BASE_Y + 15.0);
		NextButtonTextDraw[playerid] = MPM_CreatePlayerDialogButton(playerid, MPM_DIALOG_WIDTH - 30.0, MPM_DIALOG_BASE_Y+MPM_DIALOG_HEIGHT+100.0, 50.0, 16.0, MPM_NEXT_BUTTON);
		PrevButtonTextDraw[playerid] = MPM_CreatePlayerDialogButton(playerid, MPM_DIALOG_WIDTH - 90.0, MPM_DIALOG_BASE_Y+MPM_DIALOG_HEIGHT+100.0, 50.0, 16.0, MPM_BACK_BUTTON);
		CancelButtonTextDraw[playerid] = MPM_CreatePlayerDialogButton(playerid, MPM_DIALOG_WIDTH - 440.0, MPM_DIALOG_BASE_Y+MPM_DIALOG_HEIGHT+100.0, 50.0, 16.0, MPM_EXIT_BUTTON);

		SetPVarInt(playerid, "MPM_previewBGcolor", previewBGcolor);
		MPM_ShowPlayerMPs(playerid);
		MPM_UpdatePageTextDraw(playerid);
if(item_amount !=0 && strcmp(titles_array[0], NO_TITLES[0])!=0)
{
new linetracker=0;
	new Float:BaseX = MPM_DIALOG_BASE_X;
	new Float:BaseY = MPM_DIALOG_BASE_Y - (MPM_SPRITE_DIM_Y * 0.33); // down a bit
		for(new i=0;i<item_amount;i++)
		{
			if(linetracker == 0) {
				BaseX = MPM_DIALOG_BASE_X + 25.0; // in a bit from the box
				BaseY += MPM_SPRITE_DIM_Y + 1.0; // move on the Y for the next line
			}
			Title[playerid][i] = MPM_CreateTitle(playerid, titles_array[i], BaseX, BaseY,tdTitleColor);
			BaseX += MPM_SPRITE_DIM_X + 1.0; // move on the X for the next sprite
			linetracker++;
			if(linetracker == MPM_ITEMS_PER_LINE) linetracker = 0;
		}
}
else
{
		for(new i=0;i<100;i++)
		{
			
			Title[playerid][i] = PlayerText:INVALID_TEXT_DRAW;
		}
}
		SelectTextDraw(playerid, tdSelectionColor);
		return 1;
	}
	return 0;
}


stock ShowColorMPMenu(playerid, items_array[], item_amount, header_text[], extraid, titles_array[][], dialogBGcolor = 0x34c924BB, previewBGcolor = 0xBEF57499, tdSelectionColor = 0xCCFF00AA,tdTitleColor = 0xcd5700AA)
{	MPM_DestroySelectionMenu(playerid);
	if(item_amount > MPM_DYNAMIC_MAX_ITEMS)
	{
		item_amount = MPM_DYNAMIC_MAX_ITEMS;
		print("-MPM system- WARNING: Too many items given to \"ShowColorMPMenu\", increase \"MPM_COLOR_MAX_ITEMS\" to fix this");
	}
	if(item_amount > 0)
	{
		for(new i=0;i<item_amount;i++)
		{
			ColorList[playerid][i] = items_array[i];
		}
		SetPVarInt(playerid, "MPM_list_page", 0);
		SetPVarInt(playerid, "MPM_list_id", MPM_COLOR_LISTID);
		SetPVarInt(playerid, "MPM_list_active", 1);
		SetPVarInt(playerid, "MPM_list_time", GetTickCount());
	
		SetPVarInt(playerid, "MPM_COLOR_item_amount", item_amount);
		SetPVarInt(playerid, "MPM_COLOR_extraid", extraid);
		

		BackgroundTextDraw[playerid] = MPM_CreatePlayerBGTextDraw(playerid, MPM_DIALOG_BASE_X, MPM_DIALOG_BASE_Y + 20.0, MPM_DIALOG_WIDTH, MPM_DIALOG_HEIGHT, dialogBGcolor);
		HeaderTextDraw[playerid] = MPM_CreatePlayerHeaderTextDraw(playerid, MPM_DIALOG_BASE_X, MPM_DIALOG_BASE_Y, header_text);
		CurrentPageTextDraw[playerid] = MPM_CreateCurrentPageTextDraw(playerid, MPM_DIALOG_WIDTH - 30.0, MPM_DIALOG_BASE_Y + 15.0);
		NextButtonTextDraw[playerid] = MPM_CreatePlayerDialogButton(playerid, MPM_DIALOG_WIDTH - 30.0, MPM_DIALOG_BASE_Y+MPM_DIALOG_HEIGHT+100.0, 50.0, 16.0, MPM_NEXT_BUTTON);
		PrevButtonTextDraw[playerid] = MPM_CreatePlayerDialogButton(playerid, MPM_DIALOG_WIDTH - 90.0, MPM_DIALOG_BASE_Y+MPM_DIALOG_HEIGHT+100.0, 50.0, 16.0, MPM_BACK_BUTTON);
		CancelButtonTextDraw[playerid] = MPM_CreatePlayerDialogButton(playerid, MPM_DIALOG_WIDTH - 440.0, MPM_DIALOG_BASE_Y+MPM_DIALOG_HEIGHT+100.0, 50.0, 16.0, MPM_EXIT_BUTTON);

		for(new i=0;i<item_amount;i++)
		{
			MPM_previewBGcolor[playerid][i]=items_array[i];
		}
		for(new i=item_amount;i<100;i++)
		{
			MPM_previewBGcolor[playerid][i]=previewBGcolor;
		}
		MPM_ShowPlayerMPs(playerid);
		MPM_UpdatePageTextDraw(playerid);
if(item_amount !=0 && strcmp(titles_array[0], NO_TITLES[0])!=0)
{
new linetracker=0;
	new Float:BaseX = MPM_DIALOG_BASE_X;
	new Float:BaseY = MPM_DIALOG_BASE_Y - (MPM_SPRITE_DIM_Y * 0.33); // down a bit
		for(new i=0;i<item_amount;i++)
		{
			if(linetracker == 0) {
				BaseX = MPM_DIALOG_BASE_X + 25.0; // in a bit from the box
				BaseY += MPM_SPRITE_DIM_Y + 1.0; // move on the Y for the next line
			}
			Title[playerid][i] = MPM_CreateTitle(playerid, titles_array[i], BaseX, BaseY,tdTitleColor);
			BaseX += MPM_SPRITE_DIM_X + 1.0; // move on the X for the next sprite
			linetracker++;
			if(linetracker == MPM_ITEMS_PER_LINE) linetracker = 0;
		}
}
else
{
		for(new i=0;i<100;i++)
		{
			
			Title[playerid][i] = PlayerText:INVALID_TEXT_DRAW;
		}
}
		SelectTextDraw(playerid, tdSelectionColor);
		return 1;
	}
	return 0;
}

//------------------------------------------------

stock HideMPMenu(playerid)
{
	MPM_DestroySelectionMenu(playerid);
	SetPVarInt(playerid, "MPM_ignore_next_esc", 1);
	CancelSelectTextDraw(playerid);
	return 1;
}

//------------------------------------------------

stock MPM_DestroySelectionMenu(playerid)
{
	if(GetPVarInt(playerid, "MPM_list_active") == 1)
	{
		if(MPM_GetPlayerCurrentListID(playerid) == MPM_DYNAMIC_LISTID)
		{		
			DeletePVar(playerid, "MPM_DYNAMIC_Xrot");
			DeletePVar(playerid, "MPM_DYNAMIC_Yrot");
			DeletePVar(playerid, "MPM_DYNAMIC_Zrot");
			DeletePVar(playerid, "MPM_DYNAMIC_Zoom");
			DeletePVar(playerid, "MPM_DYNAMIC_extraid");
			DeletePVar(playerid, "MPM_DYNAMIC_item_amount");
		}
		if(MPM_GetPlayerCurrentListID(playerid) == MPM_COLOR_LISTID)
		{		
			DeletePVar(playerid, "MPM_COLOR_extraid");
			DeletePVar(playerid, "MPM_COLOR_item_amount");
		}
		DeletePVar(playerid, "MPM_list_time");
		SetPVarInt(playerid, "MPM_list_active", 0);
		MPM_DestroyPlayerMPs(playerid);

		PlayerTextDrawDestroy(playerid, HeaderTextDraw[playerid]);
		PlayerTextDrawDestroy(playerid, BackgroundTextDraw[playerid]);
		PlayerTextDrawDestroy(playerid, CurrentPageTextDraw[playerid]);
		PlayerTextDrawDestroy(playerid, NextButtonTextDraw[playerid]);
		PlayerTextDrawDestroy(playerid, PrevButtonTextDraw[playerid]);
		PlayerTextDrawDestroy(playerid, CancelButtonTextDraw[playerid]);

		HeaderTextDraw[playerid] = PlayerText:INVALID_TEXT_DRAW;
		BackgroundTextDraw[playerid] = PlayerText:INVALID_TEXT_DRAW;
		CurrentPageTextDraw[playerid] = PlayerText:INVALID_TEXT_DRAW;
		NextButtonTextDraw[playerid] = PlayerText:INVALID_TEXT_DRAW;
		PrevButtonTextDraw[playerid] = PlayerText:INVALID_TEXT_DRAW;
		CancelButtonTextDraw[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
}

//------------------------------------------------

public OnPlayerConnect(playerid)
{
	// Init all of the textdraw related globals
    HeaderTextDraw[playerid] = PlayerText:INVALID_TEXT_DRAW;
    BackgroundTextDraw[playerid] = PlayerText:INVALID_TEXT_DRAW;
    CurrentPageTextDraw[playerid] = PlayerText:INVALID_TEXT_DRAW;
    NextButtonTextDraw[playerid] = PlayerText:INVALID_TEXT_DRAW;
    PrevButtonTextDraw[playerid] = PlayerText:INVALID_TEXT_DRAW;
    CancelButtonTextDraw[playerid] = PlayerText:INVALID_TEXT_DRAW;
  for(new x=0; x < 100; x++) {
	Title[playerid][x] = PlayerText:INVALID_TEXT_DRAW;
}
    
    for(new x=0; x < MPM_SELECTION_ITEMS; x++) {
        ItemsTD[playerid][x] = PlayerText:INVALID_TEXT_DRAW;
	}
	
	globalItemAt[playerid] = 0;
	
	return CallLocalFunction("MP_OPC", "i", playerid);
}

#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect MP_OPC

forward MP_OPC(playerid);

//-------------------------------------------
// Even though only Player* textdraws are used in this script,
// OnPlayerClickTextDraw is still required to handle ESC

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
   	if(GetPVarInt(playerid, "MPM_ignore_next_esc") == 1) {
		SetPVarInt(playerid, "MPM_ignore_next_esc", 0);
		return CallLocalFunction("MP_OPCTD", "ii", playerid, _:clickedid);
	}
   	if(GetPVarInt(playerid, "MPM_list_active") == 0) return CallLocalFunction("MP_OPCTD", "ii", playerid, _:clickedid);

	// Handle: They cancelled (with ESC)
	if(clickedid == Text:INVALID_TEXT_DRAW) {
		new listid = MPM_GetPlayerCurrentListID(playerid);
		if(listid == MPM_DYNAMIC_LISTID)
		{
			new extraid = GetPVarInt(playerid, "MPM_DYNAMIC_extraid");
			MPM_DestroySelectionMenu(playerid);
			CallLocalFunction("OnDynamicMPMenuResponse", "dddd", playerid, 0, extraid, -1,-1);
			PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		}
		if(listid == MPM_COLOR_LISTID)
		{
			new extraid = GetPVarInt(playerid, "MPM_COLOR_extraid");
			MPM_DestroySelectionMenu(playerid);
			CallLocalFunction("OnDynamicMPMenuResponse", "dddd", playerid, 0, extraid, -1,-1);
			PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		}
		if(listid != MPM_COLOR_LISTID && listid != MPM_DYNAMIC_LISTID)
		{
			MPM_DestroySelectionMenu(playerid);
			CallLocalFunction("OnMPMenuResponse", "dddd", playerid, 0, listid, -1,-1);
			PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		}
        return 1;
	}
	
	return CallLocalFunction("MP_OPCTD", "ii", playerid, _:clickedid);
}

#if defined _ALS_OnPlayerClickTextDraw
	#undef OnPlayerClickTextDraw
#else
	#define _ALS_OnPlayerClickTextDraw
#endif
#define OnPlayerClickTextDraw MP_OPCTD

forward MP_OPCTD(playerid, Text:clickedid);

//------------------------------------------------

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	if(GetPVarInt(playerid, "MPM_list_active") == 0 || (GetTickCount()-GetPVarInt(playerid, "MPM_list_time")) < 200 /* Disable instant selection */) return CallLocalFunction("MP_OPCPTD", "ii", playerid, _:playertextid);

	new curpage = GetPVarInt(playerid, "MPM_list_page");
	
	// Handle: cancel button
	if(playertextid == CancelButtonTextDraw[playerid]) {
		new listID = MPM_GetPlayerCurrentListID(playerid);
		if(listID == MPM_DYNAMIC_LISTID)
		{
			new extraid = GetPVarInt(playerid, "MPM_DYNAMIC_extraid");
			HideMPMenu(playerid);
			CallLocalFunction("OnDynamicMPMenuResponse", "dddd", playerid, 0, extraid, -1,-1);
			PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		}
		if(listID == MPM_COLOR_LISTID)
		{
			new extraid = GetPVarInt(playerid, "MPM_COLOR_extraid");
			HideMPMenu(playerid);
			CallLocalFunction("OnDynamicMPMenuResponse", "dddd", playerid, 0, extraid, -1,-1);
			PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		}
		if(listID != MPM_COLOR_LISTID && listID != MPM_DYNAMIC_LISTID)
		{
			HideMPMenu(playerid);
			CallLocalFunction("OnMPMenuResponse", "dddd", playerid, 0, listID, -1,-1);
			PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		}
		return 1;
	}
		
	// Handle: next button
	if(playertextid == NextButtonTextDraw[playerid]) {
		new listID = MPM_GetPlayerCurrentListID(playerid);
		if(listID == MPM_DYNAMIC_LISTID)
		{			
			if(curpage < (MPM_GetPagesAmountEx(playerid) - 1)) {
				SetPVarInt(playerid, "MPM_list_page", curpage + 1);
				MPM_ShowPlayerMPs(playerid);
				MPM_UpdatePageTextDraw(playerid);
				PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
			} else {
				PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
			}
		}
		else
		{
			if(curpage < (MPM_GetPagesAmount(listID) - 1)) {
				SetPVarInt(playerid, "MPM_list_page", curpage + 1);
				MPM_ShowPlayerMPs(playerid);
				MPM_UpdatePageTextDraw(playerid);
				PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
			} else {
				PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
			}
		}
		return 1;
	}
	
	// Handle: previous button
	if(playertextid == PrevButtonTextDraw[playerid]) {
	    if(curpage > 0) {
	    	SetPVarInt(playerid, "MPM_list_page", curpage - 1);
	    	MPM_ShowPlayerMPs(playerid);
	    	MPM_UpdatePageTextDraw(playerid);
	    	PlayerPlaySound(playerid, 1084, 0.0, 0.0, 0.0);
		} else {
		    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		}
		return 1;
	}
	
	// Search in the array of textdraws used for the items
	new x=0;
	while(x != MPM_SELECTION_ITEMS) {
	    if(playertextid == ItemsTD[playerid][x]) {
			new listID = MPM_GetPlayerCurrentListID(playerid);
			if(listID == MPM_DYNAMIC_LISTID)
			{
				PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
				new item_id = PreviewItemModel[playerid][x];
				new item_id2 = ItemID[playerid][x];
				new extraid = GetPVarInt(playerid, "MPM_DYNAMIC_extraid");
				HideMPMenu(playerid);
				CallLocalFunction("OnDynamicMPMenuResponse", "ddddd", playerid, 1, extraid, item_id, item_id2);
				
				return 1;
			}
			if(listID == MPM_COLOR_LISTID)
			{
				PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
				new item_id = PreviewItemModel[playerid][x];
				new item_id2 = ItemID[playerid][x];
				new extraid = GetPVarInt(playerid, "MPM_COLOR_extraid");
				HideMPMenu(playerid);
				CallLocalFunction("OnDynamicMPMenuResponse", "ddddd", playerid, 1, extraid, item_id, item_id2);
				
				return 1;
			}
			if(listID != MPM_COLOR_LISTID && listID != MPM_DYNAMIC_LISTID)
			{
				PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
				new item_id = PreviewItemModel[playerid][x];
				new item_id2 = ItemID[playerid][x];
				HideMPMenu(playerid);
				CallLocalFunction("OnMPMenuResponse", "ddddd", playerid, 1, listID, item_id, item_id2);

				return 1;
			}
		}
		x++;
	}
	
	return CallLocalFunction("MP_OPCPTD", "ii", playerid, _:playertextid);
}

#if defined _ALS_OnPlayerClickPlayerTD
	#undef OnPlayerClickPlayerTextDraw
#else
	#define _ALS_OnPlayerClickPlayerTD
#endif
#define OnPlayerClickPlayerTextDraw MP_OPCPTD

forward MP_OPCPTD(playerid, PlayerText:playertextid);

//------------------------------------------------------------------


stock LoadMPMenu(f_name[])
{
	new File:f, str[75];
	format(str, sizeof(str), "%s", f_name);
	f = fopen(str, io_read);
	if( !f ) {
		printf("-MPM system- WARNING: Failed to load list: \"%s\"", f_name);
		return MPM_INVALID_LISTID;
	}
	
	if(ListAmount >= MPM_TOTAL_LISTS)
	{
		printf("-MPM system- WARNING: Reached maximum amount of lists, increase \"MPM_TOTAL_LISTS\"", f_name);
		return MPM_INVALID_LISTID;
	}
	new tmp_ItemAmount = ItemAmount; // copy value if loading fails
	
	
	new line[128], idxx;
	while(fread(f,line,sizeof(line),false))
	{
		if(tmp_ItemAmount >= MPM_TOTAL_ITEMS)
		{
			printf("-MPM system- WARNING: Reached maximum amount of items, increase \"MPM_TOTAL_ITEMS\"", f_name);
			break;
		}
		idxx = 0;
		if(!line[0]) continue;
		new mID = strval( MPM_strtok(line,idxx) );
		if(0 <= mID < 20000)
		{
			All_Items[tmp_ItemAmount][MPM_ITEM_MODEL] = mID;
		
			new tmp_MPM_strtok[20];
			new Float:mRotation[3], Float:mZoom = 1.0;
			new bool:useRotation = false;
			
			tmp_MPM_strtok = MPM_strtok(line,idxx);
			if(tmp_MPM_strtok[0]) {
				useRotation = true;
				mRotation[0] = floatstr(tmp_MPM_strtok);
			}
			tmp_MPM_strtok = MPM_strtok(line,idxx);
			if(tmp_MPM_strtok[0]) {
				useRotation = true;
				mRotation[1] = floatstr(tmp_MPM_strtok);
			}
			tmp_MPM_strtok = MPM_strtok(line,idxx);
			if(tmp_MPM_strtok[0]) {
				useRotation = true;
				mRotation[2] = floatstr(tmp_MPM_strtok);
			}
			tmp_MPM_strtok = MPM_strtok(line,idxx);
			if(tmp_MPM_strtok[0]) {
				useRotation = true;
				mZoom = floatstr(tmp_MPM_strtok);
			}
			if(useRotation)
			{
				new bool:foundRotZoom = false;
				for(new i=0; i < RotZoomInfoAmount; i++)
				{
					if(RotZoomInfo[i][0] == mRotation[0] && RotZoomInfo[i][1] == mRotation[1] && RotZoomInfo[i][2] == mRotation[2] && RotZoomInfo[i][3] == mZoom)
					{
						foundRotZoom = true;
						All_Items[tmp_ItemAmount][MPM_ITEM_ROT_ZOOM_ID] = i;
						break;
					}
				}
				if(RotZoomInfoAmount < MPM_TOTAL_ROT_ZOOM)
				{
					if(!foundRotZoom)
					{
						RotZoomInfo[RotZoomInfoAmount][0] = mRotation[0];
						RotZoomInfo[RotZoomInfoAmount][1] = mRotation[1];
						RotZoomInfo[RotZoomInfoAmount][2] = mRotation[2];
						RotZoomInfo[RotZoomInfoAmount][3] = mZoom;
						All_Items[tmp_ItemAmount][MPM_ITEM_ROT_ZOOM_ID] = RotZoomInfoAmount;
						RotZoomInfoAmount++;
					}
				}
				else print("-MPM system- WARNING: Not able to save rotation/zoom information. Reached maximum rotation/zoom information count. Increase '#define MPM_TOTAL_ROT_ZOOM' to fix the issue");
			}
			else All_Items[tmp_ItemAmount][MPM_ITEM_ROT_ZOOM_ID] = -1;
			tmp_ItemAmount++;
		}
	}
	if(tmp_ItemAmount > ItemAmount) // any models loaded ?
	{
		All_Lists[ListAmount][MPM_LIST_START] = ItemAmount;
		ItemAmount = tmp_ItemAmount; // copy back
		All_Lists[ListAmount][MPM_LIST_END] = (ItemAmount-1);
		
		ListAmount++;
		return (ListAmount-1);
	}
	printf("-MPM system- WARNING: No Items found in file: %s", f_name);
	return MPM_INVALID_LISTID;
}
			
	
	
stock MPM_strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}

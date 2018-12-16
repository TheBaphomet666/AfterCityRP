/*--------------------------------------------------------------------------------------*\
!		H_RentSystem © by Hauke Marquardt aka |-|auke				 					 !
!----------------------------------------------------------------------------------------!
! You are not allowed to delete the Compyrights and change the names of the variables.   !
! Du darfst die Copyrights nicht entfernen, und die Namen der Variablen nicht ändern !	 !
!----------------------------------------------------------------------------------------!
!		  Please visit my Site at: http://www.1000zet.net			 					 !
!	      Bitte besuch´doch mal meine Seite: http://www.1000zet.net			 			 !
-----------------------------------------------------------------------------------------!
!																						 !
!		 Support and Informations: hauke.marquardt@1000zet.net                           !
!	        Support und Informationen:  hauke.marquardt@1000zet.net                      !
\*--------------------------------------------------------------------------------------*/
#include <a_samp>
/***************************** Einstellungen *******************************/
//================================================
// Gib hier die Koordinaten des Kaufpickups ein
new Float:H_RentPlaceX=746.4490;
new Float:H_RentPlaceY=-1349.0807;
new Float:H_RentPlaceZ=13.5084;
//================================================
// Die Zeit, in Minuten, für die man ein Auto / Motorrad mietet.
new H_RentMinutes= 10;
//================================================
// Wenn beim Pickupaufnehmen das Mietmenü kommen soll,
// "true" einsetzten. Ansonsten "false"
new bool:PickupBenutzen= true;
//================================================
// Mit "//" auskommentieren, wenn man Autos stehlen darf.
#define H_DontAllowStealing
//================================================
// "//" Wegmachen, wenn man Autos stehlen darf.
// #define H_AllowStealing
//================================================
// Bei Liveansicht "true" eingeben. Wenn man eine Liste
// möchte, "false" einsetzten.
new bool:Livebenutzen= false;
//================================================
// Wenn das Auto beim Anfang den Mietens abgeschlossen sein
// soll, setze "true" ein. Wenn nicht, benutze "false"
new bool:H_LockEingabe= false;
/***************************************************************************/

#define Farbauswahl 900
#define Carauswahl 901
#define ListAutos 902
#define ListSchnelle 903
#define ListBikes 904
forward H_OrderCar(playerid,CarNumber,CarColor);
forward H_CarCountDown();
forward LiveView(playerid,Nummer,CarColor);
forward PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z);
new H_PlayerCarID[MAX_PLAYERS]=999;
new H_PlayerCar[MAX_PLAYERS];
new H_PlayerCount[MAX_PLAYERS];
new H_ChoosenColor[MAX_PLAYERS];
new bool:H_RentedCar[MAX_PLAYERS];
new bool:H_CarLocked[MAX_PLAYERS];
new H_ShowCar[MAX_PLAYERS];
new PlayerShowCar[MAX_PLAYERS];
new IsLiveViewing[MAX_PLAYERS]=0;
new Text:H_CarRent[MAX_PLAYERS];
new H_RentedCars=0;
new H_CarSpawn= 1;
new H_Pickup;
new Float:ShowCarSpawnX=745.7913,Float:ShowCarSpawnY=-1373.2169,Float:ShowCarSpawnZ=25.5163,Float:ShowCarSpawnRot=208.1557;
new Float:H_CarSpawns[4][4]=
{
	{757.2670,-1333.6682,13.3656,178.7771},
	{752.1066,-1333.6682,13.3649,180.8010},
	{746.8506,-1333.6682,13.3671,179.9579},
	{741.2214,-1333.6682,13.3660,180.5529}
};
new H_Cars[11][256]=
{
    {604,500,"Glendale"},      		// Glendale Shit
    {421,700,"Washington"},     	// Washington
    {419,850,"Esperanto"},      	// Esperanto
    {551,950,"Merit"},          	// Merit
    {410,950,"Manana"},				// Manana
	{401,890,"Bravura"},			// Bravura
	{405,1200,"Sentinel"},			// Sentinel
	{439,1200,"Stallion"},          // Stallion
	{560,1300,"Sultan"},     		// Sultan
	{533,1350,"Felitzer"},          // Felitzer
	{480,1400,"Comet"}              // Comet
};
new H_SportCars[8][256]=
{
	{489,1000,"Club"},              // Club
    {496,1400,"Blista Compact"},	// Blista Compact
    {576,1500,"Tornado"},           // Tornado
    {475,1850,"Sabre"},         	// Sabre
    {429,2000,"Bangshee Banger"},	// Bangshee Banger
    {402,3000,"Buffalo"},	       	// Buffalo
    {451,3200,"Turismo"},      	 	// Turismo
	{411,3400,"Infernus"}       	// Infernus
};
new H_Bikes[7][256]=
{
	{481,50,"BMX"},                 // BMX
	{462,300,"Fraggio"},            // Fraggio
	{468,450,"Sanchez"},            // Sanchez
	{461,600,"PCJ-600"},            // PCJ-600
	{463,650,"Freeway"},            // Freeway
	{522,800,"NRG 500"},            // NRG 500
	{586,1000,"Wayfarer"}           // Wayfarer
};

public OnFilterScriptInit()
{
	SetTimer("H_CarCountDown",60000,1);
	H_Pickup=CreatePickup(1210,1,H_RentPlaceX,H_RentPlaceY,H_RentPlaceZ);
	for(new i = 0;i<MAX_PLAYERS;i++)
		{
			H_CarRent[i] = TextDrawCreate(493.0,127.000000,"H_CarRent");
			TextDrawAlignment(H_CarRent[i],0);
			TextDrawBackgroundColor(H_CarRent[i],0x000000FF);
			TextDrawFont(H_CarRent[i],1);
			TextDrawLetterSize(H_CarRent[i],0.23,1.4);
			TextDrawColor(H_CarRent[i],0x2F5426FF);
			TextDrawSetProportional(H_CarRent[i],1);
			TextDrawSetShadow(H_CarRent[i],1);
			TextDrawSetOutline(H_CarRent[i],1);
		}
	return 1;
}
public OnPlayerConnect(playerid)
{
    SetPlayerMapIcon(playerid, 98, H_RentPlaceX, H_RentPlaceY, H_RentPlaceZ, 55, 0);
	return 1;
}
public OnPlayerDisconnect(playerid, reason)
{
	DestroyVehicle(H_PlayerCar[playerid]);
	H_PlayerCarID[playerid]=999;
	H_PlayerCar[playerid]=0;
	H_PlayerCount[playerid]=H_RentMinutes;
	H_ChoosenColor[playerid]=0;
	H_CarLocked[playerid]=true;
	H_RentedCars-=1;
	return 1;
}
public OnPlayerSpawn(playerid)
{
	H_PlayerCount[playerid]=H_RentMinutes;
	H_CarLocked[playerid]=H_LockEingabe;
	return 1;
}
public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/rentinfo", cmdtext, true, 10) == 0)
		{
   			new Message[128];
   			format(Message,sizeof(Message),"Du hast dein Auto noch für %d Minuten",H_PlayerCount[playerid]);
   			SendClientMessage(playerid,0x0099FFFF,"=== Rentinfo ===");
   			if(PickupBenutzen==true)
   			    {
   					SendClientMessage(playerid,0x0099FFFF,"/rentcar   Im Pickup benutzen des Autohauses zu benutzen");
				}
   			SendClientMessage(playerid,0x0099FFFF,"/lockcar   Schließt das Auto ab");
   			SendClientMessage(playerid,0x0099FFFF,"/opencar   Öffnet das Auto");
   			SendClientMessage(playerid,0x0099FFFF,Message);
			return 1;
		}
    if (strcmp("/rentcar", cmdtext, true, 10) == 0)
		{
		    if(PlayerToPoint(4,playerid,H_RentPlaceX,H_RentPlaceY,H_RentPlaceZ))
		        {
		    		ShowPlayerDialog(playerid,900,DIALOG_STYLE_LIST,"Autofarben","Schwarz\nBlau\nRot\nGrün\nGelb\nRosa\nGrau\nHell-Blau\nHell-Rot\nHell-Grün\nHell-Grau\nWeiß","Auswählen","Abbrechen");
				}
			else
			    {
					SendClientMessage(playerid,0xFFFF33FF,"Du stehst bei keiner Autovermietung");
				}
			return 1;
		}
	#if defined H_DontAllowStealing
	if (strcmp("/lockcar", cmdtext, true, 10) == 0)
		{
			SendClientMessage(playerid,0xFFFF33FF,"Auto abgeschlossen");
			H_CarLocked[playerid] = true;
			return 1;
		}
    if (strcmp("/opencar", cmdtext, true, 10) == 0)
		{
			SendClientMessage(playerid,0xFFFF33FF,"Auto aufgeschlossen");
			H_CarLocked[playerid] = false;
			return 1;
		}
	#endif
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	#if defined H_DontAllowStealing
	for(new ID=0;ID<MAX_PLAYERS;ID++)
	    {
	        if(H_PlayerCarID[ID] == vehicleid && vehicleid != 999)
	            {
	                if(H_CarLocked[ID] == true)
	                    {
							TogglePlayerControllable(playerid,0);
							TogglePlayerControllable(playerid,1);
	                		new name[MAX_PLAYER_NAME],ErrorMessage[128];
	                		GetPlayerName(ID,name,MAX_PLAYER_NAME);
	                		format(ErrorMessage,128,"*Abgeschlossen* Dieses Auto hat %s gemietet",name);
	                		SendClientMessage(playerid,0xCCCCCCFF,ErrorMessage);
						}
					else if(H_CarLocked[ID] == false)
					    {
					        if(ID != playerid)
					            {
					        		new name[MAX_PLAYER_NAME],ErrorMessage[128];
	                				GetPlayerName(ID,name,MAX_PLAYER_NAME);
	                				format(ErrorMessage,128,"*Aufgeschlossen* Du hast %s´s gemietetes Auto gestohlen",name);
	                				SendClientMessage(playerid,0xCCCCCCFF,ErrorMessage);
								}
							else
							    {
							        new ErrorMessage[128];
	                				format(ErrorMessage,128,"*Aufgeschlossen* Du hast dein Auto noch für %d Minuten",H_PlayerCount[playerid]);
	                				SendClientMessage(playerid,0xCCCCCCFF,ErrorMessage);
							    }
					    }
				}
		}
	#endif
	#if defined H_AllowedStealing
	for(new ID=0;ID<MAX_PLAYERS;ID++)
	    {
	        if(H_PlayerCarID[ID] == vehicleid && vehicleid != 999)
	            {
	        		if(ID != playerid)
         				{
       						new name[MAX_PLAYER_NAME],ErrorMessage[128];
  							GetPlayerName(ID,name,MAX_PLAYER_NAME);
  							format(ErrorMessage,128,"Du hast %s´s gemietetes Auto gestohlen",name);
     						SendClientMessage(playerid,0xCCCCCCFF,ErrorMessage);
						}
					else
	 					{
  							new ErrorMessage[128];
							format(ErrorMessage,128,"Du hast dein Auto noch für %d Minuten",H_PlayerCount[playerid]);
							SendClientMessage(playerid,0xCCCCCCFF,ErrorMessage);
  				}
		}
	#endif
	return 1;
}
public OnPlayerPickUpPickup(playerid, pickupid)
{
	if(pickupid == H_Pickup)
		{
			if(PickupBenutzen==false)
	    		{
	        		SendClientMessage(playerid,0x999999FF,"Benutze /rentcar");
				}
            if(PickupBenutzen==true)
	    		{
	    		    ShowPlayerDialog(playerid,900,DIALOG_STYLE_LIST,"Autofarben","Schwarz\nBlau\nRot\nGrün\nGelb\nRosa\nGrau\nHell-Blau\nHell-Rot\nHell-Grün\nHell-Grau\nWeiß","Auswählen","Abbrechen");
	    		}
		}
	return 1;
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(IsLiveViewing[playerid]==1)
	    {
	        if(newkeys == KEY_LOOK_RIGHT || newkeys == KEY_ANALOG_RIGHT)
  				{
							new CAR=PlayerShowCar[playerid]+=1;
							new string[246];
							DestroyVehicle(H_ShowCar[playerid]);
							H_ShowCar[playerid]=CreateVehicle(H_Cars[CAR][0],ShowCarSpawnX,ShowCarSpawnY,ShowCarSpawnZ,ShowCarSpawnRot,H_ChoosenColor[playerid],H_ChoosenColor[playerid],-1);
		      				SetVehicleVirtualWorld(H_ShowCar[playerid],99+playerid);
		        			format(string,sizeof(string),"~r~===== Miethaus =====~n~~y~Fahrzeug: ~w~%s~n~~g~Preis: ~w~$%d/%dMin.~n~~n~~g~Numpad 4 und 6~n~Fahrzeug wechseln~n~Kaufen mit Enter~n~Tab zum Abbrechen",H_Cars[CAR][2],H_Cars[CAR][1],H_RentMinutes);
		                    TextDrawSetString(H_CarRent[playerid],string);
				}
            if(newkeys == KEY_LOOK_LEFT || newkeys == KEY_ANALOG_LEFT)
  				{
							new CAR=PlayerShowCar[playerid]-=1;
				    		new string[246];
				    		DestroyVehicle(H_ShowCar[playerid]);
							H_ShowCar[playerid]=CreateVehicle(H_Cars[CAR][0],ShowCarSpawnX,ShowCarSpawnY,ShowCarSpawnZ,ShowCarSpawnRot,H_ChoosenColor[playerid],H_ChoosenColor[playerid],-1);
		      				SetVehicleVirtualWorld(H_ShowCar[playerid],99+playerid);
		        			format(string,sizeof(string),"~r~===== Miethaus =====~n~~y~Fahrzeug: ~w~%s~n~~g~Preis: ~w~$%d/%dMin.~n~~n~~g~Numpad 4 und 6~n~Fahrzeug wechseln~n~Kaufen mit Enter~n~Tab zum Abbrechen",H_Cars[CAR][2],H_Cars[CAR][1],H_RentMinutes);
		                    TextDrawSetString(H_CarRent[playerid],string);
				}
            if(newkeys == 16)
	   		 	{
	   		 	    GivePlayerMoney(playerid,-H_Cars[PlayerShowCar[playerid]][1]);
	   		 	    SetCameraBehindPlayer(playerid);
	   		 	    SetPlayerVirtualWorld(playerid,0);
	   		 	    IsLiveViewing[playerid]=0;
	   		 	    TogglePlayerControllable(playerid,1);
	   		 	    DestroyVehicle(H_ShowCar[playerid]);
	   		 	    TextDrawHideForPlayer(playerid,H_CarRent[playerid]);
	   		 	    H_OrderCar(playerid,H_Cars[PlayerShowCar[playerid]][0],H_ChoosenColor[playerid]);
	   		 	    PlayerShowCar[playerid]=0;
				}
            if(newkeys == KEY_ACTION) //Tab
  				{
  		    		SetCameraBehindPlayer(playerid);
  		    		DestroyVehicle(H_ShowCar[playerid]);
					SetPlayerVirtualWorld(playerid,0);
					TextDrawHideForPlayer(playerid,H_CarRent[playerid]);
					TogglePlayerControllable(playerid,1);
					IsLiveViewing[playerid]=0;
	   		 	    PlayerShowCar[playerid]=0;
	   		 	    DestroyVehicle(H_ShowCar[playerid]);
	   		 	    SetPlayerPos(playerid,H_RentPlaceX,H_RentPlaceY,H_RentPlaceZ);
  				}
		}
	if(IsLiveViewing[playerid]==2)
	    {
	        if(newkeys == KEY_LOOK_RIGHT || newkeys == KEY_ANALOG_RIGHT)
  				{
							new CAR=PlayerShowCar[playerid]+=1;
							new string[246];
							DestroyVehicle(H_ShowCar[playerid]);
							H_ShowCar[playerid]=CreateVehicle(H_SportCars[CAR][0],ShowCarSpawnX,ShowCarSpawnY,ShowCarSpawnZ,ShowCarSpawnRot,H_ChoosenColor[playerid],H_ChoosenColor[playerid],-1);
		      				SetVehicleVirtualWorld(H_ShowCar[playerid],99+playerid);
		        			format(string,sizeof(string),"~r~===== Miethaus =====~n~~y~Fahrzeug: ~w~%s~n~~g~Preis: ~w~$%d/%dMin.~n~~n~~g~Numpad 4 und 6~n~Fahrzeug wechseln~n~Kaufen mit Enter~n~Tab zum Abbrechen",H_SportCars[CAR][2],H_SportCars[CAR][1],H_RentMinutes);
		                    TextDrawSetString(H_CarRent[playerid],string);
				}
            if(newkeys == KEY_LOOK_LEFT || newkeys == KEY_ANALOG_LEFT)
  				{
							new CAR=PlayerShowCar[playerid]-=1;
				    		new string[246];
				    		DestroyVehicle(H_ShowCar[playerid]);
							H_ShowCar[playerid]=CreateVehicle(H_SportCars[CAR][0],ShowCarSpawnX,ShowCarSpawnY,ShowCarSpawnZ,ShowCarSpawnRot,H_ChoosenColor[playerid],H_ChoosenColor[playerid],-1);
		      				SetVehicleVirtualWorld(H_ShowCar[playerid],99+playerid);
		        			format(string,sizeof(string),"~r~===== Miethaus =====~n~~y~Fahrzeug: ~w~%s~n~~g~Preis: ~w~$%d/%dMin.~n~~n~~g~Numpad 4 und 6~n~Fahrzeug wechseln~n~Kaufen mit Enter~n~Tab zum Abbrechen",H_SportCars[CAR][2],H_SportCars[CAR][1],H_RentMinutes);
		                    TextDrawSetString(H_CarRent[playerid],string);
				}
            if(newkeys == 16)
	   		 	{
	   		 	    GivePlayerMoney(playerid,-H_SportCars[PlayerShowCar[playerid]][1]);
	   		 	    SetCameraBehindPlayer(playerid);
	   		 	    SetPlayerVirtualWorld(playerid,0);
	   		 	    IsLiveViewing[playerid]=0;
	   		 	    TogglePlayerControllable(playerid,1);
	   		 	    DestroyVehicle(H_ShowCar[playerid]);
	   		 	    TextDrawHideForPlayer(playerid,H_CarRent[playerid]);
	   		 	    H_OrderCar(playerid,H_SportCars[PlayerShowCar[playerid]][0],H_ChoosenColor[playerid]);
	   		 	    PlayerShowCar[playerid]=0;
				}
            if(newkeys == KEY_ACTION) //Tab
  				{
  		    		SetCameraBehindPlayer(playerid);
  		    		DestroyVehicle(H_ShowCar[playerid]);
					SetPlayerVirtualWorld(playerid,0);
					TextDrawHideForPlayer(playerid,H_CarRent[playerid]);
					TogglePlayerControllable(playerid,1);
					IsLiveViewing[playerid]=0;
	   		 	    PlayerShowCar[playerid]=0;
	   		 	    DestroyVehicle(H_ShowCar[playerid]);
	   		 	    SetPlayerPos(playerid,H_RentPlaceX,H_RentPlaceY,H_RentPlaceZ);
  				}
		}
	if(IsLiveViewing[playerid]==3)
	    {
	        if(newkeys == KEY_LOOK_RIGHT || newkeys == KEY_ANALOG_RIGHT)
  				{
							new CAR=PlayerShowCar[playerid]+=1;
							new string[246];
							DestroyVehicle(H_ShowCar[playerid]);
							H_ShowCar[playerid]=CreateVehicle(H_Bikes[CAR][0],ShowCarSpawnX,ShowCarSpawnY,ShowCarSpawnZ,ShowCarSpawnRot,H_ChoosenColor[playerid],H_ChoosenColor[playerid],-1);
		      				SetVehicleVirtualWorld(H_ShowCar[playerid],99+playerid);
		        			format(string,sizeof(string),"~r~===== Miethaus =====~n~~y~Fahrzeug: ~w~%s~n~~g~Preis: ~w~$%d/%dMin.~n~~n~~g~Numpad 4 und 6~n~Fahrzeug wechseln~n~Kaufen mit Enter~n~Tab zum Abbrechen",H_Bikes[CAR][2],H_Bikes[CAR][1],H_RentMinutes);
		                    TextDrawSetString(H_CarRent[playerid],string);
				}
            if(newkeys == KEY_LOOK_LEFT || newkeys == KEY_ANALOG_LEFT)
  				{
							new CAR=PlayerShowCar[playerid]-=1;
				    		new string[246];
				    		DestroyVehicle(H_ShowCar[playerid]);
							H_ShowCar[playerid]=CreateVehicle(H_Bikes[CAR][0],ShowCarSpawnX,ShowCarSpawnY,ShowCarSpawnZ,ShowCarSpawnRot,H_ChoosenColor[playerid],H_ChoosenColor[playerid],-1);
		      				SetVehicleVirtualWorld(H_ShowCar[playerid],99+playerid);
		        			format(string,sizeof(string),"~r~===== Miethaus =====~n~~y~Fahrzeug: ~w~%s~n~~g~Preis: ~w~$%d/%dMin.~n~~n~~g~Numpad 4 und 6~n~Fahrzeug wechseln~n~Kaufen mit Enter~n~Tab zum Abbrechen",H_Bikes[CAR][2],H_Bikes[CAR][1],H_RentMinutes);
		                    TextDrawSetString(H_CarRent[playerid],string);
				}
            if(newkeys == 16)
	   		 	{
	   		 	    GivePlayerMoney(playerid,-H_Bikes[PlayerShowCar[playerid]][1]);
	   		 	    SetCameraBehindPlayer(playerid);
	   		 	    SetPlayerVirtualWorld(playerid,0);
	   		 	    IsLiveViewing[playerid]=0;
	   		 	    TogglePlayerControllable(playerid,1);
	   		 	    DestroyVehicle(H_ShowCar[playerid]);
	   		 	    TextDrawHideForPlayer(playerid,H_CarRent[playerid]);
	   		 	    H_OrderCar(playerid,H_Bikes[PlayerShowCar[playerid]][0],H_ChoosenColor[playerid]);
	   		 	    PlayerShowCar[playerid]=0;
				}
            if(newkeys == KEY_ACTION) //Tab
  				{
  		    		SetCameraBehindPlayer(playerid);
  		    		DestroyVehicle(H_ShowCar[playerid]);
					SetPlayerVirtualWorld(playerid,0);
					TextDrawHideForPlayer(playerid,H_CarRent[playerid]);
					TogglePlayerControllable(playerid,1);
					IsLiveViewing[playerid]=0;
	   		 	    PlayerShowCar[playerid]=0;
	   		 	    DestroyVehicle(H_ShowCar[playerid]);
	   		 	    SetPlayerPos(playerid,H_RentPlaceX,H_RentPlaceY,H_RentPlaceZ);
  				}
		}
	return 1;
}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid==900)
	    {
	        if(response)
	            {
	                if(listitem==0){H_ChoosenColor[playerid]=0;}
	                else if(listitem==1){H_ChoosenColor[playerid]=125;}
					else if(listitem==2){H_ChoosenColor[playerid]=3;}
                    else if(listitem==3){H_ChoosenColor[playerid]=44;}
					else if(listitem==4){H_ChoosenColor[playerid]=6;}
					else if(listitem==5){H_ChoosenColor[playerid]=126;}
					else if(listitem==6){H_ChoosenColor[playerid]=13;}
					else if(listitem==7){H_ChoosenColor[playerid]=7;}
                    else if(listitem==8){H_ChoosenColor[playerid]=70;}
					else if(listitem==9){H_ChoosenColor[playerid]=16;}
					else if(listitem==10){H_ChoosenColor[playerid]=8;}
					else if(listitem==11){H_ChoosenColor[playerid]=1;}
					ShowPlayerDialog(playerid,901,DIALOG_STYLE_LIST,"Car Verleih","Normale Autos		Preise: 500$ bis 1400$\nSportwagen		Preise: 1000$ bis 3400$\n2 Räder			Preise: 50$ - 1000$","Auswählen","Abbrechen");
				}
		}
	if(dialogid==901)
	    {
	        if(response)
	            {
	                if(listitem==0)
	                    {
	                        if(Livebenutzen==true)
	                            {
	                                LiveView(playerid,1,H_ChoosenColor[playerid]);
	                                return 1;
	                            }
	                        ShowPlayerDialog(playerid,902,DIALOG_STYLE_LIST,"Car Verleih","Glendale Shit	Preis: 500$\nWashington	Preis: 700$\nEsperanto	Preis: 850$\nMerit		Preis: 950$\nManana		Preis: 950$\nBravura	Preis: 890$\nSentinel	Preis: 1200$\nStallion		Preis: 1200$\nSultan		Preis: 1300$\nFelitzer		Preis: 1350$\nComet		Preis: 1400$","Auswählen","Abbrechen");
	                    }
	                else if(listitem==1)
	                    {
                     		if(Livebenutzen==true)
	                            {
	                                LiveView(playerid,2,H_ChoosenColor[playerid]);
	                                return 1;
	                            }
	                        ShowPlayerDialog(playerid,903,DIALOG_STYLE_LIST,"Car Verleih","Club			Preis: 1000$\nBlista Compact		Preis: 1400$\nTornado		Preis: 1500$\nSabre			Preis: 1850$\nBangshee Banger	Preis: 2000$\nBuffalo			Preis: 3000$\nTurismo		Preis: 3200$\nInfernus		Preis: 3400$","Auswählen","Abbrechen");
	                    }
					else if(listitem==2)
					    {
         					if(Livebenutzen==true)
	                            {
	                                LiveView(playerid,3,H_ChoosenColor[playerid]);
	                                return 1;
	                            }
					        ShowPlayerDialog(playerid,904,DIALOG_STYLE_LIST,"Car Verleih","Fraggio			Preis: 50$\nBMX			Preis: 300$\nSanchez		Preis: 450$\nPCJ-600		Preis: 600$\nFreeway 		Preis: 650$\nNRG 500		Preis: 800$\nWayfarer		Preis: 1000$\n","Auswählen","Abbrechen");
					    }
	            }
	        else
	            {
	                SendClientMessage(playerid,0x999999FF,"Mieten abgebrochen");
	            }
	    }
	if(dialogid==902)
	    {
	        new Text[256];
	        if(response)
	            {
	                if(GetPlayerMoney(playerid) >= H_Cars[listitem][1])
	                    {
	                		H_OrderCar(playerid,H_Cars[listitem][0],H_ChoosenColor[playerid]);
	                		GivePlayerMoney(playerid,-H_Cars[listitem][1]);
	                		format(Text,sizeof(Text),"Du hast %s für %d$ %d Minuten lang gemietet",H_Cars[listitem][2],H_Cars[listitem][1],H_RentMinutes);
	                		SendClientMessage(playerid,0x00FF00FF,Text);
						}
					else
					    {
					        SendClientMessage(playerid,0xFF6600FF,"Du hast nicht genug Geld");
					    }
	            }
			else
				{
				    SendClientMessage(playerid,0x999999FF,"Mieten abgebrochen");
				}
	    }
	if(dialogid==903)
	    {
	        new Text[256];
	        if(response)
	            {
	                if(GetPlayerMoney(playerid) >= H_SportCars[listitem][1])
	                    {
	                		H_OrderCar(playerid,H_SportCars[listitem][0],H_ChoosenColor[playerid]);
	                		GivePlayerMoney(playerid,-H_SportCars[listitem][1]);
	                		format(Text,sizeof(Text),"Du hast %s für %d$ %d Minuten lang gemietet",H_SportCars[listitem][2],H_SportCars[listitem][1],H_RentMinutes);
	                		SendClientMessage(playerid,0x00FF00FF,Text);
						}
					else
					    {
					        SendClientMessage(playerid,0xFF6600FF,"Du hast nicht genug Geld");
					    }
	            }
			else
				{
				    SendClientMessage(playerid,0x999999FF,"Mieten abgebrochen");
				}
	    }
	if(dialogid==904)
	    {
	        new Text[256];
	        if(response)
	            {
	                if(GetPlayerMoney(playerid) >= H_Bikes[listitem][1])
	                    {
	                		H_OrderCar(playerid,H_Bikes[listitem][0],H_ChoosenColor[playerid]);
	                		GivePlayerMoney(playerid,-H_Bikes[listitem][1]);
	                		format(Text,sizeof(Text),"Du hast %s für %d$ %d Minuten lang gemietet",H_Bikes[listitem][2],H_Bikes[listitem][1],H_RentMinutes);
	                		SendClientMessage(playerid,0x00FF00FF,Text);
						}
					else
					    {
					        SendClientMessage(playerid,0xFF6600FF,"Du hast nicht genug Geld");
					    }
	            }
			else
				{
				    SendClientMessage(playerid,0x999999FF,"Mieten abgebrochen");
				}
	    }
	return 1;
}
public H_OrderCar(playerid,CarNumber,CarColor)
{
	if(H_RentedCar[playerid]==true){SendClientMessage(playerid,0xFF6600FF,"Du hast schon ein Auto gemietet");return 1;}
    if(H_CarSpawn == 1){H_PlayerCar[playerid]=CreateVehicle(CarNumber,H_CarSpawns[0][0],H_CarSpawns[0][1],H_CarSpawns[0][2],H_CarSpawns[0][3],CarColor,CarColor,-1);H_CarSpawn=2;}
    else if(H_CarSpawn == 2){H_PlayerCar[playerid]=CreateVehicle(CarNumber,H_CarSpawns[0][0],H_CarSpawns[0][1],H_CarSpawns[0][2],H_CarSpawns[0][3],CarColor,CarColor,-1);H_CarSpawn=3;}
    else if(H_CarSpawn == 3){H_PlayerCar[playerid]=CreateVehicle(CarNumber,H_CarSpawns[0][0],H_CarSpawns[0][1],H_CarSpawns[0][2],H_CarSpawns[0][3],CarColor,CarColor,-1);H_CarSpawn=4;}
    else if(H_CarSpawn == 4){H_PlayerCar[playerid]=CreateVehicle(CarNumber,H_CarSpawns[0][0],H_CarSpawns[0][1],H_CarSpawns[0][2],H_CarSpawns[0][3],CarColor,CarColor,-1);H_CarSpawn=1;}
    PutPlayerInVehicle(playerid,H_PlayerCar[playerid],0);
    H_PlayerCarID[playerid]=GetPlayerVehicleID(playerid);
	H_RentedCar[playerid]=true;
	H_RentedCars+=1;
	return 1;
}
public H_CarCountDown()
	{
		for(new i=0;i<MAX_PLAYERS;i++)
	    	{
				if(IsPlayerConnected(i) && H_RentedCar[i] != false)
				    {
				        H_PlayerCount[i] -= 1;
				        if(H_PlayerCount[i] == 1)
							{
							    SendClientMessage(i,0xFF6600FF,"Du musst dein Auto in 1 Minute abgeben");
							}
				        else if(H_PlayerCount[i] == 0)
				            {
				                new Float:H_PlayerX, Float:H_PlayerY, Float:H_PlayerZ;
				                GetPlayerPos(i,H_PlayerX,H_PlayerY,H_PlayerZ);
				                RemovePlayerFromVehicle(i);
				                SetPlayerPos(i,H_PlayerX,H_PlayerY,H_PlayerZ);
				                DestroyVehicle(H_PlayerCar[i]);
				                H_PlayerCount[i]=H_RentMinutes;
				                H_PlayerCarID[i]=999;
				                H_RentedCar[i]=false;
				                SendClientMessage(i,0xFF6600FF,"Du hast den Wagen abgegeben");
							}
					}
			}
	}
public LiveView(playerid,Nummer,CarColor)
	{
	    if(Nummer == 1)
	        {
	            new string[246];
	            PlayerShowCar[playerid]=0;
	            TogglePlayerControllable(playerid, 0);
      			SetPlayerVirtualWorld(playerid,99+playerid);
      			SetPlayerCameraPos(playerid,753.8704,-1380.7031,25.6922);
				SetPlayerCameraLookAt(playerid,750.2994,-1377.7664,25.6922);
				H_ShowCar[playerid]=CreateVehicle(H_Cars[0][0],ShowCarSpawnX,ShowCarSpawnY,ShowCarSpawnZ,ShowCarSpawnRot,CarColor,CarColor,-1);
      			SetVehicleVirtualWorld(H_ShowCar[playerid],99+playerid);
        		format(string,sizeof(string),"~r~===== Miethaus =====~n~~y~Fahrzeug: ~w~%s~n~~y~Preis: ~w~$%d/%dMin.~n~~n~~g~Numpad 4 und 6~n~Fahrzeug wechseln~n~Kaufen mit Enter~n~Tab zum Abbrechen",H_Cars[0][2],H_Cars[0][1],H_RentMinutes);
          		IsLiveViewing[playerid]=1;
				TextDrawShowForPlayer(playerid,H_CarRent[playerid]);
				TextDrawSetString(H_CarRent[playerid],string);
		    }
		else if(Nummer == 2)
		    {
	            new string[246];
	            PlayerShowCar[playerid]=0;
	            TogglePlayerControllable(playerid, 0);
      			SetPlayerVirtualWorld(playerid,99+playerid);
      			SetPlayerCameraPos(playerid,753.8704,-1380.7031,25.6922);
				SetPlayerCameraLookAt(playerid,750.2994,-1377.7664,25.6922);
				H_ShowCar[playerid]=CreateVehicle(H_SportCars[0][0],ShowCarSpawnX,ShowCarSpawnY,ShowCarSpawnZ,ShowCarSpawnRot,CarColor,CarColor,-1);
      			SetVehicleVirtualWorld(H_ShowCar[playerid],99+playerid);
        		format(string,sizeof(string),"~r~===== Miethaus =====~n~~y~Fahrzeug: ~w~%s~n~~g~Preis: ~w~$%d/%dMin.~n~~n~~g~Numpad 4 und 6~n~Fahrzeug wechseln~n~Kaufen mit Enter~n~Tab zum Abbrechen",H_SportCars[0][2],H_SportCars[0][1],H_RentMinutes);
          		IsLiveViewing[playerid]=2;
				TextDrawShowForPlayer(playerid,H_CarRent[playerid]);
				TextDrawSetString(H_CarRent[playerid],string);
		    }
		else if(Nummer == 3)
		    {
	            new string[246];
	            PlayerShowCar[playerid]=0;
	            TogglePlayerControllable(playerid, 0);
      			SetPlayerVirtualWorld(playerid,99+playerid);
      			SetPlayerCameraPos(playerid,753.8704,-1380.7031,25.6922);
				SetPlayerCameraLookAt(playerid,750.2994,-1377.7664,25.6922);
				H_ShowCar[playerid]=CreateVehicle(H_Bikes[0][0],ShowCarSpawnX,ShowCarSpawnY,ShowCarSpawnZ,ShowCarSpawnRot,CarColor,CarColor,-1);
      			SetVehicleVirtualWorld(H_ShowCar[playerid],99+playerid);
        		format(string,sizeof(string),"~r~===== Miethaus =====~n~~y~Fahrzeug: ~w~%s~n~~g~Preis: ~w~$%d/%dMin.~n~~n~~g~Numpad 4 und 6~n~Fahrzeug wechseln~n~Kaufen mit Enter~n~Tab zum Abbrechen",H_Bikes[0][2],H_Bikes[0][1],H_RentMinutes);
          		IsLiveViewing[playerid]=3;
				TextDrawShowForPlayer(playerid,H_CarRent[playerid]);
				TextDrawSetString(H_CarRent[playerid],string);
		    }
	}
public PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z)
{
    if(IsPlayerConnected(playerid))
	{
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		tempposx = (oldposx -x);
		tempposy = (oldposy -y);
		tempposz = (oldposz -z);
		if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
			return 1;
		}
	}
	return 0;
}

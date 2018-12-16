/*___|Author: Hanuman|____
 [DO NOT REMOVE THIS CREDIT]
*/

#include <a_samp>
new Text:speedo1;
new PlayerText:speedo2[MAX_PLAYERS];
new Text:Circles[4];
new Text:BigLines[14];
new Text:MPH[14];
new Text:MPHT;
new Text:SmallLines[13];
new Text:GearBox0;
new Text:GearBox1;
new Text:SpeedBox0;
new Text:SpeedBox1;
new PlayerText:Speed[MAX_PLAYERS];
new PlayerText:Gear[MAX_PLAYERS];
new PlayerText:needle[MAX_PLAYERS][9];
new PlayerText:Backneedle[MAX_PLAYERS][4];
new Text:Shade0;
new Text:Shade1;

stock RotationXY(Float:StartPosX, Float:StartPosY, &Float:NewX, &Float:NewY, Float:rotation, Float:dist)
{
	 NewX = StartPosX + (dist * floatsin(rotation, degrees));
	 NewY = StartPosY + (dist * floatcos(rotation, degrees));
}

public OnFilterScriptInit()
{
	print("\n----------------------------------------------");
	print(" Hanu Speedometer v2.0 Loaded. [Author: Hanuman]");
	print("----------------------------------------------\n");
	
	speedo1 = TextDrawCreate(430.000000, 220.000000+35.0, "_");
	TextDrawFont(speedo1, TEXT_DRAW_FONT_MODEL_PREVIEW);
	TextDrawBackgroundColor(speedo1, 0x00000000);
	TextDrawSetPreviewModel(speedo1, 19159);
	TextDrawTextSize(speedo1, 165.0, 175.0);
	TextDrawSetPreviewRot(speedo1, 90.0, 0.0, 0.0, 0.505);
	TextDrawColor(speedo1, 0x00000055);
	
    Circles[0] = TextDrawCreate(420.000000, 247.000000, "hud:radardisc");
	TextDrawFont(Circles[0], 4);
	TextDrawLetterSize(Circles[0], 0.500000, 1.000000);
	TextDrawBackgroundColor(Circles[0], 0x00000000);
	TextDrawTextSize(Circles[0], 94.0, 94.0);
	TextDrawColor(Circles[0], 0x000000FF);


	Circles[1] = TextDrawCreate(605.000000, 247.000000, "hud:radardisc");
	TextDrawFont(Circles[1], 4);
	TextDrawLetterSize(Circles[1], 0.500000, 1.000000);
	TextDrawBackgroundColor(Circles[1], 0x00000000);
	TextDrawTextSize(Circles[1], -94.0, 94.0);
	TextDrawColor(Circles[1], 0x000000FF);

	
	Circles[2] = TextDrawCreate(605.000000, 435.000000, "hud:radardisc");
	TextDrawFont(Circles[2], 4);
	TextDrawLetterSize(Circles[2], 0.500000, 1.000000);
	TextDrawBackgroundColor(Circles[2], 0x00000000);
	TextDrawTextSize(Circles[2], -94.0, -94.0);
	TextDrawColor(Circles[2], 0x000000ff);

	
	Circles[3] = TextDrawCreate(420.000000, 435.000000, "hud:radardisc");
	TextDrawFont(Circles[3], 4);
	TextDrawLetterSize(Circles[3], 0.500000, 1.000000);
	TextDrawBackgroundColor(Circles[3], 0x00000000);
	TextDrawTextSize(Circles[3], 94.0, -94.0);
	TextDrawColor(Circles[3], 0x000000ff);
	
	BigLines[0] = TextDrawCreate(448.700000, 349.200000+35.0, "_");
	TextDrawFont(BigLines[0], TEXT_DRAW_FONT_MODEL_PREVIEW);
	TextDrawBackgroundColor(BigLines[0], 0x00000000);
	TextDrawSetPreviewModel(BigLines[0], 19449);
	TextDrawTextSize(BigLines[0], 14.0, 14.0);
	TextDrawSetPreviewRot(BigLines[0], 0.0, 41.0, 90.0, 1);
	TextDrawColor(BigLines[0], 0x0C860CFF);
	TextDrawAlignment(BigLines[0], 1);

	
	BigLines[1] = TextDrawCreate(436.400000, 325.800000+35.0, "_");
	TextDrawFont(BigLines[1], TEXT_DRAW_FONT_MODEL_PREVIEW);
	TextDrawBackgroundColor(BigLines[1], 0x00000000);
	TextDrawSetPreviewModel(BigLines[1], 19449);
	TextDrawTextSize(BigLines[1], 14.0, 14.0);
	TextDrawSetPreviewRot(BigLines[1], 0.0, 20.0, 90.0, 1);
	TextDrawColor(BigLines[1], 0x0C860CFF);
	TextDrawAlignment(BigLines[1], 1);

	
	BigLines[2] = TextDrawCreate(432.500000, 299.750000+35.0, "_");
	TextDrawFont(BigLines[2], TEXT_DRAW_FONT_MODEL_PREVIEW);
	TextDrawBackgroundColor(BigLines[2], 0x00000000);
	TextDrawSetPreviewModel(BigLines[2], 19449);
	TextDrawTextSize(BigLines[2], 14.0, 14.0);
	TextDrawSetPreviewRot(BigLines[2], 0.0, 0.0, 90.0, 1);
	TextDrawColor(BigLines[2], 0x0C860CFF);
	TextDrawAlignment(BigLines[2], 1);

	
	BigLines[3] = TextDrawCreate(437.000000, 273.800000+35.0, "_");
	TextDrawFont(BigLines[3], TEXT_DRAW_FONT_MODEL_PREVIEW);
	TextDrawBackgroundColor(BigLines[3], 0x00000000);
	TextDrawSetPreviewModel(BigLines[3], 19449);
	TextDrawTextSize(BigLines[3], 14.0, 14.0);
	TextDrawSetPreviewRot(BigLines[3], 0.0, -21.0, 90.0, 1);
	TextDrawColor(BigLines[3], 0x0C860CFF);
	TextDrawAlignment(BigLines[3], 1);

	
	BigLines[4] = TextDrawCreate(450.200000, 250.200000+35.0, "_");
	TextDrawFont(BigLines[4], TEXT_DRAW_FONT_MODEL_PREVIEW);
	TextDrawBackgroundColor(BigLines[4], 0x00000000);
	TextDrawSetPreviewModel(BigLines[4], 19449);
	TextDrawTextSize(BigLines[4], 14.0, 14.0);
	TextDrawSetPreviewRot(BigLines[4], 0.0, -42.0, 90.0, 1);
	TextDrawColor(BigLines[4], 0x0C860CFF);
	TextDrawAlignment(BigLines[4], 1);

	
	BigLines[5] = TextDrawCreate(470.900000, 232.400000+35.0, "_");
	TextDrawFont(BigLines[5], TEXT_DRAW_FONT_MODEL_PREVIEW);
	TextDrawBackgroundColor(BigLines[5], 0x00000000);
	TextDrawSetPreviewModel(BigLines[5], 19449);
	TextDrawTextSize(BigLines[5], 14.0, 14.0);
	TextDrawSetPreviewRot(BigLines[5], 0.0, -63.0, 90.0, 1);
	TextDrawColor(BigLines[5], 0xBDBD00FF);
	TextDrawAlignment(BigLines[5], 1);

	
	BigLines[6] = TextDrawCreate(496.900000, 223.700000+35.0, "_");
	TextDrawFont(BigLines[6], TEXT_DRAW_FONT_MODEL_PREVIEW);
	TextDrawBackgroundColor(BigLines[6], 0x00000000);
	TextDrawSetPreviewModel(BigLines[6], 19449);
	TextDrawTextSize(BigLines[6], 14.0, 14.0);
	TextDrawSetPreviewRot(BigLines[6], 0.0, -84.0, 90.0, 1);
	TextDrawColor(BigLines[6], 0xBDBD00FF);
	TextDrawAlignment(BigLines[6], 1);

	
	BigLines[7] = TextDrawCreate(525.000000, 225.500000+35.0, "_");
	TextDrawFont(BigLines[7], TEXT_DRAW_FONT_MODEL_PREVIEW);
	TextDrawBackgroundColor(BigLines[7], 0x00000000);
	TextDrawSetPreviewModel(BigLines[7], 19449);
	TextDrawTextSize(BigLines[7], 14.0, 14.0);
	TextDrawSetPreviewRot(BigLines[7], 0.0, -105.0, 90.0, 1);
	TextDrawColor(BigLines[7], 0xBDBD00FF);
	TextDrawAlignment(BigLines[7], 1);

	
	BigLines[8] = TextDrawCreate(549.300000, 238.800000+35.0, "_");
	TextDrawFont(BigLines[8], TEXT_DRAW_FONT_MODEL_PREVIEW);
	TextDrawBackgroundColor(BigLines[8], 0x00000000);
	TextDrawSetPreviewModel(BigLines[8], 19449);
	TextDrawTextSize(BigLines[8], 14.0, 14.0);
	TextDrawSetPreviewRot(BigLines[8], 0.0, -126.0, 90.0, 1);
	TextDrawColor(BigLines[8], 0xBDBD00FF);
	TextDrawAlignment(BigLines[8], 1);

	
	BigLines[9] = TextDrawCreate(567.000000, 259.000000+35.0, "_");
	TextDrawFont(BigLines[9], TEXT_DRAW_FONT_MODEL_PREVIEW);
	TextDrawBackgroundColor(BigLines[9], 0x00000000);
	TextDrawSetPreviewModel(BigLines[9], 19449);
	TextDrawTextSize(BigLines[9], 14.0, 14.0);
	TextDrawSetPreviewRot(BigLines[9], 0.0, -147.0, 90.0, 1);
	TextDrawColor(BigLines[9], 0xBDBD00FF);
	TextDrawAlignment(BigLines[9], 1);

	
	BigLines[10] = TextDrawCreate(576.700000, 283.600000+35.0, "_");
	TextDrawFont(BigLines[10], TEXT_DRAW_FONT_MODEL_PREVIEW);
	TextDrawBackgroundColor(BigLines[10], 0x00000000);
	TextDrawSetPreviewModel(BigLines[10], 19449);
	TextDrawTextSize(BigLines[10], 14.0, 14.0);
	TextDrawSetPreviewRot(BigLines[10], 0.0, -168.0, 90.0, 1);
	TextDrawColor(BigLines[10], 0xA00000FF);
	TextDrawAlignment(BigLines[10], 1);

	
	BigLines[11] = TextDrawCreate(577.200000, 310.200000+35.0, "_");
	TextDrawFont(BigLines[11], TEXT_DRAW_FONT_MODEL_PREVIEW);
	TextDrawBackgroundColor(BigLines[11], 0x00000000);
	TextDrawSetPreviewModel(BigLines[11], 19449);
	TextDrawTextSize(BigLines[11], 14.0, 14.0);
	TextDrawSetPreviewRot(BigLines[11], 0.0, -189.0, 90.0, 1);
	TextDrawColor(BigLines[11], 0xA00000FF);
	TextDrawAlignment(BigLines[11], 1);

	
	BigLines[12] = TextDrawCreate(570.500000, 335.700000+35.0, "_");
	TextDrawFont(BigLines[12], TEXT_DRAW_FONT_MODEL_PREVIEW);
	TextDrawBackgroundColor(BigLines[12], 0x00000000);
	TextDrawSetPreviewModel(BigLines[12], 19449);
	TextDrawTextSize(BigLines[12], 14.0, 14.0);
	TextDrawSetPreviewRot(BigLines[12], 0.0, -210.0, 90.0, 1);
	TextDrawColor(BigLines[12], 0xA00000FF);
	TextDrawAlignment(BigLines[12], 1);

	
	BigLines[13] = TextDrawCreate(554.500000, 357.200000+35.0, "_");
	TextDrawFont(BigLines[13], TEXT_DRAW_FONT_MODEL_PREVIEW);
	TextDrawBackgroundColor(BigLines[13], 0x00000000);
	TextDrawSetPreviewModel(BigLines[13], 19449);
	TextDrawTextSize(BigLines[13], 14.0, 14.0);
	TextDrawSetPreviewRot(BigLines[13], 0.0, -231.0, 90.0, 1);
	TextDrawColor(BigLines[13], 0xA00000FF);
	TextDrawAlignment(BigLines[13], 1);
	
	MPH[0] = TextDrawCreate(458.500000, 338.700000+35.0, "0");
	TextDrawFont(MPH[0], 2);
	TextDrawBackgroundColor(MPH[0], 0x00000000);
	TextDrawTextSize(MPH[0], 14.0, 14.0);
	TextDrawColor(MPH[0], 0x80ff02FF);
	TextDrawLetterSize(MPH[0], 0.33, 1.60);
	
	MPH[1] = TextDrawCreate(450.700000, 320.200000+35.0, "20");
	TextDrawFont(MPH[1], 2);
	TextDrawBackgroundColor(MPH[1], 0x00000000);
	TextDrawTextSize(MPH[1], 14.0, 14.0);
	TextDrawColor(MPH[1], 0x80ff02FF);
	TextDrawLetterSize(MPH[1], 0.33, 1.60);

	
	MPH[2] = TextDrawCreate(447.000000, 298.800000+35.0, "40");
	TextDrawFont(MPH[2], 2);
	TextDrawBackgroundColor(MPH[2], 0x00000000);
	TextDrawTextSize(MPH[2], 14.0, 14.0);
	TextDrawColor(MPH[2], 0x80ff02FF);
	TextDrawLetterSize(MPH[2], 0.33, 1.60);

	
	MPH[3] = TextDrawCreate(450.000000, 276.800000+35.0, "60");
	TextDrawFont(MPH[3], 2);
	TextDrawBackgroundColor(MPH[3], 0x00000000);
	TextDrawTextSize(MPH[3], 14.0, 14.0);
	TextDrawColor(MPH[3], 0x80ff02FF);
	TextDrawLetterSize(MPH[3], 0.33, 1.60);

	
	MPH[4] = TextDrawCreate(461.400000, 258.000000+35.0, "80");
	TextDrawFont(MPH[4], 2);
	TextDrawBackgroundColor(MPH[4], 0x00000000);
	TextDrawTextSize(MPH[4], 14.0, 14.0);
	TextDrawColor(MPH[4], 0x80ff02FF);
	TextDrawLetterSize(MPH[4], 0.27, 1.60);

	MPH[5] = TextDrawCreate(475.400000, 243.900000+35.0, "100");
	TextDrawFont(MPH[5], 2);
	TextDrawBackgroundColor(MPH[5], 0x00000000);
	TextDrawTextSize(MPH[5], 14.0, 14.0);
	TextDrawColor(MPH[5], 0xFBFB00FF);
	TextDrawLetterSize(MPH[5], 0.27, 1.60);

	MPH[6] = TextDrawCreate(497.400000, 235.000000+35.0, "120");
	TextDrawFont(MPH[6], 2);
	TextDrawBackgroundColor(MPH[6], 0x00000000);
	TextDrawTextSize(MPH[6], 14.0, 14.0);
	TextDrawColor(MPH[6], 0xFBFB00FF);
	TextDrawLetterSize(MPH[6], 0.27, 1.60);

	MPH[7] = TextDrawCreate(521.400000, 237.000000+35.0, "140");
	TextDrawFont(MPH[7], 2);
	TextDrawBackgroundColor(MPH[7], 0x00000000);
	TextDrawTextSize(MPH[7], 14.0, 14.0);
	TextDrawColor(MPH[7], 0xFBFB00FF);
	TextDrawLetterSize(MPH[7], 0.27, 1.60);

	MPH[8] = TextDrawCreate(540.000000, 250.000000+35.0, "160");
	TextDrawFont(MPH[8], 2);
	TextDrawBackgroundColor(MPH[8], 0x00000000);
	TextDrawTextSize(MPH[8], 14.0, 14.0);
	TextDrawColor(MPH[8], 0xFBFB00FF);
	TextDrawLetterSize(MPH[8], 0.27, 1.60);

	MPH[9] = TextDrawCreate(551.000000, 266.000000+35.0, "180");
	TextDrawFont(MPH[9], 2);
	TextDrawBackgroundColor(MPH[9], 0x00000000);
	TextDrawTextSize(MPH[9], 14.0, 14.0);
	TextDrawColor(MPH[9], 0xFBFB00FF);
	TextDrawLetterSize(MPH[9], 0.27, 1.60);

	MPH[10] = TextDrawCreate(558.300000, 284.700000+35.0, "200");
	TextDrawFont(MPH[10], 2);
	TextDrawBackgroundColor(MPH[10], 0x00000000);
	TextDrawTextSize(MPH[10], 14.0, 14.0);
	TextDrawColor(MPH[10], 0xE50000FF);
	TextDrawLetterSize(MPH[10], 0.27, 1.60);

	MPH[11] = TextDrawCreate(556.500000, 307.000000+35.0, "220");
	TextDrawFont(MPH[11], 2);
	TextDrawBackgroundColor(MPH[11], 0x00000000);
	TextDrawTextSize(MPH[11], 14.0, 14.0);
	TextDrawColor(MPH[11], 0xE50000FF);
	TextDrawLetterSize(MPH[11], 0.27, 1.60);

	MPH[12] = TextDrawCreate(551.800000, 327.000000+35.0, "240");
	TextDrawFont(MPH[12], 2);
	TextDrawBackgroundColor(MPH[12], 0x00000000);
	TextDrawTextSize(MPH[12], 14.0, 14.0);
	TextDrawColor(MPH[12], 0xE50000FF);
	TextDrawLetterSize(MPH[12], 0.27, 1.60);

	MPH[13] = TextDrawCreate(545.800000, 345.000000+35.0, "260");
	TextDrawFont(MPH[13], 2);
	TextDrawBackgroundColor(MPH[13], 0x00000000);
	TextDrawTextSize(MPH[13], 14.0, 14.0);
	TextDrawColor(MPH[13], 0xE50000FF);
	TextDrawLetterSize(MPH[13], 0.27, 1.60);

	MPHT = TextDrawCreate(500.00000, 359.500000+35.0, "Km/h");
	TextDrawFont(MPHT, 2);
	TextDrawBackgroundColor(MPHT, 0x00000000);
	TextDrawTextSize(MPHT, 14.0, 14.0);
	TextDrawColor(MPHT, 0x80ff02FF);
	TextDrawLetterSize(MPHT, 0.29, 1.60);
	
	SmallLines[0] = TextDrawCreate(440.400000, 339.000000+35.0, "_");
	TextDrawFont(SmallLines[0], TEXT_DRAW_FONT_MODEL_PREVIEW);
	TextDrawBackgroundColor(SmallLines[0], 0x00000000);
	TextDrawSetPreviewModel(SmallLines[0], 19449);
	TextDrawTextSize(SmallLines[0], 14.0, 14.0);
	TextDrawSetPreviewRot(SmallLines[0], 0.0, 30.5, 90.0, 1.5);
	TextDrawColor(SmallLines[0], 0x0C860CFF);
	TextDrawAlignment(SmallLines[0], 1);

	
	SmallLines[1] = TextDrawCreate(431.600000, 313.500000+35.0, "_");
	TextDrawFont(SmallLines[1], TEXT_DRAW_FONT_MODEL_PREVIEW);
	TextDrawBackgroundColor(SmallLines[1], 0x00000000);
	TextDrawSetPreviewModel(SmallLines[1], 19449);
	TextDrawTextSize(SmallLines[1], 14.0, 14.0);
	TextDrawSetPreviewRot(SmallLines[1], 0.0, 10.0, 90.0, 1.5);
	TextDrawColor(SmallLines[1], 0x0C860CFF);
	TextDrawAlignment(SmallLines[1], 1);

	SmallLines[2] = TextDrawCreate(431.700000, 286.500000+35.0, "_");
	TextDrawFont(SmallLines[2], TEXT_DRAW_FONT_MODEL_PREVIEW);
	TextDrawBackgroundColor(SmallLines[2], 0x00000000);
	TextDrawSetPreviewModel(SmallLines[2], 19449);
	TextDrawTextSize(SmallLines[2], 14.0, 14.0);
	TextDrawSetPreviewRot(SmallLines[2], 0.0, -11.0, 90.0, 1.5);
	TextDrawColor(SmallLines[2], 0x0C860CFF);
	TextDrawAlignment(SmallLines[2], 1);

	
	SmallLines[3] = TextDrawCreate(440.800000, 261.100000+35.0, "_");
	TextDrawFont(SmallLines[3], TEXT_DRAW_FONT_MODEL_PREVIEW);
	TextDrawBackgroundColor(SmallLines[3], 0x00000000);
	TextDrawSetPreviewModel(SmallLines[3], 19449);
	TextDrawTextSize(SmallLines[3], 14.0, 14.0);
	TextDrawSetPreviewRot(SmallLines[3], 0.0, -32.0, 90.0, 1.5);
	TextDrawColor(SmallLines[3], 0x0C860CFF);
	TextDrawAlignment(SmallLines[3], 1);

	
	SmallLines[4] = TextDrawCreate(458.700000, 239.000000+35.0, "_");
	TextDrawFont(SmallLines[4], TEXT_DRAW_FONT_MODEL_PREVIEW);
	TextDrawBackgroundColor(SmallLines[4], 0x00000000);
	TextDrawSetPreviewModel(SmallLines[4], 19449);
	TextDrawTextSize(SmallLines[4], 14.0, 14.0);
	TextDrawSetPreviewRot(SmallLines[4], 0.0, -53.0, 90.0, 1.5);
	TextDrawColor(SmallLines[4], 0x0C860CFF);
	TextDrawAlignment(SmallLines[4], 1);

	
	SmallLines[5] = TextDrawCreate(482.700000, 224.700000+35.0, "_");
	TextDrawFont(SmallLines[5], TEXT_DRAW_FONT_MODEL_PREVIEW);
	TextDrawBackgroundColor(SmallLines[5], 0x00000000);
	TextDrawSetPreviewModel(SmallLines[5], 19449);
	TextDrawTextSize(SmallLines[5], 14.0, 14.0);
	TextDrawSetPreviewRot(SmallLines[5], 0.0, -74.0, 90.0, 1.5);
	TextDrawColor(SmallLines[5], 0xBDBD00FF);
	TextDrawAlignment(SmallLines[5], 1);

	
	SmallLines[6] = TextDrawCreate(511.000000, 221.300000+35.0, "_");
	TextDrawFont(SmallLines[6], TEXT_DRAW_FONT_MODEL_PREVIEW);
	TextDrawBackgroundColor(SmallLines[6], 0x00000000);
	TextDrawSetPreviewModel(SmallLines[6], 19449);
	TextDrawTextSize(SmallLines[6], 14.0, 14.0);
	TextDrawSetPreviewRot(SmallLines[6], 0.0, -95.0, 90.0, 1.5);
	TextDrawColor(SmallLines[6], 0xBDBD00FF);
	TextDrawAlignment(SmallLines[6], 1);

	
	SmallLines[7] = TextDrawCreate(538.500000, 229.200000+35.0, "_");
	TextDrawFont(SmallLines[7], TEXT_DRAW_FONT_MODEL_PREVIEW);
	TextDrawBackgroundColor(SmallLines[7], 0x00000000);
	TextDrawSetPreviewModel(SmallLines[7], 19449);
	TextDrawTextSize(SmallLines[7], 14.0, 14.0);
	TextDrawSetPreviewRot(SmallLines[7], 0.0, -116.0, 90.0, 1.5);
	TextDrawColor(SmallLines[7], 0xBDBD00FF);
	TextDrawAlignment(SmallLines[7], 1);

	
	SmallLines[8] = TextDrawCreate(560.500000, 246.700000+35.0, "_");
	TextDrawFont(SmallLines[8], TEXT_DRAW_FONT_MODEL_PREVIEW);
	TextDrawBackgroundColor(SmallLines[8], 0x00000000);
	TextDrawSetPreviewModel(SmallLines[8], 19449);
	TextDrawTextSize(SmallLines[8], 14.0, 14.0);
	TextDrawSetPreviewRot(SmallLines[8], 0.0, -137.0, 90.0, 1.5);
	TextDrawColor(SmallLines[8], 0xBDBD00FF);
	TextDrawAlignment(SmallLines[8], 1);

	
	SmallLines[9] = TextDrawCreate(575.000000, 270.200000+35.0, "_");
	TextDrawFont(SmallLines[9], TEXT_DRAW_FONT_MODEL_PREVIEW);
	TextDrawBackgroundColor(SmallLines[9], 0x00000000);
	TextDrawSetPreviewModel(SmallLines[9], 19449);
	TextDrawTextSize(SmallLines[9], 14.0, 14.0);
	TextDrawSetPreviewRot(SmallLines[9], 0.0, -158.0, 90.0, 1.5);
	TextDrawColor(SmallLines[9], 0xBDBD00FF);
	TextDrawAlignment(SmallLines[9], 1);

	
	SmallLines[10] = TextDrawCreate(580.000000, 296.700000+35.0, "_");
	TextDrawFont(SmallLines[10], TEXT_DRAW_FONT_MODEL_PREVIEW);
	TextDrawBackgroundColor(SmallLines[10], 0x00000000);
	TextDrawSetPreviewModel(SmallLines[10], 19449);
	TextDrawTextSize(SmallLines[10], 14.0, 14.0);
	TextDrawSetPreviewRot(SmallLines[10], 0.0, -179.0, 90.0, 1.5);
	TextDrawColor(SmallLines[10], 0xA00000FF);
	TextDrawAlignment(SmallLines[10], 1);

	
	SmallLines[11] = TextDrawCreate(576.800000, 323.500000+35.0, "_");
	TextDrawFont(SmallLines[11], TEXT_DRAW_FONT_MODEL_PREVIEW);
	TextDrawBackgroundColor(SmallLines[11], 0x00000000);
	TextDrawSetPreviewModel(SmallLines[11], 19449);
	TextDrawTextSize(SmallLines[11], 14.0, 14.0);
	TextDrawSetPreviewRot(SmallLines[11], 0.0, -200.0, 90.0, 1.5);
	TextDrawColor(SmallLines[11], 0xA00000FF);
	TextDrawAlignment(SmallLines[11], 1);

	
	SmallLines[12] = TextDrawCreate(565.000000, 348.000000+35.0, "_");
	TextDrawFont(SmallLines[12], TEXT_DRAW_FONT_MODEL_PREVIEW);
	TextDrawBackgroundColor(SmallLines[12], 0x00000000);
	TextDrawSetPreviewModel(SmallLines[12], 19449);
	TextDrawTextSize(SmallLines[12], 14.0, 14.0);
	TextDrawSetPreviewRot(SmallLines[12], 0.0, -221.0, 90.0, 1.5);
	TextDrawColor(SmallLines[12], 0xA00000FF);
	TextDrawAlignment(SmallLines[12], 1);
	
	GearBox0 = TextDrawCreate(484.000000, 366.000000, "_");
	TextDrawBackgroundColor(GearBox0, 255);
	TextDrawFont(GearBox0, 1);
	TextDrawLetterSize(GearBox0, 0.479999, 2.400000);
	TextDrawColor(GearBox0, -1);
	TextDrawSetOutline(GearBox0, 0);
	TextDrawSetProportional(GearBox0, 1);
	TextDrawSetShadow(GearBox0, 1);
	TextDrawUseBox(GearBox0, 1);
	TextDrawBoxColor(GearBox0, -1886416897);
	TextDrawTextSize(GearBox0, 541.000000, 0.000000);
	TextDrawSetSelectable(GearBox0, 0);

	GearBox1 = TextDrawCreate(485.000000, 368.000000, "_");
	TextDrawBackgroundColor(GearBox1, 255);
	TextDrawFont(GearBox1, 1);
	TextDrawLetterSize(GearBox1, 0.500000, 1.999999);
	TextDrawColor(GearBox1, -1);
	TextDrawSetOutline(GearBox1, 0);
	TextDrawSetProportional(GearBox1, 1);
	TextDrawSetShadow(GearBox1, 1);
	TextDrawUseBox(GearBox1, 1);
	TextDrawBoxColor(GearBox1, 1364283903);
	TextDrawTextSize(GearBox1, 539.000000, 0.000000);
	TextDrawSetSelectable(GearBox1, 0);

	

	SpeedBox0 = TextDrawCreate(501.000000, 312.000000, "_");
	TextDrawBackgroundColor(SpeedBox0, 255);
	TextDrawFont(SpeedBox0, 1);
	TextDrawLetterSize(SpeedBox0, 0.500000, 1.200000);
	TextDrawColor(SpeedBox0, -1);
	TextDrawSetOutline(SpeedBox0, 0);
	TextDrawSetProportional(SpeedBox0, 1);
	TextDrawSetShadow(SpeedBox0, 1);
	TextDrawUseBox(SpeedBox0, 1);
	TextDrawBoxColor(SpeedBox0, -1886416897);
	TextDrawTextSize(SpeedBox0, 524.000000, 0.000000);
	TextDrawSetSelectable(SpeedBox0, 0);

	SpeedBox1 = TextDrawCreate(502.000000, 313.000000, "_");
	TextDrawBackgroundColor(SpeedBox1, 255);
	TextDrawFont(SpeedBox1, 1);
	TextDrawLetterSize(SpeedBox1, 0.500000, 1.000000);
	TextDrawColor(SpeedBox1, -1);
	TextDrawSetOutline(SpeedBox1, 0);
	TextDrawSetProportional(SpeedBox1, 1);
	TextDrawSetShadow(SpeedBox1, 1);
	TextDrawUseBox(SpeedBox1, 1);
	TextDrawBoxColor(SpeedBox1, 1364283903);
	TextDrawTextSize(SpeedBox1, 522.000000, 0.000000);
	TextDrawSetSelectable(SpeedBox1, 0);
	
	Shade0 = TextDrawCreate(485.000000, 368.000000, "_");
	TextDrawBackgroundColor(Shade0, 255);
	TextDrawFont(Shade0, 1);
	TextDrawLetterSize(Shade0, 0.500000, 0.099999);
	TextDrawColor(Shade0, -1);
	TextDrawSetOutline(Shade0, 0);
	TextDrawSetProportional(Shade0, 1);
	TextDrawSetShadow(Shade0, 1);
	TextDrawUseBox(Shade0, 1);
	TextDrawBoxColor(Shade0, 102);
	TextDrawTextSize(Shade0, 539.000000, 0.000000);
	TextDrawSetSelectable(Shade0, 0);

	Shade1 = TextDrawCreate(502.000000, 313.000000, "_");
	TextDrawBackgroundColor(Shade1, 255);
	TextDrawFont(Shade1, 1);
	TextDrawLetterSize(Shade1, 0.460000, 0.000000);
	TextDrawColor(Shade1, -1);
	TextDrawSetOutline(Shade1, 0);
	TextDrawSetProportional(Shade1, 1);
	TextDrawSetShadow(Shade1, 1);
	TextDrawUseBox(Shade1, 1);
	TextDrawBoxColor(Shade1, 102);
	TextDrawTextSize(Shade1, 522.000000, 0.000000);
	TextDrawSetSelectable(Shade1, 0);

	


	return 1;
}

public OnFilterScriptExit()
{
    
	TextDrawDestroy(speedo1);
	TextDrawDestroy(Circles[0]);
	TextDrawDestroy(Circles[1]);
	TextDrawDestroy(Circles[2]);
	TextDrawDestroy(Circles[3]);
	for(new i=0; i<14; i++)
	{
       TextDrawDestroy(BigLines[i]);
    }
    for(new i=0; i<14; i++)
	{
       TextDrawDestroy(MPH[i]);
    }
    
	TextDrawDestroy(MPHT);
	for(new i=0; i<13; i++)
	{
       TextDrawDestroy(SmallLines[i]);
    }
    TextDrawDestroy(GearBox0);
    TextDrawDestroy(GearBox1);
    TextDrawDestroy(SpeedBox0);
    TextDrawDestroy(SpeedBox1);
    TextDrawDestroy(Shade1);
    TextDrawDestroy(Shade0);
	return 1;
}


stock GetVehicleSpeed(playerid)
{
	new Float:p[3];
	new Float:final_speed,final_speed_int;
	GetVehicleVelocity(GetPlayerVehicleID(playerid),p[0],p[1],p[2]);
	final_speed = floatsqroot(((p[0]*p[0])+(p[1]*p[1]))+(p[2]*p[2]))*181.1166672; // 250.666667 = kmph  // 199,4166672= mph
	final_speed_int = floatround(final_speed,floatround_round);
	if(IsVehicleDrivingBackwards(playerid))
	{
       final_speed_int=0;
    }
    return final_speed_int;
}
public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	return 1;
}

public OnPlayerConnect(playerid)
{
    Speed[playerid] = CreatePlayerTextDraw(playerid,542.000000, 365.000000, "999");
	PlayerTextDrawAlignment(playerid,Speed[playerid], 3);
	PlayerTextDrawBackgroundColor(playerid,Speed[playerid], -1);
	PlayerTextDrawFont(playerid,Speed[playerid], 3);
	PlayerTextDrawLetterSize(playerid,Speed[playerid], 0.949998, 2.400000);
	PlayerTextDrawColor(playerid,Speed[playerid], 255);
	PlayerTextDrawSetOutline(playerid,Speed[playerid], 0);
	PlayerTextDrawSetProportional(playerid,Speed[playerid], 0);
	PlayerTextDrawSetShadow(playerid,Speed[playerid], 0);
	PlayerTextDrawSetSelectable(playerid,Speed[playerid], 0);
	
	Gear[playerid] = CreatePlayerTextDraw(playerid,510.000000, 308.000000, "N");
	PlayerTextDrawBackgroundColor(playerid,Gear[playerid], 255);
	PlayerTextDrawFont(playerid,Gear[playerid], 2);
	PlayerTextDrawLetterSize(playerid,Gear[playerid], 0.500000, 1.800000);
	PlayerTextDrawColor(playerid,Gear[playerid], 85);
	PlayerTextDrawSetOutline(playerid,Gear[playerid], 0);
	PlayerTextDrawSetProportional(playerid,Gear[playerid], 1);
	PlayerTextDrawSetShadow(playerid,Gear[playerid], 1);
	PlayerTextDrawSetSelectable(playerid,Gear[playerid], 0);
	
	
	new Float:rotation = 309;
	for(new q = 8; q >= 0; q--)
	{
		new Float:Pos[9][2];
  		RotationXY(508.6, 325+35.0, Pos[q][0], Pos[q][1], rotation, (q + 1) * 8);
  		needle[playerid][q] = CreatePlayerTextDraw(playerid, Pos[q][0], Pos[q][1], ".");
  		PlayerTextDrawColor(playerid, needle[playerid][q], 0xb00000FF);
        PlayerTextDrawLetterSize(playerid, needle[playerid][q], 0.73, -2.60);
		PlayerTextDrawSetOutline(playerid, needle[playerid][q], 0);
		PlayerTextDrawBackgroundColor(playerid, needle[playerid][q], 0xa00000FF);
		PlayerTextDrawSetOutline(playerid, needle[playerid][q], 1);

	}
	new Float:alpha2 = rotation - 180;
	for(new x; x < 4; x++)
	{
		new Float:Pos1[4][2];
  		RotationXY(508.6, 325+35.0, Pos1[x][0], Pos1[x][1], alpha2, (x + 1) * 5);
  		Backneedle[playerid][x] = CreatePlayerTextDraw(playerid, Pos1[x][0], Pos1[x][1], "~l~.");
		PlayerTextDrawBackgroundColor(playerid, Backneedle[playerid][x], 0x000000FF);
		PlayerTextDrawLetterSize(playerid, Backneedle[playerid][x], 0.73, -2.60);
		PlayerTextDrawColor(playerid, Backneedle[playerid][x], 0x000000FF);
		PlayerTextDrawSetOutline(playerid, Backneedle[playerid][x], 1);

	}
	speedo2[playerid] = CreatePlayerTextDraw(playerid, 430.000000, 220.000000+35.0, "_");
	PlayerTextDrawFont(playerid, speedo2[playerid], TEXT_DRAW_FONT_MODEL_PREVIEW);
	PlayerTextDrawBackgroundColor(playerid, speedo2[playerid], 0x00000000);
	PlayerTextDrawSetPreviewModel(playerid, speedo2[playerid], 19159);
	PlayerTextDrawTextSize(playerid, speedo2[playerid], 165.0, 175.0);
	PlayerTextDrawSetPreviewRot(playerid, speedo2[playerid], 90.0, 0.0, 0.0, 4.2);
	PlayerTextDrawColor(playerid, speedo2[playerid], 0x000000FF);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    PlayerTextDrawDestroy(playerid, speedo2[playerid]);
    for(new i=0; i<4; i++)
	{
       PlayerTextDrawDestroy(playerid, Backneedle[playerid][i]);
    }
    PlayerTextDrawDestroy(playerid, Speed[playerid]);
    for(new i=0; i<9; i++)
	{
       PlayerTextDrawDestroy(playerid, needle[playerid][i]);
    }
    PlayerTextDrawDestroy(playerid, Gear[playerid]);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if(IsPlayerInAnyVehicle(playerid))
	{
		PlayerTextDrawHide(playerid, speedo2[playerid]);
		TextDrawHideForPlayer(playerid, speedo1);
		TextDrawHideForPlayer(playerid, Circles[0]);
		TextDrawHideForPlayer(playerid, Circles[1]);
		TextDrawHideForPlayer(playerid, Circles[2]);
		TextDrawHideForPlayer(playerid, Circles[3]);
		for(new i=0; i<14; i++)
		{
		TextDrawHideForPlayer(playerid, BigLines[i]);
		}
		for(new i=0; i<14; i++)
		{
		TextDrawHideForPlayer(playerid, MPH[i]);
		}
		for(new i=0; i<4; i++)
		{
		PlayerTextDrawHide(playerid, Backneedle[playerid][i]);
		}
		TextDrawHideForPlayer(playerid, MPHT);
		for(new i=0; i<13; i++)
		{
		TextDrawHideForPlayer(playerid, SmallLines[i]);
		}
		TextDrawHideForPlayer(playerid, GearBox0);
		TextDrawHideForPlayer(playerid, GearBox1);
		TextDrawHideForPlayer(playerid, SpeedBox0);
		TextDrawHideForPlayer(playerid, SpeedBox1);
		PlayerTextDrawHide(playerid, Speed[playerid]);
		for(new i=0; i<9; i++)
		{
		PlayerTextDrawHide(playerid, needle[playerid][i]);
		}
		PlayerTextDrawHide(playerid, Gear[playerid]);
		TextDrawHideForPlayer(playerid, Shade1);
		TextDrawHideForPlayer(playerid, Shade0);
    }
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER || GetPlayerState(playerid) == PLAYER_STATE_PASSENGER)
 	{
		PlayerTextDrawShow(playerid, speedo2[playerid]);
		TextDrawShowForPlayer(playerid, speedo1);
		TextDrawShowForPlayer(playerid, Circles[0]);
		TextDrawShowForPlayer(playerid, Circles[1]);
		TextDrawShowForPlayer(playerid, Circles[2]);
		TextDrawShowForPlayer(playerid, Circles[3]);
		for(new i=0; i<14; i++)
		{
	       TextDrawShowForPlayer(playerid, BigLines[i]);
	    }
        for(new i=0; i<14; i++)
		{
	       TextDrawShowForPlayer(playerid, MPH[i]);
	    }
		TextDrawShowForPlayer(playerid, MPHT);
		for(new i=0; i<13; i++)
		{
	       TextDrawShowForPlayer(playerid, SmallLines[i]);
	    }
	    TextDrawShowForPlayer(playerid, GearBox0);
	    TextDrawShowForPlayer(playerid, GearBox1);
	    TextDrawShowForPlayer(playerid, SpeedBox0);
	    TextDrawShowForPlayer(playerid, SpeedBox1);
	    PlayerTextDrawShow(playerid, Speed[playerid]);
	    PlayerTextDrawShow(playerid, Gear[playerid]);
	    TextDrawShowForPlayer(playerid, Shade1);
	    for(new i=0; i<9; i++)
		{
	       PlayerTextDrawShow(playerid, needle[playerid][i]);
	    }
	    for(new i=0; i<4; i++)
		{
	       PlayerTextDrawShow(playerid, Backneedle[playerid][i]);
	    }
	    TextDrawShowForPlayer(playerid, Shade0);
	}
	if(oldstate == PLAYER_STATE_DRIVER || oldstate == PLAYER_STATE_PASSENGER)
	{
		PlayerTextDrawHide(playerid, speedo2[playerid]);
		TextDrawHideForPlayer(playerid, speedo1);
		TextDrawHideForPlayer(playerid, Circles[0]);
		TextDrawHideForPlayer(playerid, Circles[1]);
		TextDrawHideForPlayer(playerid, Circles[2]);
		TextDrawHideForPlayer(playerid, Circles[3]);
		for(new i=0; i<14; i++)
		{
	       TextDrawHideForPlayer(playerid, BigLines[i]);
	    }
        for(new i=0; i<14; i++)
		{
	       TextDrawHideForPlayer(playerid, MPH[i]);
	    }
	    for(new i=0; i<4; i++)
		{
	       PlayerTextDrawHide(playerid, Backneedle[playerid][i]);
	    }
		TextDrawHideForPlayer(playerid, MPHT);
		for(new i=0; i<13; i++)
		{
	       TextDrawHideForPlayer(playerid, SmallLines[i]);
	    }
	    TextDrawHideForPlayer(playerid, GearBox0);
	    TextDrawHideForPlayer(playerid, GearBox1);
	    TextDrawHideForPlayer(playerid, SpeedBox0);
	    TextDrawHideForPlayer(playerid, SpeedBox1);
	    PlayerTextDrawHide(playerid, Speed[playerid]);
	    for(new i=0; i<9; i++)
		{
	       PlayerTextDrawHide(playerid, needle[playerid][i]);
	    }
	    PlayerTextDrawHide(playerid, Gear[playerid]);
	    TextDrawHideForPlayer(playerid, Shade1);
	    TextDrawHideForPlayer(playerid, Shade0);
	}
	return 1;
}

public OnPlayerUpdate(playerid)
{
    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER || GetPlayerState(playerid) == PLAYER_STATE_PASSENGER)
 	{
	    if(GetPlayerVehicleSeat(playerid) == 0 || GetPlayerVehicleSeat(playerid) == 1)
	    {
		    new Float:Pos[9][2];
		    new Float:alpha = 309 - GetVehicleSpeed(playerid);
		    if(alpha < 60) alpha = 60;

			for(new i; i < 9; i++)
			{
			    PlayerTextDrawHide(playerid, needle[playerid][i]);
			    PlayerTextDrawDestroy(playerid,needle[playerid][i]);
		  		RotationXY(508.6, 325+35.0, Pos[i][0], Pos[i][1], alpha, (i + 1) * 8);
		  		needle[playerid][i] = CreatePlayerTextDraw(playerid, Pos[i][0], Pos[i][1], ".");
		  		PlayerTextDrawColor(playerid, needle[playerid][i], 0xb00000FF);
		        PlayerTextDrawLetterSize(playerid, needle[playerid][i], 0.73, -2.60);
				PlayerTextDrawSetOutline(playerid, needle[playerid][i], 0);
				PlayerTextDrawBackgroundColor(playerid, needle[playerid][i], 0xa00000FF);
				PlayerTextDrawSetOutline(playerid, needle[playerid][i], 1);
				PlayerTextDrawShow(playerid, needle[playerid][i]);
			}
			new Float:alpha2 = alpha - 180;
			for(new x; x < 4; x++)
			{
			    PlayerTextDrawDestroy(playerid, Backneedle[playerid][x]);
				new Float:Pos1[4][2];
		  		RotationXY(508.6, 325+35.0, Pos1[x][0], Pos1[x][1], alpha2, (x + 1) * 5);
		  		Backneedle[playerid][x] = CreatePlayerTextDraw(playerid, Pos1[x][0], Pos1[x][1], "~l~.");
				PlayerTextDrawBackgroundColor(playerid, Backneedle[playerid][x], 0x000000FF);
	  			PlayerTextDrawLetterSize(playerid, Backneedle[playerid][x], 0.73, -2.60);
				PlayerTextDrawColor(playerid, Backneedle[playerid][x], 0x000000FF);
				PlayerTextDrawSetOutline(playerid, Backneedle[playerid][x], 1);
				PlayerTextDrawShow(playerid, Backneedle[playerid][x]);
			}
			if(!IsVehicleDrivingBackwards(GetPlayerVehicleID(playerid)))
		    {
			    new speed_string[128];
			    format(speed_string,sizeof(speed_string),"%i",GetVehicleSpeed(playerid));
			    PlayerTextDrawSetString(playerid, Speed[playerid], speed_string);

			    if(GetVehicleSpeed(playerid) < 1)
			    {
			        PlayerTextDrawSetString(playerid, Gear[playerid], "N");
			    }
			    if(GetVehicleSpeed(playerid) > 1)
			    {
			        PlayerTextDrawSetString(playerid, Gear[playerid], "D");
			        
			    }
			}
			if(IsVehicleDrivingBackwards(GetPlayerVehicleID(playerid)))
		    {
		        PlayerTextDrawSetString(playerid, Gear[playerid], "R");
			    PlayerTextDrawSetString(playerid, Speed[playerid], "0");
			    return 1;
			}
		}
	}
	return 1;
}
stock IsVehicleDrivingBackwards(vehicleid)
{
	new Float:Float[3];
	if(GetVehicleVelocity(vehicleid, Float[1], Float[2], Float[0]))
	{
		GetVehicleZAngle(vehicleid, Float[0]);
		if(Float[0] < 90)
		{
			if(Float[1] > 0 && Float[2] < 0) return true;
		}
		else if(Float[0] < 180)
		{
			if(Float[1] > 0 && Float[2] > 0) return true;
		}
		else if(Float[0] < 270)
		{
			if(Float[1] < 0 && Float[2] > 0) return true;
		}
		else if(Float[1] < 0 && Float[2] < 0) return true;
	}
	return false;
}



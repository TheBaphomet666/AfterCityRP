/*
	Extended wanted-level display filterscript.
	-----------
	This makes it possible to display more than the game's default max number of 6 wanted-level stars.
	You can also change the number of "inactive stars" to fit your needs.
	There are a few options below that you might want to adjust to fit your needs.

	What do I need to do in my other scripts?
	Nothing! Simply use SetPlayerWantedLevel and this script will automatically notice changes then display them.

	Author: Slice
*/

#include <a_samp>

#define MAX_DISPLAYED_STARS		12		// Max number of wanted-level stars displayed, including the game's 6 stars.
#define NUM_INACTIVE_STARS		6		// Number of inactive stars to display, including the game's 6 stars; put 6 to disable.
#define STARS_PER_ROW			6		// The number of stars displayed on each row
#define ROW_HEIGHT				20.0	// The height between rows; no need to edit this.

#undef MAX_PLAYERS
#define MAX_PLAYERS				100		// Change this to whatever your server is using so you won't have lots of unused memory.

#if MAX_DISPLAYED_STARS <= 6
	#error STARS_PER_ROW may only be > 6
#endif

#if STARS_PER_ROW < 6
	#error STARS_PER_ROW may only be >= 6
#endif

#if NUM_INACTIVE_STARS < 6
	#error NUM_INACTIVE_STARS may only be >= 6
#endif

stock
	g_UpdateTimer = -1,
	g_aPreviousWantedLevel[ MAX_PLAYERS char ], // I use char here so the array will use only 1 byte per slot (no more is needed).
	Text:g_aStarTextDraws[ MAX_DISPLAYED_STARS - 1 ],
	Text:g_aInactiveStarTextDraws[ NUM_INACTIVE_STARS - 6 ]
;

public OnFilterScriptInit( )
{
	new
		i,
		#if STARS_PER_ROW > 6
			col = 7,
			row = 0
		#else
			col = 1,
			row = 1
		#endif
	;

	for ( i = 7; i < sizeof( g_aStarTextDraws ); i++ )
	{
		//g_aStarTextDraws[ i ] = TextDrawCreate( 503.5 - ( 18.0 * ( col - 7 ) ), 102.1 + ( row * ROW_HEIGHT ), "]" );
		g_aStarTextDraws[ i ] = TextDrawCreate(620.000000,200.000000, "]" );

		TextDrawColor			( g_aStarTextDraws[ i ], 0x906210FF );
		TextDrawBackgroundColor	( g_aStarTextDraws[ i ], 0x000000AA );
		TextDrawFont			( g_aStarTextDraws[ i ], 2 );
		TextDrawSetShadow		( g_aStarTextDraws[ i ], 0 );
		TextDrawSetProportional	( g_aStarTextDraws[ i ], true );
		TextDrawLetterSize		( g_aStarTextDraws[ i ], 0.6, 2.4 );
		TextDrawAlignment		( g_aStarTextDraws[ i ], 3 );
		TextDrawSetOutline		( g_aStarTextDraws[ i ], 1 );

		if ( ++col > STARS_PER_ROW )
		{
			col = 1;

			++row;
		}
	}

	#if NUM_INACTIVE_STARS > 6

	#if STARS_PER_ROW > 6
		col = 7;
		row = 0;
	#else
		col = 1;
		row = 1;
	#endif

	for ( i = 0; i < NUM_INACTIVE_STARS - 6; i++ )
	{
		//g_aInactiveStarTextDraws[ i ] = TextDrawCreate( 503.0 - ( 18.0 * ( col - 7 ) ), 100.0 + ( row * ROW_HEIGHT ), "]" );
		g_aInactiveStarTextDraws[ i ] = TextDrawCreate( 620.000000,200.000000, "]" );

		TextDrawColor			( g_aInactiveStarTextDraws[ i ], 0x00000070 );
		TextDrawFont			( g_aInactiveStarTextDraws[ i ], 2 );
		TextDrawSetShadow		( g_aInactiveStarTextDraws[ i ], 0 );
		TextDrawSetProportional	( g_aInactiveStarTextDraws[ i ], true );
		TextDrawLetterSize		( g_aInactiveStarTextDraws[ i ], 0.72, 2.88 );
		TextDrawAlignment		( g_aInactiveStarTextDraws[ i ], 3 );
		TextDrawSetOutline		( g_aInactiveStarTextDraws[ i ], 0 );

		if ( ++col > STARS_PER_ROW )
		{
			col = 1;

			++row;
		}
	}

	#endif
}

public OnFilterScriptExit( )
{
	KillTimer( g_UpdateTimer );

	for ( new i = 0; i < sizeof( g_aStarTextDraws ); i++ )
		TextDrawDestroy( g_aStarTextDraws[ i ] );

	#if NUM_INACTIVE_STARS > 6

	for ( new i = 0; i < sizeof( g_aInactiveStarTextDraws ); i++ )
		TextDrawDestroy( g_aInactiveStarTextDraws[ i ] );

	#endif
}

public OnPlayerUpdate( playerid )
{
	static
		wantedLevel // I use static here so the variable won't have to be initialized each OnPlayerUpdate; therefore, more efficiency.
	;

	wantedLevel = GetPlayerWantedLevel( playerid );

	if ( g_aPreviousWantedLevel[ playerid ] != wantedLevel )
	{
		UpdatePlayerWantedLevel( playerid, g_aPreviousWantedLevel[ playerid ], wantedLevel );

		g_aPreviousWantedLevel[ playerid ] = wantedLevel;
	}

	return 1;
}

UpdatePlayerWantedLevel( playerid, oldlevel, newlevel )
{
	if ( oldlevel > 6 || newlevel > 6 )
	{
		for ( new i = min( oldlevel, newlevel ), j = max( oldlevel, newlevel ); i < j; i++ )
		{
			if ( i < 0 || i > sizeof( g_aStarTextDraws ) )
				continue;

			if ( i >= 6 )
			{
				if ( i < newlevel )
				{
					TextDrawShowForPlayer( playerid, g_aStarTextDraws[ i - 6 ] );

					#if NUM_INACTIVE_STARS > 6

					if ( i < NUM_INACTIVE_STARS )
						TextDrawHideForPlayer( playerid, g_aInactiveStarTextDraws[ i - 6 ] );

					#endif
				}
				else
				{
					TextDrawHideForPlayer( playerid, g_aStarTextDraws[ i - 6 ] );

					#if NUM_INACTIVE_STARS > 6

					if ( i < NUM_INACTIVE_STARS )
						TextDrawShowForPlayer( playerid, g_aInactiveStarTextDraws[ i - 6 ] );

					#endif
				}
			}
		}
	}

	#if NUM_INACTIVE_STARS > 6

	if ( oldlevel == 0 )
	{
		for ( new i = 0; i < NUM_INACTIVE_STARS - 6; i++ )
		{
			if ( i >= newlevel - 6 )
				TextDrawShowForPlayer( playerid, g_aInactiveStarTextDraws[ i ] );
		}
	}
	else if ( newlevel == 0 )
	{
		for ( new i = 0; i < NUM_INACTIVE_STARS - 6; i++ )
			TextDrawHideForPlayer( playerid, g_aInactiveStarTextDraws[ i ] );
	}

	#endif
}

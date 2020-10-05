// create groups 
// enemy groups
attackGroup_1 = createGroup [east, false];
attackGroup_2 = createGroup [east, false];
attackGroup_3 = createGroup [east, false];
attackGroup_4 = createGroup [east, false];
attackGroup_5 = createGroup [east, false];
attackGroup_6 = createGroup [east, false];
attackGroup_7 = createGroup [east, false];
attackGroup_8 = createGroup [east, false];

// friendly groups 
ally_1 = group player;
ally_2 = createGroup [west, false];
ally_3 = createGroup [west, false];
ally_4 = createGroup [west, false];
ally_5 = createGroup [west, false];
ally_6 = createGroup [west, false];
ally_7 = createGroup [west, false];

// variable for counting stuff
groupCount = 0;
continueLoop = true;
doOnce = 0;
BLU_UNIT_SIZE = 5;
RED_UNIT_SIZE = 8;

// find the marker 
// spawn points 

WEST_SPAWN = markerPos ["westSpawn", true];
EAST_SPAWN = markerPos ["eastSpawn", true];

// enemy markers 

EAST_POSITIONS = [];

	private _i = 0;
	private _continue = true; 
while {_continue} do {
	_i = _i+1;
	private _locName = format ['loc_%1', _i];
	if(_locName in allMapMarkers) then {
		EAST_POSITIONS pushBack _locName;
	}else{
		_continue = false;
	} ;
};

TRANSPORTS = [
	Rhino1,
	Rhino2,
	Rhino3
];

// blufor routs 

ROUT_ONE = [];
ROUT_TWO = [];
ROUT_THREE = [];

// find rout one markers 
	 private _i = 0;
	 _continue = true; 
while {_continue} do {
	_i = _i+1;
	private _locName = format ['rtOne_%1', _i];
	if(_locName in allMapMarkers) then {
		ROUT_ONE pushBack _locName;
	}else{
		_continue = false;
	} ;
};

// find rout two markers 
	 private _i = 0;
	 _continue = true; 
while {_continue} do {
	_i = _i+1;
	private _locName = format ['rtTwo_%1', _i];
	if(_locName in allMapMarkers) then {
		ROUT_TWO pushBack _locName;
	}else{
		_continue = false;
	} ;
};

// find rout three markers 
	 private _i = 0;
	 _continue = true; 
while {_continue} do {
	_i = _i+1;
	private _locName = format ['rtThree_%1', _i];
	if(_locName in allMapMarkers) then {
		ROUT_THREE pushBack _locName;
	}else{
		_continue = false;
	} ;
};

// units arrays 
// enemy units 

// enemy soldiers array
Isis_Unit_Configs = "getText (_x >> 'faction') == 'LOP_ISTS_OPF' && getText (_x >> 'simulation') == 'soldier'" configClasses (configFile >> "CfgVehicles");
Isis_units = Isis_Unit_Configs apply {configName _x};


// friendly soldiers array 
bluforUnitsConfig= "getText (_x >> 'faction') == 'rhs_faction_usmc_wd' && getText (_x >> 'simulation') == 'soldier' &&  ['wd', getText (_x >> 'uniformClass')] call BIS_fnc_inString" configClasses (configFile >> "CfgVehicles");
bluforUnits = bluforUnitsConfig apply {configName _x};

// hint format ['returned %1', ['wd', getText (_x >> 'uniformClass')] call BIS_fnc_inString]
// hint format ['returned %1', getText(configFile >> 'CfgVehicles' >> "rhsusf_usmc_lar_marpat_wd_grenadier_m32" >> 'uniformClass')]
//This is the loop that continuously spawns soldiers until continueLoop = false
hint 'Spawn loop started';
if (!continueLoop) exitWith {
	hint 'loop stopped'
};
//declare groups to count

{
	// Current result is saved in variable _x
	private _count = {alive _x} count units _x;
	private _marker = EAST_POSITIONS call BIS_fnc_selectRandom;
	private _location = markerPos _marker;
	private _results =  [_x, (RED_UNIT_SIZE - _count), Isis_units, EAST_SPAWN] call  jMD_fnc_spawnGroups;
	private _waypoints = [_x, 200, _location, true, true] call jMD_fnc_deleteAndSetWaypoints;
} forEach ENEMY_GROUPS;

{
	// Current result is saved in variable _x
	scopeName "unitSpawn";
	private _groupSize = BLU_UNIT_SIZE; // desired size of each group
	private _count = {alive _x}count units _x;
	private _group = _x;
	private _routArray = [ROUT_ONE, ROUT_TWO, ROUT_THREE] call BIS_fnc_selectRandom;
	private _results =  [_group, (_groupSize - _count), bluforUnits, WEST_SPAWN] call  jMD_fnc_spawnGroups;
	private _timer = 0;

	while { ( {alive _x}count units _group) < _groupSize } do {
		_timer = _timer + 1;
		private _count = {alive _x}count units _group;
		private _results =  [_group, (_groupSize - _count), bluforUnits, WEST_SPAWN] call  jMD_fnc_spawnGroups;
		if (_timer > 255) then { breakTo "unitSpawn"};
	};
	if (count waypoints _x < 2) then {
		{
			private _loc = markerPos _x;
			private _waypoints = [_group, 50, _loc, false, false] call jMD_fnc_deleteAndSetWaypoints;
		}forEach _routArray;
		private _waypoints = [_group, 100, EAST_SPAWN, false, false] call jMD_fnc_deleteAndSetWaypoints;
	};
	if (doOnce < count FRIENDLY_GROUPS) then {
		_x setBehaviour "SAFE";
		FRIENDLY_GROUPS deleteAt(FRIENDLY_GROUPS find group player);
		doOnce = doOnce +1;
	};
} forEach FRIENDLY_GROUPS;

_vehicleType = Isis_Vehicles call BIS_fnc_selectRandom;
_veh = [ EAST_VEHICLE_SPAWN, 330, _vehicleType, east] call BIS_fnc_spawnVehicle;
hint format['Created vehicle %1', _veh];
_vehGroup = _veh select 2;
_vehGroup setBehaviour "SAFE";
[_vehGroup, 200, position player, true, false] call jMD_fnc_deleteAndSetWaypoints;


sleep 1200; //1200 = 20 min
saveGame;

[] spawn jMD_fnc_spawnLoop;
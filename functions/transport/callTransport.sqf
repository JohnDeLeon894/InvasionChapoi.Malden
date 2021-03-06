// called from radio. 
private _pos = _this select 0;
private _action = _this select 1;

// check for available transport
{
	// Current result is saved in variable _x
	private _tooFarFromLZ = _x distance TRANSPORT_ZONE > 100;
	if(!(alive _x)) exitWith{
		TRANSPORTS deleteAt (TRANSPORTS find _x);
	};
	if(!(_x getVariable ['onMission', false]) && !(_tooFarFromLZ)) exitWith{
		hint format ['%1 on the move', _x];
		[_x, _action, _pos]execVM "functions\transport\transportAction.sqf";
	};
} forEach TRANSPORTS;
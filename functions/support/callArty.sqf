
private _pos = _this select 0;
private _gridPos = mapGridPosition _pos;
// hint format ["firing on pos %1", gridPos];

player commandChat format ['This is %1 requesting arty mission on grid %2, how copy over.', groupId group player, _gridPos];

sleep 5;

private _eta = m1 getArtilleryETA[_pos, "rhs_12Rnd_m821_HE"];
m1 commandChat format ['%1, firing on grid %2. Rounds spalsh in %3. Out.', groupId group m1, _gridPos, _eta];

{
	_x commandArtilleryFire [_pos, "rhs_12Rnd_m821_HE", 1];

} forEach ARTY;

private _ammo = getArtilleryAmmo ARTY;
hint format ['available ammo: %1', _ammo];

CMD:seatbelt(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "You're not in vehicle!");

	new vehicleid = GetPlayerVehicleID(playerid);
	if(IsABoat(vehicleid) || IsABicycle(vehicleid) || IsABike(vehicleid) || IsAPlane(vehicleid))
		return SendErrorMessage(playerid, "You're not in vehicle that has seatbelt in!");

	if(GetVehicleSpeed(vehicleid) >= 20)
		return SendErrorMessage(playerid, "You have to stop first!");

	PlayerData[playerid][pSeatBelt] = !PlayerData[playerid][pSeatBelt];
	SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s has swings seatbelt %s.", ReturnName(playerid), PlayerData[playerid][pSeatBelt] ? "on" : "off");
	return 1;
}
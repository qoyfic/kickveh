#include <open.mp>
#include <Pawn.CMD>

CMD:kickveh(playerid, params[])
{
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    
    new vehicleid = GetClosestVehicle(playerid, 3.0);
    
    if(vehicleid == INVALID_VEHICLE_ID)
    {
        SendClientMessage(playerid, -1, "Ain't no ride near you, homie");
        return 1;
    }
    
    new Float:vx, Float:vy, Float:vz;
    GetVehiclePos(vehicleid, vx, vy, vz);
    
    new Float:angle = atan2(vy - y, vx - x) - 90.0;
    SetPlayerFacingAngle(playerid, angle);
    
    ApplyAnimation(playerid, "POLICE", "Door_Kick", 4.5, false, false, false, false, 0);
    
    SetVehicleAngularVelocity(vehicleid, 0.03, 0.03, 0.05);
    
    PlayerPlaySound(playerid, 1130, 0.0, 0.0, 0.0);
    
    return 1;
}

stock GetClosestVehicle(playerid, Float:range = 3.0)
{
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    
    new closestVehicle = INVALID_VEHICLE_ID;
    new Float:closestDistance = range;
    
    for(new i = 1; i < MAX_VEHICLES; i++)
    {
        new Float:vx, Float:vy, Float:vz;
        GetVehiclePos(i, vx, vy, vz);
        
        new Float:distance = VectorSize(x - vx, y - vy, z - vz);
        
        if(distance < closestDistance)
        {
            closestDistance = distance;
            closestVehicle = i;
        }
    }
    
    return closestVehicle;
}
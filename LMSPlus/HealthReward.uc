class HealthReward extends Mutator;

const MAX_HP = 100;
var color WHITE;

function ScoreKill(Pawn Killer, Pawn Other)
{
	local PlayerReplicationInfo PRI;
	local int amount;
	local PlayerPawn P;
	local string message;
	PRI = Other.PlayerReplicationInfo;

	amount = PRI.Score * 10;

	if (Killer != None && Killer != Other && amount > 0)
	{
		if (amount > MAX_HP) 
		{
			amount = MAX_HP;
		}
		Killer.Health += amount;
		if (Killer.Health > MAX_HP) 
		{
			Killer.Health = MAX_HP;
		}
		message = "+"$amount$"hp for fragging "$PRI.PlayerName;
		P = PlayerPawn(Killer);
		if (P != None)
		{
			P.ClearProgressMessages();
			P.SetProgressTime(2);
			P.SetProgressColor(WHITE, 0);
			P.SetProgressMessage(message, 0);
		}
		else 
		{
			Killer.ClientMessage(message);
		}
	}

	// called by GameInfo.ScoreKill()
	if ( NextMutator != None )
		NextMutator.ScoreKill(Killer, Other);
}

defaultproperties 
{
	WHITE=(R=255,G=255,B=255)
}
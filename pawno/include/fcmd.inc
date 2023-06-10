#define fcmd(%1,%2) \
	forward fcmd_%1(%2);    \
		public fcmd_%1(%2)

#define MaxFrequence (025)
#define MaxParameter (064)
#define MaxFunctions (032)
#define MaxLenString (128)

new
    sIndex = 0,
    iLenPart = 0,
    iPosPart = 0,
    iStrMid = 0,
    iLenght = 0,
    iParams[ MaxFrequence ][ MaxParameter ],
    cmds[ MaxFunctions ]
;

new iTotalParams[MaxLenString];

public OnPlayerCommandText(playerid, cmdtext[])
{
	return DelimiterCommand(playerid,cmdtext);
}

stock DelimiterCommand(playerid,sStringSource[])
{
    iLenght = strlen(sStringSource);
    sIndex = 0;
    iLenPart = 0;
    iPosPart = 0;
    iStrMid = 0;
    for(new aIndex = 1; aIndex < MaxFrequence; ++aIndex) iParams[aIndex][0] = '\0';
    iTotalParams[0] = '\0';
    while(sIndex <= iLenght)
    {

        if(sStringSource[sIndex] == ' ' && sStringSource[sIndex - 1] != ' ' || sIndex == iLenght)
        {
            iStrMid = strmid(iParams[iPosPart], sStringSource, iLenPart, sIndex, 128);
            iParams[iPosPart][iStrMid] = 0,iLenPart = (sIndex + 1), ++iPosPart;
            if(iPosPart == 1)
                format(iTotalParams,MaxLenString, "%s",sStringSource[sIndex]);
        }
        ++sIndex;
    }
    format(cmds, sizeof cmds,"fcmd_%s",iParams[0][1]);
    return CallLocalFunction(cmds,"i",playerid);
}
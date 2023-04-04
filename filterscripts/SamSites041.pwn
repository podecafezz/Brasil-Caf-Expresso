#define FILTERSCRIPT

#include <a_samp>
#include <SAMsites0.4.1>

#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
	//SAM_start();
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

#endif

public OnSamSiteUpdate(samid, playerid)
{
	return 1;
}

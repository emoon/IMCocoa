
#include <imcocoa/imcocoa.h>
#include <stdio.h>

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

static void uiCallback(void* userData)
{
	if (IMCocoa_pushButton("button", 10, 10, 140, 26))
	{
		printf("Pressed button!\n");
	}

	if (IMCocoa_pushButton("button 2", 10, 50, 140, 26))
	{
		printf("Pressed button 2!\n");
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

int main(int argc, char* argv[])
{
	IMCocoa_appCreate();
	IMCocoa_windowCreate("foo", uiCallback, 0);

	IMCocoa_appRun();

	IMCocoa_appDestroy();

	return 0;
}


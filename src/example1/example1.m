
#include <imcocoa/imcocoa.h>
#include <stdio.h>

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

static void uiCallback(void* parent, void* userData)
{
	if (IMCocoa_button("testing", 10, 10, 40, 20))
	{
		printf("Pressed button!\n");
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


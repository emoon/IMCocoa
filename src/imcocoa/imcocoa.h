#pragma once

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// App

void IMCocoa_appCreate();
void IMCocoa_appDestroy();
void IMCocoa_appRun();

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Window

void* IMCocoa_windowCreate(const char* name, void (*uiCallback)(void*), void* userData);
void IMCocoa_windowDestroy(void* handle);

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Controls
// TODO: Better ID generation, but this will do for testing at least (note that this won't work for loops)

#define IMCocoa_pushButton(name, x, y, w, h) \
	IMCocoa_pushButtonCall(__LINE__, name, x, y, w, h) 

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Controls implementian

int IMCocoa_pushButtonCall(int id, const char* name, int x, int y, int w, int h);


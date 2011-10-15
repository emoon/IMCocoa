#import <Cocoa/Cocoa.h>
#include "imcocoa.h"

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

typedef struct KeyValueLookup 
{
	uint64_t key[2048];
	uint64_t value[2048];
	int count;
} KeyValueLookup;

static struct KeyValueLookup g_controlWindowLut; 

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

static void Lookup_addEntry(KeyValueLookup* lut, uint64_t key, uint64_t value)
{
	if (lut->count >= 2048)
	{
		printf("list is full\n");
		return;
	}

	int offset = lut->count++;

	lut->key[offset] = key;
	lut->value[offset] = value;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*
static void Lookup_removeEntry(KeyValueLookup* lut, uint64_t key, uint64_t value)
{
	for (int i = 0, count = lut->count; i < count; ++i)
	{
		if (lut->key[i] == key)
		{
			lut->key[i] = lut->key[count - 1];
			lut->value[i] = lut->value[count - 1];
			lut->count--;
			return;
		}
	}
}
*/

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

static bool Lookup_findEntry(KeyValueLookup* lut, uint64_t key, uint64_t* value)
{
	for (int i = 0, count = lut->count; i < count; ++i)
	{
		if (lut->key[i] == key)
		{
			*value = lut->value[i];
			return true;
		}
	}

	return false;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*
static void Lookup_addNotExists(KeyValueLookup* lut, uint64_t key, uint64_t value)
{
	uint64_t outValue;

	if (!Lookup_findEntry(lut, key, &outValue))
		Lookup_addEntry(lut, key, value);
}
*/

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

static NSButton* s_temp = 0;
static bool s_buttonState = false;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

@interface IMCocoaWindow : NSWindow
{
	NSView* childContentView;
@public
	void (*uiCallback)(void* parent, void* userData);
	void* userData;
}
@end

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

@interface AppController : NSObject<NSApplicationDelegate>
{
}
@end

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

@implementation AppController

- (IBAction)onButtonClick:(id)sender;
{
	// Find window that the button belongs to

	uint64_t value;

	if (!Lookup_findEntry(&g_controlWindowLut, (uint64_t)sender, &value))
	{
		printf("Unable to find %p\n", sender);
		return;
	}

	IMCocoaWindow* window = (IMCocoaWindow*)value;
	s_buttonState = true; 	
	window->uiCallback(window, window->userData);
}
@end

static AppController* s_controller = 0;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

@implementation IMCocoaWindow
/*
- (void)setContentView:(NSView *)aView
{
	if ([childContentView isEqualTo:aView])
		return;
	
	NSRect bounds = [self frame];
	bounds.origin = NSZeroPoint;

	IMCocoaFrameView* frameView = [super contentView];
	if (!frameView)
	{
		frameView = [[[IMCocoaFrameView alloc] initWithFrame:bounds] autorelease];
		frameView->uiCallback = self->uiCallback;
		frameView->userData = self->userData;
		[super setContentView:frameView];
	}
	
	if (childContentView)
	{
		[childContentView removeFromSuperview];
	}

	childContentView = aView;
	[childContentView setFrame:[self contentRectForFrameRect:bounds]];
	[childContentView setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
	[frameView addSubview:childContentView];
}

-(void)onButtonClick:(id)sender
{
	printf("buttonWindow\n");
}
*/

@end

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// App

void IMCocoa_appCreate()
{
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	s_controller = [[AppController alloc] init];
	[[NSApplication sharedApplication] setDelegate:s_controller];
	[pool drain];
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void IMCocoa_appDestroy()
{
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void IMCocoa_appRun()
{
	[NSApp run];
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void* IMCocoa_windowCreate(const char* name, void (*uiCallback)(void*, void*), void* userData)
{
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	NSUInteger style = NSTitledWindowMask | NSClosableWindowMask | NSMiniaturizableWindowMask | NSResizableWindowMask;
	IMCocoaWindow* window = [[IMCocoaWindow alloc] initWithContentRect:NSMakeRect(0,0,400,400) styleMask:style backing:NSBackingStoreBuffered defer:NO];
	[window makeKeyAndOrderFront:nil];

	//IMCocoaFrameView* frameView = [window contentView];

	window->uiCallback = uiCallback;
	window->userData = userData;

	uiCallback(window, userData);

	[pool drain];

	return window;	
}
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void IMCocoaWindow_destroy(void* handle)
{
	// TODO: Implement
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

int IMCocoa_buttonCall(int id, void* parent, const char* name, int x, int y, int w, int h)
{
	if (s_temp != 0)
	{
		return s_buttonState;
	}

	NSWindow* window = (NSWindow*)parent;
	NSView* view = [window contentView]; 
	NSButton* button = [[NSButton alloc] initWithFrame:NSMakeRect(14, 100, 120, 40)];
	[button setTitle: @"Test"];
	[button setBezelStyle:NSRoundedBezelStyle];
	[button setAction:@selector(onButtonClick:)];
	[button setTarget:s_controller];
	[view addSubview:button];  

	Lookup_addEntry(&g_controlWindowLut, (uint64_t)button, (uint64_t)window);

	return s_buttonState;
}


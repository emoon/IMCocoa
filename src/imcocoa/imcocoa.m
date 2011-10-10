#import <Cocoa/Cocoa.h>
#include "imcocoa.h"

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

static IMCocoaWindow* s_window; // TEMP TEMP  

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

@interface AppController : NSObject<NSApplicationDelegate>
{
}
@end

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

@implementation AppController

- (IBAction)onButtonClick:(id)sender;
{
	// TODO Proper way of accessing the window that owns this button
	// Hacky hack test for now (of course needs proper tables etc to track correct button)
	s_buttonState = true; 	
	s_window->uiCallback([s_window contentView], s_window->userData);
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

	uiCallback([window contentView], userData);

	[pool drain];

	s_window = window; // temp

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

	NSView* view = (NSView*)parent;
	NSButton* button = [[NSButton alloc] initWithFrame:NSMakeRect(14, 100, 120, 40)];
	[button setTitle: @"Test"];
	[button setBezelStyle:NSRoundedBezelStyle];
	[button setAction:@selector(onButtonClick:)];
	[button setTarget:s_controller];
	[view addSubview:button];  
	s_temp = button;

	return s_buttonState;
}


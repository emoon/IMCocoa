
#import <Cocoa/Cocoa.h>

@interface MyWindow : NSWindow
{
	NSView* myView;
}

@end

@implementation MyWindow
@end

int main(int argc, char* argv[])
{
  [NSApplication sharedApplication];
  NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];

  NSUInteger style = NSTitledWindowMask | NSClosableWindowMask | NSMiniaturizableWindowMask | NSResizableWindowMask;
  NSWindow* window = [[MyWindow alloc] initWithContentRect:NSMakeRect(0,0,400,400) styleMask:style backing:NSBackingStoreBuffered defer:NO];
  [window makeKeyAndOrderFront:nil];

  [pool drain];

  [NSApp run];

  return 0;
}


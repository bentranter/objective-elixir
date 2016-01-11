#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

// #include "erl_nif.h"

void* SharedApplication(void) {
	return [NSApplication sharedApplication];
}

void Run(void *app) {
	@autoreleasepool {
		NSApplication* a = (NSApplication*)app;
		[a setActivationPolicy:NSApplicationActivationPolicyRegular];
		[a run];
	}
}

void *NewWindow(int x, int y, int width, int height) {
	NSWindow* window = [[NSWindow alloc] initWithContentRect:NSMakeRect(x, y, width, height)
		styleMask:NSTitledWindowMask
		backing:NSBackingStoreBuffered defer:NO];
	return window;
}

void MakeKeyAndOrderFront(void *self) {
	NSWindow *window = self;
	[window makeKeyAndOrderFront:nil];
}

void SetTitle(void *self, char *title) {
	NSWindow *window = self;
	NSString *nsTitle = [NSString stringWithUTF8String:title];
	[window setTitle:nsTitle];
	free(title);
}

int main(int argc, char *argv[]) {
	return 0;
}

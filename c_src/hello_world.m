#import <Cocoa/Cocoa.h>

#include "erl_nif.h"

void SayHello(char *message) {
	NSLog(@"%s", message);
}

void* SharedApplication(void) {
	return [NSApplication sharedApplication];
}

void Run(void *app) {
	@autoreleasepool {
		NSApplication *a = (NSApplication*)app;
		[a setActivationPolicy:NSApplicationActivationPolicyRegular];
		[a run];
	}
}

void *NewWindow(int x, int y, int width, int height) {
	NSWindow *window = [[NSWindow alloc] initWithContentRect:NSMakeRect(x, y, width, height)
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
}

static ERL_NIF_TERM hello(ErlNifEnv *env, int argc, const ERL_NIF_TERM argv[]) {
	char buf[256];

	if (!enif_get_string(env, argv[0], buf, 256, ERL_NIF_LATIN1)) {
  	return enif_make_badarg(env);
	}

	SayHello(buf);

	return enif_make_int(env, 0);
}

static ERL_NIF_TERM new_window(ErlNifEnv *env, int argc, const ERL_NIF_TERM argv[]) {
	int x, y, width, height;

	enif_get_int(env, argv[0], &x);
	enif_get_int(env, argv[0], &y);
	enif_get_int(env, argv[0], &width);
	enif_get_int(env, argv[0], &height);

	NSApplication *app = SharedApplication();
	NSWindow *window = NewWindow(x, y, width, height);
	SetTitle(window, "Hi");
	MakeKeyAndOrderFront(window);
	Run(app);

	return enif_make_int(env, 0);
}

static ErlNifFunc nif_funcs[] = {
	{"test", 4, new_window},
	{"hello", 1, hello}
};

ERL_NIF_INIT(Elixir.Test, nif_funcs, NULL, NULL, NULL, NULL)

// int main(int argc, char *argv[]) {
// 	NSApplication *app = SharedApplication();
// 	NSWindow *window = NewWindow(0, 0, 640, 480);
// 	SetTitle(window, "Hi");
// 	MakeKeyAndOrderFront(window);
// 	Run(app);
// 	return 0;
// }

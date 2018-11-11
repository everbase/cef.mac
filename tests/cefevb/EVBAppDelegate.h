//
//  EVBAppDelegate.h
//  desktop-app
//
//  Created by Hannes Ahrens on 11/11/18.
//  Copyright (c) 2018 Everbase. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <objc/runtime.h>

#include "tests/cefevb/EVBWebWindow.h"

/**
 * Our application's delegate responsible for managing the application state and its termination
 */
@interface EVBAppDelegate : NSObject<NSApplicationDelegate>
{
}

@property(assign) IBOutlet EVBWebWindow* myWindow;

- (void) tryToTerminateApplication:(NSApplication*)app;

/**
 * Called when this object receives a 'terminate:' selector message.
 * We return with NSTerminateLater and asynchronously dispatch a code-block on the main queue to perform cleanup method calls.
 * When finished with the cleanup calls, we call: [sender replyToApplicationShouldTerminate:YES];
 * @param sender the application that sent the terminate: message
 * @return NSTerminateLater right away
 */
- (NSApplicationTerminateReply) applicationShouldTerminate:(NSApplication *)sender;

@end

//
//  EVBAppDelegate.m
//  desktop-app
//
//  Created by Hannes Ahrens on 11/11/18.
//  Copyright (c) 2018 Everbase. All rights reserved.
//

#import "EVBAppDelegate.h"
#include "tests/cefevb/evb_handler.h"


@implementation EVBAppDelegate

- (void)tryToTerminateApplication:(NSApplication*)app
{
    // close cef browsers, release views and call CefQuitMessageLoop to terminate
    EvbHandler* handler = EvbHandler::GetInstance();
    if( handler && !handler->IsClosing() )
    {
        handler->CloseAllBrowsers(false);
    }

//  // remove CefBrowserHostView subview in order for the CefLifeSpanHandler::OnBeforeClose being called
//  // causing CefQuitMessageLoop to be called when the last cef browser is destroyed, see EvbHandler::OnBeforeClose
//  for(NSView* view in [[_myWindow webView] subviews]) {
//    [view removeFromSuperview];
//  }

//  [_myWindow setIsVisible:FALSE];
//  [_myWindow close];

//  CEF_REQUIRE_UI_THREAD();
//  CefQuitMessageLoop();
}

- (NSApplicationTerminateReply) applicationShouldTerminate:(NSApplication *)sender
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [sender replyToApplicationShouldTerminate:YES];
    });

    return NSTerminateLater;
}

@end

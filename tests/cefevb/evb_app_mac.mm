//
//  evb_app.m
//  cef
//
//  Created by Hannes Ahrens on 11/11/18.
//  Copyright (c) 2018 Everbase. All rights reserved.
//

#include "tests/cefevb/evb_app.h"

#import <Cocoa/Cocoa.h>
#include "include/wrapper/cef_helpers.h"
#include "tests/cefevb/evb_handler.h"
#include "tests/cefevb/EVBAppDelegate.h"


void EvbApp::_createBrowser()
{
    CEF_REQUIRE_UI_THREAD();
    
    EVBAppDelegate* delegate = static_cast<EVBAppDelegate*>([NSApp delegate]);
    NSView* webView = [[delegate myWindow] webView];
    
    NSRect contentBounds = [webView bounds];

    // EvbHandler implements browser-level callbacks.
    CefRefPtr<EvbHandler> handler( new EvbHandler() );

    // Specify CEF browser settings here.
    CefBrowserSettings browser_settings;

    std::string url = "http://www.google.com";

    // Information used when creating the native window.
    CefWindowInfo window_info;

    window_info.SetAsChild( webView, 0, 0, contentBounds.size.width, contentBounds.size.height );

    // Create the first browser window.
    CefBrowserHost::CreateBrowser( window_info, handler, url, browser_settings, NULL );
}

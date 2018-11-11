// Copyright (c) 2013 The Chromium Embedded Framework Authors. All rights
// reserved. Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

#include "tests/cefevb/evb_handler.h"

#import <Cocoa/Cocoa.h>

#include "include/cef_browser.h"

void EvbHandler::_releaseBrowserView(CefRefPtr<CefBrowser> browser)
{
    [browser->GetHost()->GetWindowHandle() removeFromSuperview];
}

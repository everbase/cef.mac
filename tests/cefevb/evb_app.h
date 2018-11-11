// Copyright (c) 2013 The Chromium Embedded Framework Authors. All rights
// reserved. Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

#ifndef CEF_TESTS_CEFEVB_EVB_APP_H_
#define CEF_TESTS_CEFEVB_EVB_APP_H_

#include "include/cef_app.h"

// Implement application-level callbacks for the browser process.
class EvbApp : public CefApp, public CefBrowserProcessHandler
{
public:
    EvbApp();

    // CefApp methods:
    virtual CefRefPtr<CefBrowserProcessHandler> GetBrowserProcessHandler() OVERRIDE { return this; }

    // CefBrowserProcessHandler methods:
    virtual void OnContextInitialized() OVERRIDE;

private:
    // Platform-specific implementation.
    void _createBrowser();

    // Include the default reference counting implementation.
    IMPLEMENT_REFCOUNTING( EvbApp );
};

#endif  // CEF_TESTS_CEFEVB_EVB_APP_H_

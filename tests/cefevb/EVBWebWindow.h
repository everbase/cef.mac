//
//  EVBWebWindow.h
//  desktop-app
//
//  Created by Hannes Ahrens on 11/11/18.
//  Copyright (c) 2018 Everbase. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface EVBWebWindow : NSWindow

@property(assign) IBOutlet NSView* webView;

/**
 * Called after the object has been fully initialized.
 */
- (void) awakeFromNib;

@end

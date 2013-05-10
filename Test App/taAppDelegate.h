//
//  taAppDelegate.h
//  Test App
//
//  Created by Paul Aschmann on 5/9/13.
//  Copyright (c) 2013 Lithium Labs, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class taViewController;

@interface taAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) taViewController *viewController;

@end

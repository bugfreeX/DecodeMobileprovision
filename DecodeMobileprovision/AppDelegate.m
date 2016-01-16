//
//  AppDelegate.m
//  DecodeMobileprovision
//
//  Created by FreeGeek on 16/1/11.
//  Copyright © 2016年 ZhongXi. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
@interface AppDelegate ()
@property (nonatomic , strong) MainViewController * mainVC;
@end
@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.mainVC = [[MainViewController alloc]initWithNibName:@"MainViewController" bundle:nil];
    [self.window.contentView addSubview:self.mainVC.view];
}

-(BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag
{
    [_window makeKeyAndOrderFront:nil];
    return YES;
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end

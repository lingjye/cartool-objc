//
//  AppDelegate.m
//  cartool-objc
//
//  Created by chunsheng on 2019/11/27.
//  Copyright © 2019 lingjye. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}

- (IBAction)openFile:(id)sender {
    ViewController *vc = (ViewController *)[NSApplication sharedApplication].keyWindow.contentViewController;
    [vc executeCartoolWithFilePath:@""];
    [vc.dragView openFile];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end

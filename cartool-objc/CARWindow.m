//
//  CARWindow.m
//  cartool-objc
//
//  Created by chunsheng on 2019/11/27.
//  Copyright © 2019 lingjye. All rights reserved.
//

#import "CARWindow.h"

@implementation CARWindow

- (void)windowDidLoad {
    [super windowDidLoad];
    self.window.movableByWindowBackground = YES;
    self.window.opaque = NO;
    self.window.backgroundColor = NSColor.clearColor;
    [self.window center];
    self.window.title = @"cartool";
}

@end

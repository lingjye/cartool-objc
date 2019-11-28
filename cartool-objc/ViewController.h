//
//  ViewController.h
//  cartool-objc
//
//  Created by chunsheng on 2019/11/27.
//  Copyright © 2019 lingjye. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CARView.h"

@interface ViewController : NSViewController

@property (nonatomic, strong) CARView *dragView;

- (void)executeCartoolWithFilePath:(NSString *)filePath;

@end


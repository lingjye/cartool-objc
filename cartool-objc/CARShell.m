//
//  CARShell.m
//  cartool-objc
//
//  Created by chunsheng on 2019/11/27.
//  Copyright © 2019 lingjye. All rights reserved.
//

#import "CARShell.h"
#import <Cocoa/Cocoa.h>

@implementation CARShell

+ (void)execmdWithDir:(NSString *)cmd arguments:(NSArray *)arguments {
    NSTask *task = [[NSTask alloc] init];
    // 设置参数
    task.arguments = arguments;
    // 执行命令
    task.launchPath = cmd;
    // 输出管道
    NSPipe *outputPipe = [[NSPipe alloc] init];
    task.standardOutput = outputPipe;
    
    // 在后台线程等待数据和通知
    [outputPipe.fileHandleForReading waitForDataInBackgroundAndNotify];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noti:) name:NSFileHandleDataAvailableNotification object:outputPipe];
    
    // 开始执行
    [task launch];
}

- (void)noti:(NSNotification *)noti {
    NSPipe *outputPipe = noti.object;
    NSData *output = outputPipe.fileHandleForReading.availableData;
    NSString *outputStr = [[NSString alloc] initWithData:output encoding:NSUTF8StringEncoding];
    NSLog(@"%@", outputStr);
}

@end

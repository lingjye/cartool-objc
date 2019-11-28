//
//  CARView.h
//  cartool-objc
//
//  Created by chunsheng on 2019/11/27.
//  Copyright © 2019 lingjye. All rights reserved.
//

#import <Cocoa/Cocoa.h>


NS_ASSUME_NONNULL_BEGIN

@interface CARView : NSView

@property (nonatomic, copy) void (^dragEndBlock)(NSString * _Nullable path);

- (void)openFile;

@end

NS_ASSUME_NONNULL_END

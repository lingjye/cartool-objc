//
//  CARShell.h
//  cartool-objc
//
//  Created by chunsheng on 2019/11/27.
//  Copyright © 2019 lingjye. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CARShell : NSObject

+ (void)execmdWithDir:(NSString *)cmd arguments:(NSArray *)arguments;

@end

NS_ASSUME_NONNULL_END

//
//  ViewController.m
//  cartool-objc
//
//  Created by chunsheng on 2019/11/27.
//  Copyright © 2019 lingjye. All rights reserved.
//

#import "ViewController.h"
#import "CARShell.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.title = @"cartool";
    [self insertVisualEffectViewWithMode:NSVisualEffectBlendingModeBehindWindow];
    self.dragView = [[CARView alloc] initWithFrame:self.view.bounds];
    self.dragView.wantsLayer = YES;
//    self.dragView.layer.backgroundColor = [NSColor yellowColor].CGColor;
    [self.view addSubview:self.dragView];
    
    __weak __typeof(self) weakSelf = self;
    self.dragView.dragEndBlock = ^(NSString * _Nullable path) {
        if (path) {
            [weakSelf executeCartoolWithFilePath:path];
        }
    };
    
    
    
    self.view.translatesAutoresizingMaskIntoConstraints = false;
    NSDictionary *views = NSDictionaryOfVariableBindings(_dragView);
    [self.view addConstraints:[NSLayoutConstraint
                                  constraintsWithVisualFormat:@"|[_dragView]|"
                                                      options:0
                                                      metrics:@{}
                                                        views:views]];
    [self.view addConstraints:[NSLayoutConstraint
                                  constraintsWithVisualFormat:@"V:|[_dragView]|"
                                                      options:0
                                                      metrics:@{}
                                                        views:views]];
}

- (void)insertVisualEffectViewWithMode:(NSVisualEffectBlendingMode)mode {
    NSVisualEffectView *visualView = [[NSVisualEffectView alloc] initWithFrame:self.view.bounds];
    visualView.autoresizingMask = kCALayerWidthSizable | kCALayerHeightSizable;
    visualView.blendingMode = mode;
    visualView.material = NSVisualEffectMaterialUnderWindowBackground;
    visualView.state = NSVisualEffectStateActive;
    [self.view addSubview: visualView positioned:NSWindowBelow relativeTo:nil];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (void)executeCartoolWithFilePath:(NSString *)filePath {
    NSString *dir = [self mkdirWithFilePath:filePath];
    if (!dir) {
        return;
    }
    NSString *decodePath = filePath.stringByRemovingPercentEncoding;
    [CARShell execmdWithDir:[self carToolPath] arguments:@[decodePath, dir]];
}

- (NSString *)carToolPath {
    NSString *path = [[NSBundle mainBundle].bundlePath stringByAppendingString:@"/Contents/Resources/cartool"];
    return path;
}

- (NSString *)mkdirWithFilePath:(NSString *)filePath {
    NSString *path = filePath.stringByDeletingLastPathComponent;
    NSString *dir = [path.stringByRemovingPercentEncoding stringByAppendingString:@"/Assets"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:dir]) {
        return dir;
    }
    [CARShell execmdWithDir:@"/bin/mkdir" arguments:@[dir]];
    return dir;
}
@end

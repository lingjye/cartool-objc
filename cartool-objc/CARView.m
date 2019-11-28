//
//  CARView.m
//  cartool-objc
//
//  Created by chunsheng on 2019/11/27.
//  Copyright © 2019 lingjye. All rights reserved.
//

#import "CARView.h"

@implementation CARView {
    BOOL dragExited;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    [self registerForDraggedTypes:@[ NSPasteboardTypeFileURL ]];
    NSTrackingArea *area = [[NSTrackingArea alloc] initWithRect:dirtyRect
                                                        options:NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved |
                                                                NSTrackingCursorUpdate |
                                                                NSTrackingActiveWhenFirstResponder |
                                                                NSTrackingActiveInKeyWindow |
                                                                NSTrackingActiveInActiveApp |
                                                                NSTrackingActiveAlways |
                                                                NSTrackingAssumeInside |
                                                                NSTrackingInVisibleRect |
                                                                NSTrackingEnabledDuringMouseDrag
                                                          owner:self
                                                       userInfo:nil];

    [self addTrackingArea:area];
}

//鼠标左键按下
- (void)mouseDown:(NSEvent *)event{
    [self openFile];
}

- (void)openFile {
    NSOpenPanel *openPanel = [NSOpenPanel openPanel];
    [openPanel setPrompt: @"打开"];
    
    openPanel.allowedFileTypes = [NSArray arrayWithObjects: @"car", nil];
    openPanel.directoryURL = nil;
    __weak __typeof(self) weakSelf = self;
    [openPanel beginSheetModalForWindow:self.superview.window completionHandler:^(NSModalResponse returnCode) {
        
        if (returnCode == 1) {
            NSURL *fileUrl = [[openPanel URLs] objectAtIndex:0];
            NSString *filePath = [fileUrl path];
            if (weakSelf.dragEndBlock) {
                weakSelf.dragEndBlock(filePath);
            }
        }
    }];
}

- (NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender {
    dragExited = NO;
    NSPasteboard *pasteboard = sender.draggingPasteboard;
    NSArray *types = pasteboard.types;
    if ([types containsObject:NSPasteboardTypeFileURL]) {
        NSArray *items = pasteboard.pasteboardItems;
        for (NSPasteboardItem *item in items) {
            NSString *path = [item stringForType:NSPasteboardTypeFileURL];
            NSString *str = [NSURL URLWithString:path].path;
            if ([str hasSuffix:@".car"]) {
                return NSDragOperationCopy;
            }
        }
    }
    return NSDragOperationNone;
}

- (void)draggingExited:(id<NSDraggingInfo>)sender {
    dragExited = YES;
}

- (void)draggingEnded:(id<NSDraggingInfo>)sender {
    if (dragExited) {
        return;
    }
    NSPasteboard *pasteboard = sender.draggingPasteboard;
    NSArray *types = pasteboard.types;
    if ([types containsObject:NSPasteboardTypeFileURL]) {
        NSArray *items = pasteboard.pasteboardItems;
        if (items.count == 1) {
            NSPasteboardItem *item = items.firstObject;
            NSString *path = [item stringForType:NSPasteboardTypeFileURL];
            NSString *filePath = [NSURL URLWithString:path].path;
            if (!filePath) {
                return;
            }
            if (self.dragEndBlock) {
                self.dragEndBlock(filePath);
            }
        }
    } else {
        NSAlert *alert = [[NSAlert alloc] init];
        alert.messageText = @"只能拖一个.car文件";
        [alert runModal];
    }
}

@end

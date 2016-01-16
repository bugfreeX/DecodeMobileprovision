//
//  ZXDragView.m
//  DecodeMobileprovision
//
//  Created by FreeGeek on 16/1/11.
//  Copyright © 2016年 ZhongXi. All rights reserved.
//

#import "ZXDragView.h"

@implementation ZXDragView
{
    BOOL _draggingEntered;
}
-(instancetype)initWithFrame:(NSRect)frameRect
{
    self = [super initWithFrame:frameRect];
    if (self) {
        [self registerForDraggedTypes:@[NSFilenamesPboardType]];
    }
    return self;
}

#pragma NSDraggingDestination Methods

- (NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender
{
    [self setNeedsDisplay:YES];
    return NSDragOperationCopy;
}

-(void)draggingExited:(id<NSDraggingInfo>)sender
{
    [self setNeedsDisplay:YES];
}

-(void)draggingEnded:(id<NSDraggingInfo>)sender
{
    [self setNeedsDisplay:YES];
}

-(BOOL)performDragOperation:(id<NSDraggingInfo>)sender
{
    NSPasteboard * pasteboard = [sender draggingPasteboard];
    if ([[pasteboard types] containsObject:NSFilenamesPboardType]) {
        NSArray * items = [pasteboard propertyListForType:NSFilenamesPboardType];
        if ([self.delegate respondsToSelector:@selector(dragView:didDragItem:)]) {
            [self.delegate dragView:self didDragItem:[items lastObject]];
        }
        return YES;
    }
    return NO;
}

@end

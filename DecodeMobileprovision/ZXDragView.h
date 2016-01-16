//
//  ZXDragView.h
//  DecodeMobileprovision
//
//  Created by FreeGeek on 16/1/11.
//  Copyright © 2016年 ZhongXi. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class ZXDragView;
@protocol ZXDragViewDelegate <NSObject>
-(void)dragView:(ZXDragView *)dragView didDragItem:(NSString *)item;
@end

@interface ZXDragView : NSImageView<NSDraggingDestination>
@property (nonatomic , assign) id<ZXDragViewDelegate> delegate;
@end

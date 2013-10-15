//
//  AnswerSheetView.h
//  DSIC
//
//  Created by 孟 智 on 13-10-15.
//  Copyright (c) 2013年 孟 智. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSAppDelegate.h"

@class AnswerSheetView;

@protocol answerSheetViewDelegate

- (void)answerSheetView:(AnswerSheetView *)answerSheetView sheetDidTouch:(int)index touchSide:(int)touchSide;

@end


@interface AnswerSheetView : UIView
@property (nonatomic, assign) int index;
@property (assign) id <answerSheetViewDelegate> delegate;
@property (nonatomic, strong) UIView *answerSheetHeader;
@property (nonatomic, strong) UIView *answerSheetBody;
@property (nonatomic, strong) UIView *answerSheetFooter;
- (id)initWithTitle:(NSString *)title withDataSource:(NSDictionary *)dataSource withFrame:(CGRect)frame;
@end

//
//  AnswerSheetView.h
//  DSIC
//
//  Created by 孟 智 on 13-10-15.
//  Copyright (c) 2013年 孟 智. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSAppDelegate.h"

typedef NS_ENUM(NSInteger, LSAnswerSheetSide) {
    LSAnswerSheetSideNone,
    LSAnswerSheetSideLeft,
    LSAnswerSheetSideRight,
};

@class AnswerSheetView;


@protocol answerSheetViewDelegate<NSObject>

- (void)answerSheetView:(AnswerSheetView *)answerSheetView sheetDidTouch:(int)index touchSide:(int)touchSide;
- (NSInteger) switchToCurrentPageIndex;

@end


@protocol answerSheetViewDataSource <NSObject>

- (NSMutableDictionary *)answerSheetView:(AnswerSheetView *)answerSheetView;

@end


@interface AnswerSheetView : UIView
@property (nonatomic, assign) int index;
@property (nonatomic,weak) id <answerSheetViewDelegate> delegate;
@property(nonatomic,weak) id<answerSheetViewDataSource> dataSource;
@property (nonatomic, strong) UIView *answerSheetHeader;
@property (nonatomic, strong) UIView *answerSheetBody;
@property (nonatomic, strong) UIView *answerSheetFooter;

- (id)initWithTitle:(NSString *)title  withFrame:(CGRect)frame;
- (void)configWithDataSheetByIndex:(NSInteger)index;
@end

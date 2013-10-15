//
//  AnswerSheetView.m
//  DSIC
//
//  Created by 孟 智 on 13-10-15.
//  Copyright (c) 2013年 孟 智. All rights reserved.
//

#import "AnswerSheetView.h"
@interface AnswerSheetView()
@property(nonatomic,strong) UIView *overlay1;
@property(nonatomic,strong) UIView *overlay2;
@property(nonatomic) LSAppDelegate *appDelegate;
@property(nonatomic,strong) NSDictionary *dataSource;

@end


@implementation AnswerSheetView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self baseInit];
    }
    return self;
}

- (id)initWithTitle:(NSString *)title withDataSource:(NSDictionary *)dataSource withFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self baseInit];
        if ([title isEqualToString:@""]) {
            [self changeTitleContent:[NSString stringWithFormat:@"共20题，当前是第%d题",self.index]];
        } else {
            [self changeTitleContent:title];
        }
        //填充数据
        NSMutableArray *toShowData = [[NSMutableArray alloc]init] ;
        
        for (id key in dataSource) {
            NSDictionary *item = [dataSource objectForKey:key];
            NSNumber *itemId = [item objectForKey:@"id"];
            if ([itemId intValue]/100 == self.index) {
                [toShowData addObject:item];
            }
        }
        
        [self fillInDataToAnswerSheet:toShowData];

    }
    return self;
}

- (void)baseInit
{
    self.index = 1;
    //初始化触摸覆盖层
    self.overlay1 = [[UIView alloc]init];
    self.overlay2 = [[UIView alloc]init];
    //获取LSApplicationDelegate
    self.appDelegate = [[UIApplication sharedApplication]delegate];
    //绘制答题卡头部
    [self drawAnswerHeader];
    //绘制答题选项
    [self drawAnswerSheet];
    
}

- (void)drawAnswerHeader
{
    self.answerSheetHeader = [[UIView alloc]initWithFrame:CGRectMake(20,68,280,37)];
    UILabel *labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.answerSheetHeader.frame.size.width, self.answerSheetHeader.frame.size.height)];
    [labelTitle setBackgroundColor:[UIColor colorWithRed:0.1f green:0.1f blue:0.8f alpha:1]];
    [labelTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [labelTitle setTextColor:[UIColor whiteColor]];
    [labelTitle setTextAlignment:NSTextAlignmentCenter];
    [self.answerSheetHeader addSubview:labelTitle];
    [self addSubview:self.answerSheetHeader];
}

- (void)drawAnswerSheet
{
    self.answerSheetBody = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 360)];
    for (NSInteger i=0; i<4; i++) {
        UIView *answerSheetLayer = [[UIView alloc]initWithFrame:CGRectMake(self.frame.origin.x+20, self.frame.origin.y+90+60*(i+1), 280, 50)];
        [answerSheetLayer setBackgroundColor:[UIColor whiteColor]];
        [[answerSheetLayer layer] setShadowRadius:6];
        [[answerSheetLayer layer] setShadowOffset:CGSizeMake(1, 1)];
        
        [[answerSheetLayer layer] setShadowOpacity:0.1];
        [[answerSheetLayer layer] setShadowColor:[UIColor whiteColor].CGColor];
        UILabel *label = [[UILabel alloc]initWithFrame:answerSheetLayer.bounds];
        [label setText:@"未获取数据"];
        [label setFont:[UIFont boldSystemFontOfSize:18]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setUserInteractionEnabled:YES];
        [label setTag:0];
        
        
        [answerSheetLayer addSubview:label];
        [self.answerSheetBody addSubview:answerSheetLayer];
    }
    [self addSubview:self.answerSheetBody];
    
}

- (void)changeTitleContent:(NSString *)stringTitle
{
    UILabel *titleLabel = [self.answerSheetHeader.subviews objectAtIndex:0];
    titleLabel.text = stringTitle;
}

- (void)fillInDataToAnswerSheet:(NSArray *)data
{
    NSArray *subviews = self.answerSheetBody.subviews;
    
    for (NSInteger i=0; i<4; i++) {
        NSDictionary *answerSheet = [data objectAtIndex:i];
        UILabel *label = [[[subviews objectAtIndex:i] subviews] objectAtIndex:0];
        [label setText:[answerSheet objectForKey:@"name"]];
        [label setTag:[[answerSheet objectForKey:@"id"] integerValue]];
        UITapGestureRecognizer *rec = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapAnswerSheet:)];
        
        [label addGestureRecognizer:rec];
    }
}

- (void)TapAnswerSheet:(UITapGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateRecognized) {
        CGPoint point = [recognizer locationInView:recognizer.view];
        NSString *key = [NSString stringWithFormat:@"%d",recognizer.view.tag];
        NSString *questionIndexString = [NSString stringWithFormat:@"%d",self.index];
        NSMutableDictionary *temp = [self.appDelegate.result objectForKey:questionIndexString];
        NSMutableDictionary *newDict;
        if (point.x <= 140) {
            CGRect frame = recognizer.view.frame;
            frame.size.width = frame.size.width/2;
            if ((self.overlay2 == nil)  ||  (self.overlay2 != nil && self.overlay2.superview != recognizer.view)) {
                [self drawOverLayInFrame:frame parentView:recognizer.view type:1];
                newDict = [NSMutableDictionary dictionaryWithObject:key forKey:@"always"];
            }
            
        }else{
            CGRect frame = recognizer.view.frame;
            frame.size.width = frame.size.width/2;
            frame.origin.x = frame.origin.x + frame.size.width;
            if ((self.overlay1 == nil)  ||  (self.overlay1 != nil && self.overlay1.superview != recognizer.view)) {
                [self drawOverLayInFrame:frame parentView:recognizer.view type:2];
                newDict = [NSMutableDictionary dictionaryWithObject:key forKey:@"noalways"];
            }
        }
        if (newDict) {
            if (temp) {
                [temp addEntriesFromDictionary:newDict];
                newDict = temp;
            }
            [self.appDelegate.result setObject:newDict forKey:questionIndexString];
        }
    }
}

- (void) drawOverLayInFrame:(CGRect) frame parentView:(UIView *)parentView type:(int)type
{
    if (type == 1) {
        [self.overlay1 removeFromSuperview];
        [self.overlay1 setAlpha:1.0];
        frame.origin.y = frame.size.height-2.0f;
        frame.size.height = 2.0f;
        [self.overlay1 setFrame:frame];
        [self.overlay1 setBackgroundColor:[UIColor colorWithRed:0.8f green:0.1f blue:0.1f alpha:1.0f]];
        [parentView addSubview:self.overlay1];
    } else {
        [self.overlay2 removeFromSuperview];
        [self.overlay2 setAlpha:1.0];
        frame.origin.x = frame.origin.x;
        frame.origin.y = frame.size.height-2.0f;
        frame.size.height = 2.0f;
        [self.overlay2 setFrame:frame];
        [self.overlay2 setBackgroundColor:[UIColor colorWithRed:0.8f green:0.5f blue:0.1f alpha:1.0f]];
        [parentView addSubview:self.overlay2];
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

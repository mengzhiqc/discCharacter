//
//  QuestionsViewController.h
//  DSIC
//
//  Created by 孟 智 on 13-9-2.
//  Copyright (c) 2013年 孟 智. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "AnswerSheetView.h"
#import "Discdb.h"


@interface LSQuestionsViewController : UIViewController<answerSheetViewDelegate, answerSheetViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property(nonatomic,strong) LSAppDelegate *appDelegate;

@end

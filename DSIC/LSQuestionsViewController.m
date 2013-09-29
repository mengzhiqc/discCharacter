//
//  QuestionsViewController.m
//  DSIC
//
//  Created by 孟 智 on 13-9-2.
//  Copyright (c) 2013年 孟 智. All rights reserved.
//

#import "LSQuestionsViewController.h"
#import "LSResultViewController.h"
#import "LSAppDelegate.h"
#define TAG_BLOCK_WIDTH 10;
#define LAST_QUESTION 24;

@interface LSQuestionsViewController ()
@property(nonatomic) NSInteger questionIndex;
@property(nonatomic,strong) NSDictionary *dataSource;
@property(nonatomic,strong) UIView *overlay1,*overlay2;
@property(nonatomic,weak) UIButton *preButton,*nextButton;
@property(nonatomic,strong) UIView *answerSheetContainer;
@property(nonatomic,strong) UIBarButtonItem *showResultButton;
@property(nonatomic) LSAppDelegate *appDelegate;
@end

@implementation LSQuestionsViewController
@synthesize questionIndex,titleLabel,dataSource,overlay1,overlay2,answerSheetContainer,appDelegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
    // Do any additional setup after loading the view from its nib.
    appDelegate = [[UIApplication sharedApplication]delegate];

    self.title = @"性格测试";
    questionIndex = 1;
    dataSource = [self fetchDiscDataSource];
    [self drawShowResultButton];
    [self drawAnswerSheet];
    [self refreshQuestion:1];
    [self drawNextQuestionButton];

}

- (void)setup
{
    CGRect frame = self.view.frame;
    frame.size.width /= 2;
    frame.origin.y = self.navigationController.navigationBar.frame.size.height;

    CGRect frame2 = frame;
    frame2.origin.x = frame.size.width;
    
    UIView *leftBackgroundView = [[UIView alloc]initWithFrame:frame];
    [leftBackgroundView setBackgroundColor:[UIColor colorWithRed:0.9f green:0.9f blue:0.9f alpha:0.5f]];
    [self.view addSubview:leftBackgroundView];
    
    UIView *rightBackgroundView = [[UIView alloc]initWithFrame:frame2];
    [rightBackgroundView setBackgroundColor:[UIColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:0.5f]];
    [self.view addSubview:rightBackgroundView];
    
    //redraw question title label
    [titleLabel setBackgroundColor:[UIColor colorWithRed:0.1f green:0.1f blue:0.8f alpha:1]];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    overlay1 = [[UIView alloc]init];
    overlay2 = [[UIView alloc]init];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"QuestionViewController"];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"QuestionViewController"];
    
}


- (void)refreshQuestion:(int)index
{
    if (questionIndex) {
        titleLabel.text = [NSString stringWithFormat:@"共24题，当前是第%d题",questionIndex];
    }
    

    NSMutableArray *toShowData = [[NSMutableArray alloc]init] ;

    for (id key in dataSource) {
        NSDictionary *item = [dataSource objectForKey:key];
        NSNumber *itemId = [item objectForKey:@"id"];
        if ([itemId intValue]/100 == questionIndex) {
            [toShowData addObject:item];
        }
    }
    [overlay1 removeFromSuperview];
    [overlay2 removeFromSuperview];
    [self fillInDataToAnswerSheet:toShowData];
    [self drawShowResultButton];
}

- (void)drawAnswerSheet {
    answerSheetContainer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 360)];
    for (NSInteger i=0; i<4; i++) {
        UIView *answerSheetLayer = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x+20, self.view.frame.origin.y+90+60*(i+1), 280, 50)];
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
        [answerSheetContainer addSubview:answerSheetLayer];
    }
    [self.view addSubview:answerSheetContainer];

}

- (void)drawShowResultButton
{
    if (!self.showResultButton  && [[appDelegate result] count] == 24) {
        self.showResultButton = [[UIBarButtonItem alloc] initWithTitle:@"查看结果" style:UIBarButtonItemStyleBordered target:self action:@selector(completeQuiz:)];
        self.navigationItem.rightBarButtonItem = self.showResultButton;
    }
    
}



- (void)fillInDataToAnswerSheet:(NSArray *)data
{
    NSArray *subviews = answerSheetContainer.subviews;
    
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
        NSString *questionIndexString = [NSString stringWithFormat:@"%d",questionIndex];
        NSMutableDictionary *temp = [appDelegate.result objectForKey:questionIndexString];
        NSMutableDictionary *newDict;
        if (point.x <= 140) {
            CGRect frame = recognizer.view.frame;
            frame.size.width = frame.size.width/2;
            if ((overlay2 == nil)  ||  (overlay2 != nil && overlay2.superview != recognizer.view)) {
                [self drawOverLayInFrame:frame parentView:recognizer.view type:1];
                newDict = [NSMutableDictionary dictionaryWithObject:key forKey:@"always"];
            }
            
        }else{
            CGRect frame = recognizer.view.frame;
            frame.size.width = frame.size.width/2;
            frame.origin.x = frame.origin.x + frame.size.width;
            if ((overlay1 == nil)  ||  (overlay1 != nil && overlay1.superview != recognizer.view)) {
                [self drawOverLayInFrame:frame parentView:recognizer.view type:2];
                newDict = [NSMutableDictionary dictionaryWithObject:key forKey:@"noalways"];
            }
        }
        if (newDict) {
            if (temp) {
                [temp addEntriesFromDictionary:newDict];
                newDict = temp;
            }
            [appDelegate.result setObject:newDict forKey:questionIndexString];
        }
    }
}

- (void) drawNextQuestionButton
{
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextButton setFrame:CGRectMake(self.view.frame.origin.x+20,self.view.frame.size.height-self.navigationController.navigationBar.frame.size.height-90, 280, 50)];
    [nextButton setTag:901];
    [nextButton setTitle:@"下一题" forState:UIControlStateNormal];
    [nextButton setBackgroundColor:[UIColor colorWithRed:1.0f green:0.8f blue:0.0f alpha:1.0f]];
    [nextButton layer].cornerRadius = 5.0f;
    [[nextButton layer] setShadowOffset:CGSizeMake(1, 1)];
    [[nextButton layer] setShadowRadius:6];
    [[nextButton layer] setShadowOpacity:0.2];
    [[nextButton layer] setShadowColor:[UIColor blackColor].CGColor];
    
    [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(clickNaviButton:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:nextButton];
}

- (void) drawOverLayInFrame:(CGRect) frame parentView:(UIView *)parentView type:(int)type
{
    if (type == 1) {
        [overlay1 removeFromSuperview];
        [overlay1 setAlpha:1.0];
        frame.origin.y = frame.size.height-2.0f;
        frame.size.height = 2.0f;
        [overlay1 setFrame:frame];
        [overlay1 setBackgroundColor:[UIColor colorWithRed:0.8f green:0.1f blue:0.1f alpha:1.0f]];
        [parentView addSubview:overlay1];
    } else {
        [overlay2 removeFromSuperview];
        [overlay2 setAlpha:1.0];
        frame.origin.x = frame.origin.x;
        frame.origin.y = frame.size.height-2.0f;
        frame.size.height = 2.0f;
        [overlay2 setFrame:frame];
        [overlay2 setBackgroundColor:[UIColor colorWithRed:0.8f green:0.5f blue:0.1f alpha:1.0f]];
        [parentView addSubview:overlay2];
    }
}


- (void) clickNaviButton:(UIButton *)targetObject
{
    int lastQuestion = LAST_QUESTION;
    int showCompleteInt = lastQuestion -1 ;
    if (overlay1.frame.size.width == 0) {
        [[[UIAlertView alloc]initWithTitle:@"提示" message:@"你必须选择一项常有的行为" delegate:Nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil] show];
        return;
    }
    if (overlay2.frame.size.width == 0) {
        [[[UIAlertView alloc]initWithTitle:@"提示" message:@"你必须选择一项不常有的行为" delegate:Nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil] show];
        return;
    }
    if (overlay1.superview == overlay2.superview) {
        [[[UIAlertView alloc]initWithTitle:@"提示" message:@"常有行为和不常有行为不能在同一项" delegate:Nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil] show];
        return;
    }


    
    if (targetObject.tag==900) {
        if (questionIndex > 1) {
            questionIndex -= 1;
        }
        
        if (showCompleteInt == questionIndex) {
            targetObject = (UIButton *)[targetObject.superview viewWithTag:901];
            [targetObject setTitle:@"下一题" forState:UIControlStateNormal];
            [targetObject removeTarget:self action:@selector(completeQuiz:) forControlEvents:UIControlEventTouchDown];
            [targetObject addTarget:self action:@selector(clickNaviButton:) forControlEvents:UIControlEventTouchDown];
        }

        
    } else if  (targetObject.tag == 901) {
        if (questionIndex < lastQuestion) {
            questionIndex += 1;
        }
        if (questionIndex == lastQuestion) {
            [targetObject setTitle:@"完成测试" forState:UIControlStateNormal];
            [targetObject removeTarget:self action:@selector(clickNaviButton:) forControlEvents:UIControlEventTouchDown];
            [targetObject addTarget:self action:@selector(completeQuiz:) forControlEvents:UIControlEventTouchDown];
        }
        
    }
    [overlay1 setFrame:CGRectMake(0, 0, 0, 0)];
    [overlay2 setFrame:CGRectMake(0, 0, 0, 0)];

    
    [self refreshQuestion:questionIndex];
}

- (void)completeQuiz:(id)sender
{
    LSResultViewController *resultController = [[LSResultViewController alloc]initWithNibName:@"LSResultViewController" bundle:Nil];
    [resultController setResult:appDelegate.result];
    [resultController setData:dataSource];
    [self.navigationController pushViewController:resultController animated:YES];
    
}

- (NSDictionary *)fetchDiscDataSource
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"dsicList" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc]initWithContentsOfFile:path];
    return dict;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

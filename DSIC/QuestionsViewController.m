//
//  QuestionsViewController.m
//  DSIC
//
//  Created by 孟 智 on 13-9-2.
//  Copyright (c) 2013年 孟 智. All rights reserved.
//

#import "QuestionsViewController.h"
#import "ResultViewController.h"
#import "AppDelegate.h"
#define TAG_BLOCK_WIDTH 10;
#define LAST_QUESTION 24;

@interface QuestionsViewController ()
@property(nonatomic) NSInteger questionIndex;
@property(nonatomic,strong) NSDictionary *dataSource;
@property(nonatomic,strong) UIView *overlay1,*overlay2;
@property(nonatomic,weak) UIButton *preButton,*nextButton;
@property(nonatomic,strong) UIView *answerSheetContainer;
@property(nonatomic,strong) UIBarButtonItem *showResultButton;
@property(nonatomic) AppDelegate *appDelegate;
@end

@implementation QuestionsViewController
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
    // Do any additional setup after loading the view from its nib.
    appDelegate = [[UIApplication sharedApplication]delegate];

    self.title = @"DISC性格测试";
    [self.view setBackgroundColor:[UIColor colorWithRed:222.0/255.0 green:222.0/255.0 blue:222.0/255.0 alpha:1]];
    questionIndex = 1;
    dataSource = [self fetchDiscDataSource];
    [self drawShowResultButton];
    [self drawAnswerSheet];
    [self refreshQuestion:1];
    [self drawNavigationButton];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
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
            [self drawOverLayInFrame:frame parentView:recognizer.view type:1];
            newDict = [NSMutableDictionary dictionaryWithObject:key forKey:@"always"];
        }else{
            CGRect frame = recognizer.view.frame;
            frame.size.width = frame.size.width/2;
            frame.origin.x = frame.origin.x + frame.size.width;
            [self drawOverLayInFrame:frame parentView:recognizer.view type:2];
            newDict = [NSMutableDictionary dictionaryWithObject:key forKey:@"noalways"];
        }
        if (temp) {
            [temp addEntriesFromDictionary:newDict];
            newDict = temp;
        }
        [appDelegate.result setObject:newDict forKey:questionIndexString];
       
    }
}

- (void) drawNavigationButton
{
    UIView *navigationButtonBackground;
    if (self.view.frame.size.height > 600) {
        navigationButtonBackground = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x+20,self.view.frame.size.height-90, 280, 50)];
    }else{
        navigationButtonBackground = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x+20,self.view.frame.size.height-130, 280, 50)];
    }
    [navigationButtonBackground setBackgroundColor:[UIColor grayColor]];

    UIButton *preButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [preButton setFrame:CGRectMake(0, 0, navigationButtonBackground.frame.size.width/2, navigationButtonBackground.frame.size.height)];
    [preButton setTag:900];
    [preButton setTitle:@"上一题" forState:UIControlStateNormal];
    [preButton setBackgroundColor:[UIColor grayColor]];
    [preButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [preButton addTarget:self action:@selector(clickNaviButton:) forControlEvents:UIControlEventTouchDown];
    //[navigationButtonBackground addSubview:preButton];
    
   
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextButton setFrame:CGRectMake(0, 0, navigationButtonBackground.frame.size.width, navigationButtonBackground.frame.size.height)];
    [nextButton setTag:901];
    [nextButton setTitle:@"下一题" forState:UIControlStateNormal];
    [nextButton setBackgroundColor:[UIColor greenColor]];
    [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(clickNaviButton:) forControlEvents:UIControlEventTouchDown];
    [navigationButtonBackground addSubview:nextButton];
    [self.view addSubview:navigationButtonBackground];
}

- (void) drawOverLayInFrame:(CGRect) frame parentView:(UIView *)parentView type:(int)type
{
    if (type == 1) {
        if (! overlay1) {
            overlay1 = [[UIView alloc]init];
            [[overlay1 layer] setShadowOffset:CGSizeMake(1, 1)];
            [[overlay1 layer] setShadowRadius:6];
            [[overlay1 layer] setShadowOpacity:1];
            [[overlay1 layer] setShadowColor:[UIColor blueColor].CGColor];
            [overlay1 setBackgroundColor:[UIColor grayColor]];
            [overlay1 setAlpha:0.5];
        }
        frame.size.width = TAG_BLOCK_WIDTH;
        [overlay1 setFrame:frame];
        
        [parentView addSubview:overlay1];
    } else {
    if (! overlay2) {
        overlay2 = [[UIView alloc]init];
        [[overlay2 layer] setShadowOffset:CGSizeMake(1, 1)];
        [[overlay2 layer] setShadowRadius:6];
        [[overlay2 layer] setShadowOpacity:1];
        [[overlay2 layer] setShadowColor:[UIColor blueColor].CGColor];
        [overlay2 setBackgroundColor:[UIColor greenColor]];
        [overlay2 setAlpha:0.5];
    }
    frame.origin.x = frame.origin.x + frame.size.width-TAG_BLOCK_WIDTH;
    frame.size.width = TAG_BLOCK_WIDTH;
    [overlay2 setFrame:frame];

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
    ResultViewController *resultController = [[ResultViewController alloc]initWithNibName:@"ResultViewController" bundle:Nil];
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

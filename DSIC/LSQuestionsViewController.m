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
#import "Toast+UIView.h"

#define TAG_BLOCK_WIDTH 10;
#define LAST_QUESTION 24;

@interface LSQuestionsViewController ()
@property(nonatomic,strong) NSDictionary *dataSource;
@property(nonatomic,weak) UIButton *preButton,*nextButton;
@property(nonatomic,strong) UIView *answerSheetContainer;
@property(nonatomic,strong) UIBarButtonItem *showResultButton;
@property(nonatomic) NSInteger index;
@property (nonatomic,strong) AnswerSheetView *answerSheet ;
@property (nonatomic) bool isLeftSelected, isRightSelected;
@end

@implementation LSQuestionsViewController

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

    self.title = @"性格测试";
    self.index = 1;
    self.answerSheet = [[AnswerSheetView alloc]initWithTitle:@""
                                                           withFrame:self.view.frame];
    
    self.answerSheet.delegate = self;
    self.answerSheet.dataSource = self;
    [self.view addSubview:self.answerSheet];
    [self drawNextQuestionButton];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.dataSource = [self fetchDiscDataSource];
    [MobClick beginLogPageView:@"QuestionViewController"];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"QuestionViewController"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark SetUp Methods
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
    [self.titleLabel setBackgroundColor:[UIColor colorWithRed:0.1f green:0.1f blue:0.8f alpha:1]];
    [self.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [self.titleLabel setTextColor:[UIColor whiteColor]];
    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    
}


#pragma mark -
#pragma mark Action And Event Methods

- (void) drawNextQuestionButton
{
    self.nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.nextButton setFrame:CGRectMake(self.view.frame.origin.x+20,self.view.frame.size.height-self.navigationController.navigationBar.frame.size.height-90, 280, 50)];
    [self.nextButton setTag:901];
    [self.nextButton setTitle:@"下一题" forState:UIControlStateNormal];
    [self.nextButton setBackgroundColor:[UIColor colorWithRed:1.0f green:0.8f blue:0.0f alpha:1.0f]];
    [self.nextButton layer].cornerRadius = 5.0f;
    [[self.nextButton layer] setShadowOffset:CGSizeMake(1, 1)];
    [[self.nextButton layer] setShadowRadius:6];
    [[self.nextButton layer] setShadowOpacity:0.2];
    [[self.nextButton layer] setShadowColor:[UIColor blackColor].CGColor];
    
    [self.nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.nextButton addTarget:self action:@selector(switchToNextPage:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.nextButton];
}



- (NSDictionary *)fetchDiscDataSource
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"dsicList" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc]initWithContentsOfFile:path];
    return dict;
}

- (void)switchToNextPage:(id)sender
{
    if (!self.isLeftSelected && !self.isRightSelected) {
        [self.view makeToast:@"请同时选中常有和不常有的行为"];
        
    } else if(self.isLeftSelected && !self.isRightSelected){
        [self.view makeToast:@"请选中不常有的行为"];

    } else if(!self.isLeftSelected && self.isRightSelected) {
        [self.view makeToast:@"请选中常有的行为"];

    }else {
        self.index++;
        if (self.index > 24) {
            LSResultViewController *resultController = [[LSResultViewController alloc]initWithNibName:@"LSResultViewController" bundle:Nil];
            [self.navigationController pushViewController:resultController animated:YES];
        } else {
            if (self.index == 24) {
                [sender setTitle: @"查看结果" forState:UIControlStateNormal];
            }
            [self.answerSheet configWithDataSheetByIndex:self.index];
            self.isLeftSelected = self.isRightSelected = NO;
        }
    }
}

- (BOOL)isTapBothAlwaysAndNoAlways
{
    return self.isLeftSelected && self.isRightSelected;
}






#pragma mark -
#pragma mark AnswerSheetView delegate method

- (void) answerSheetView:(AnswerSheetView *)answerSheetView sheetDidTouch:(int)index touchSide:(int)touchSide
{
    NSDictionary *charactorMapper = @{@"O":@"1",@"@":@"2",@"V":@"3",@"#":@"4"};
    NSDictionary *discItem = [self.dataSource objectForKey:[NSString stringWithFormat:@"%d",index]];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Discdb" inManagedObjectContext:self.appDelegate.managedObjectContext];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id==%d",index/100];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedItems = [self.appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (error) {
        NSLog(@"save:%@",[error description]);

    }

    Discdb *item;
    if ([fetchedItems count] > 0) {
        item = [fetchedItems lastObject];
    }else{
        item = [NSEntityDescription insertNewObjectForEntityForName:@"Discdb" inManagedObjectContext:self.appDelegate.managedObjectContext];
        [self.appDelegate.managedObjectContext insertObject:item];

    }
    
    
    item.id = [NSNumber numberWithInt:index/100];
    item.name = [discItem objectForKey:@"name"];
    if (touchSide == LSAnswerSheetSideLeft) {
        item.always = [charactorMapper objectForKey:[discItem objectForKey:@"value1"]];
        self.isLeftSelected = YES;
    }
    else {
        item.noalways = [charactorMapper objectForKey:[discItem objectForKey:@"value2"]];
        self.isRightSelected = YES;
    }
    NSError *saveError;
    [self.appDelegate.managedObjectContext save:&saveError];
    if (saveError == nil) {
        //NSLog(@"%@ - %@: Page:%@ Has Saved Successfully.",[self class],NSStringFromSelector(_cmd),item.id);
    }
    
    
    
}

- (NSInteger)switchToCurrentPageIndex
{
    return self.index;
}

- (NSDictionary *)answerSheetView:(AnswerSheetView *)answerSheetView
{
    NSDictionary *dict = [self fetchDiscDataSource];
    return dict;
}




- (LSAppDelegate *)appDelegate
{
    if ( _appDelegate == nil ) {
        _appDelegate = [UIApplication sharedApplication].delegate;
    }
    return _appDelegate;
}

@end

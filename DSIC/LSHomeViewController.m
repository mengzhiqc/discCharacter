//
//  MainViewController.m
//  DSIC
//
//  Created by 孟 智 on 13-8-31.
//  Copyright (c) 2013年 孟 智. All rights reserved.
//

#import "LSHomeViewController.h"
#import "LSQuestionsViewController.h"
#import "LSImageUtil.h"

@interface LSHomeViewController ()

@end

@implementation LSHomeViewController
@synthesize enterButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"首页";
        UIImage *bgground = [LSImageUtil scaleImage:[UIImage imageNamed:@"discbg.png"] toScale:0.5];
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:bgground]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [enterButton setBackgroundColor:[UIColor colorWithRed:1.0f green:0.8f blue:0.0f alpha:0.8f]];
    [[enterButton layer] setShadowRadius:6];
    [[enterButton layer] setShadowOffset:CGSizeMake(2, 2)];
    [[enterButton layer] setShadowOpacity:0.6];
    [[enterButton layer] setShadowColor:[UIColor blackColor].CGColor];
    [enterButton layer].cornerRadius = 5.0;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"LSHomeViewController"];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"LSHomeViewController"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)enterAction:(id)sender {
    LSQuestionsViewController *questionViewController = [[LSQuestionsViewController alloc]initWithNibName:@"LSQuestionsViewController" bundle:nil];
    [self.navigationController pushViewController:questionViewController animated:YES];
}

@end

//
//  MoreViewController.m
//  DSIC
//
//  Created by 孟 智 on 13-9-2.
//  Copyright (c) 2013年 孟 智. All rights reserved.
//

#import "LSMoreViewController.h"
#import "LSImageUtil.h"
@interface LSMoreViewController ()

@end

@implementation LSMoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"结果";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[LSImageUtil scaleImage:[UIImage imageNamed:@"disc-result-background.png"] toScale:0.5]]];

    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14],NSFontAttributeName,[NSParagraphStyle defaultParagraphStyle],NSParagraphStyleAttributeName, nil];
    
    CGRect dataFrame = [self.result boundingRectWithSize:CGSizeMake(300, 1000) options:NSLineBreakByWordWrapping|NSStringDrawingUsesLineFragmentOrigin  attributes:attributes context:nil];
    dataFrame.origin.x = 10;
    dataFrame.origin.y = 20;
    dataFrame.size.height += 150;
    UILabel *label = [[UILabel alloc]initWithFrame:dataFrame];

    [label setText:self.result];
    [label setTextColor:[UIColor whiteColor]];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    [scrollView addSubview:label];
    [self.view addSubview:scrollView];

    }

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"LSMoreViewController"];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"LSMoreViewController"];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

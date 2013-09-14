//
//  MoreViewController.m
//  DSIC
//
//  Created by 孟 智 on 13-9-2.
//  Copyright (c) 2013年 孟 智. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()

@end

@implementation MoreViewController

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
    //UIFont *dataFont = [UIFont fontWithName:@"Helvetica" size:14];
    //CGSize dataStringSize = [self.result sizeWithFont:dataFont constrainedToSize:CGSizeMake(300,9999) lineBreakMode:NSLineBreakByWordWrapping];
    //CGRect dataFrame = CGRectMake(10, 10, 300, dataStringSize.height);
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14],NSFontAttributeName,[NSParagraphStyle defaultParagraphStyle],NSParagraphStyleAttributeName, nil];
    
    CGRect dataFrame = [self.result boundingRectWithSize:CGSizeMake(300, 1000) options:NSLineBreakByWordWrapping|NSStringDrawingUsesLineFragmentOrigin  attributes:attributes context:nil];
    dataFrame.origin.x = 10;
    dataFrame.origin.y = 20;
    dataFrame.size.height += 150;
    UILabel *label = [[UILabel alloc]initWithFrame:dataFrame];

    [label setText:self.result];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    [scrollView addSubview:label];
    [self.view addSubview:scrollView];

    }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

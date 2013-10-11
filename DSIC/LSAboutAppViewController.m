//
//  LSAboutAppViewController.m
//  security
//
//  Created by 孟 智 on 13-9-24.
//  Copyright (c) 2013年 孟 智. All rights reserved.
//

#import "LSAboutAppViewController.h"

@interface LSAboutAppViewController ()

@end

@implementation LSAboutAppViewController

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
    UIView *navigationBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)];
    [navigationBar setBackgroundColor:[UIColor colorWithRed:0.8f green:0.2f blue:0 alpha:0.6f]];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(10, 5, 60, 50)];
    [button addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchDown];
    [navigationBar addSubview:button];
    
    [self.view addSubview:navigationBar];
    
    NSString *localHTMLPageName = @"aboutUs";
    NSString *localHTMLPageFilePath = [[NSBundle mainBundle]pathForResource:localHTMLPageName ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:localHTMLPageFilePath encoding:NSUTF8StringEncoding error:nil];
    CGRect frame = self.view.bounds;
    frame.origin.y = 50;
    frame.size.height -= 50;
    UIWebView *webView = [[UIWebView alloc]initWithFrame:frame];
    [webView loadHTMLString:htmlString baseURL:nil];
    
    [self.view addSubview:webView];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backButtonPressed
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

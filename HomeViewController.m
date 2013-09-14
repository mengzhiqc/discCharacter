//
//  MainViewController.m
//  DSIC
//
//  Created by 孟 智 on 13-8-31.
//  Copyright (c) 2013年 孟 智. All rights reserved.
//

#import "HomeViewController.h"
#import "QuestionsViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize enterButton;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"首页";
        UIImage *bgground = [self scaleImage:[UIImage imageNamed:@"discbg.png"] toScale:0.5];
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:bgground]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [enterButton setBackgroundColor:[UIColor colorWithPatternImage:[self scaleImage:[UIImage imageNamed:@"discbutton.png"] toScale:0.5]]];
    [[enterButton layer] setShadowRadius:6];
    [[enterButton layer] setShadowOffset:CGSizeMake(1, 1)];
    [[enterButton layer] setShadowOpacity:0.2];
    [[enterButton layer] setShadowColor:[UIColor blueColor].CGColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)enterAction:(id)sender {
    QuestionsViewController *questionViewController = [[QuestionsViewController alloc]initWithNibName:@"QuestionsViewController" bundle:nil];
    [self.navigationController pushViewController:questionViewController animated:YES];
}
                             
- (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
                                        
}

@end

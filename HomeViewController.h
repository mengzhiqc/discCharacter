//
//  MainViewController.h
//  DSIC
//
//  Created by 孟 智 on 13-8-31.
//  Copyright (c) 2013年 孟 智. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface HomeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *enterButton;
- (IBAction)enterAction:(id)sender;

@end

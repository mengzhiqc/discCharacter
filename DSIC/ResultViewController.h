//
//  ResultViewController.h
//  DSIC
//
//  Created by 孟 智 on 13-9-2.
//  Copyright (c) 2013年 孟 智. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *d1;
@property (weak, nonatomic) IBOutlet UILabel *i1;
@property (weak, nonatomic) IBOutlet UILabel *s1;
@property (weak, nonatomic) IBOutlet UILabel *c1;
@property (weak, nonatomic) IBOutlet UILabel *d2;
@property (weak, nonatomic) IBOutlet UILabel *i2;
@property (weak, nonatomic) IBOutlet UILabel *s2;
@property (weak, nonatomic) IBOutlet UILabel *c2;

@property(nonatomic,strong) NSDictionary *result;
@property(nonatomic,strong) NSDictionary *data;

- (IBAction)findMore:(id)sender;

@end

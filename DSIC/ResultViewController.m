//
//  ResultViewController.m
//  DSIC
//
//  Created by 孟 智 on 13-9-2.
//  Copyright (c) 2013年 孟 智. All rights reserved.
//

#import "ResultViewController.h"
#import "MoreViewController.h"

@interface ResultViewController ()

@end

@implementation ResultViewController
@synthesize data,result;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"测试结果";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self calculateData];
    
}

- (void) calculateData
{
    NSMutableArray *always = [[NSMutableArray alloc]init];
    NSMutableArray *noalways = [[NSMutableArray alloc]init];
    for (id key in result) {
        NSDictionary *item = [result objectForKey:key];
        NSString *alwaysItem = [item objectForKey:@"always"];
        NSString *noalwaysItem = [item objectForKey:@"noalways"];
        if (alwaysItem) {
            [always addObject:alwaysItem];
        }
        if (noalwaysItem) {
            [noalways addObject:noalwaysItem];
        }
    }
    
    
    NSMutableArray *work = [[NSMutableArray alloc]init];
    NSMutableArray *personal = [[NSMutableArray alloc]init];
    
    for (id key in data) {
        NSDictionary *item = [data objectForKey:key];
        NSNumber *itemId = [item objectForKey:@"id"];
        NSString *itemIdString = [NSString stringWithFormat:@"%@",itemId];
        NSString *sigValue = [item objectForKey:@"value1"];
        for (NSString *item1 in always) {
            if ([item1 isEqualToString:itemIdString]) {
                [work addObject:sigValue];
            }
        }
        for (NSString *item2 in noalways) {
            if ([item2 isEqualToString:itemIdString]) {
                [personal addObject:sigValue];
            }
        }
    }
    NSLog(@"always:%@ \n noalways %@",work ,personal);
    
    int d1 = 0;
    int i1 = 0;
    int s1 = 0;
    int c1 = 0;
    int d2 = 0;
    int i2 = 0;
    int s2 = 0;
    int c2 = 0;
   
    NSMutableArray *workResult = [[NSMutableArray alloc]init];
    NSMutableArray *personalResult = [[NSMutableArray alloc]init];

    for (NSString *item3 in work) {
        if ([item3 isEqualToString:@"O"]) {
            d1++;
        }
        if ([item3 isEqualToString:@"@"]) {
            i1++;

        }
        if ([item3 isEqualToString:@"V"]) {
            s1++;
        }
        if ([item3 isEqualToString:@"#"]) {
            c1++;
        }
        
    }
    [workResult addObject:[NSNumber numberWithInt:d1]];
    [workResult addObject:[NSNumber numberWithInt:i1]];
    [workResult addObject:[NSNumber numberWithInt:s1]];
    [workResult addObject:[NSNumber numberWithInt:c1]];

    
    for (NSString *item4 in personal) {
        if ([item4 isEqualToString:@"O"]) {
            d2++;
        }
        if ([item4 isEqualToString:@"@"]) {
            i2++;
        }
        if ([item4 isEqualToString:@"V"]) {
            s2++;
        }
        if ([item4 isEqualToString:@"#"]) {
            c2++;
        }
        
    }
    [personalResult addObject:[NSNumber numberWithInt:d2]];
    [personalResult addObject:[NSNumber numberWithInt:i2]];
    [personalResult addObject:[NSNumber numberWithInt:s2]];
    [personalResult addObject:[NSNumber numberWithInt:c2]];

    NSDictionary *resultDict = [NSDictionary dictionaryWithObjectsAndKeys:workResult,@"1",personalResult,@"2", nil];
    [self drawResultPic:resultDict];

}

-(void) drawResultPic:(NSDictionary *)resultDict
{
    NSArray *labelName = [NSArray arrayWithObjects:@"D(指挥者)",@"I(社交者)",@"S(支持者)",@"C(思考着)", nil];
    UIView *layoutView = [[UIView alloc]initWithFrame:CGRectMake(0, 45, 320, 480)];
    int j = 0;
    for (NSString *key in resultDict) {
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 30+j*160, 100, 30)];
        [titleLabel setFont:[UIFont boldSystemFontOfSize:25]];
        [titleLabel setTintColor:[UIColor blackColor]];
        if ([key isEqualToString:@"1"]) {
            [titleLabel setText:@"工作"];
        }else {
            [titleLabel setText:@"本我"];
        }
        [layoutView addSubview:titleLabel];
        NSArray *groupData = [resultDict objectForKey:key];
        
        for (int i=0;i<4;i++){
            int score;
            if (groupData && [groupData count]>i) {
                score = [[groupData objectAtIndex:i] intValue];
            }else{
                score = 0;
            }
//            if ([key isEqualToString:@"2"]) {
//                score = 20 - score;
//            }
            UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 40+(i+1)*30+j*160, 75, 20)];
            [label1 setText:[labelName objectAtIndex:i]];
            [label1 setTextColor:[UIColor blackColor]];
            
            [label1 setFont:[UIFont systemFontOfSize:16]];
            [layoutView addSubview:label1];
            
            
            UIView * pillar = [[UIView alloc]initWithFrame:CGRectMake(label1.frame.origin.x+label1.frame.size.width+5, 40+(i+1)*30+160*j, score*10, 20)];
            [pillar setBackgroundColor:[UIColor colorWithRed:1.0*(float)score/20.0 green:0 blue:0.4 alpha:1]];
            [layoutView addSubview:pillar];
            
            UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(pillar.frame.origin.x+pillar.frame.size.width+5, 40+(i+1)*30+160*j, 30, 20)];
            [label2 setText:[NSString stringWithFormat:@"%d",score]];
            [label2 setTextColor:[UIColor blackColor]];
            [layoutView addSubview:label2];
        }
        j++;
    }
    
    [self.view addSubview:layoutView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)findMore:(id)sender {
    MoreViewController *more = [[MoreViewController alloc]initWithNibName:@"MoreViewController" bundle:Nil];
    [self.navigationController pushViewController:more animated:YES];
}
@end

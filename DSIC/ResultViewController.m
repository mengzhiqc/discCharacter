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
@property(nonatomic,strong) NSMutableArray *finnalScore;
@property(nonatomic,retain) NSString *analysisResult;
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
    [self showAnalysis];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"ResultViewController"];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"ResultViewController"];
    
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

- (NSDictionary *) convertResultToRealValueRules {
    NSDictionary *rules = @{@"1":@[
                            @{@"0":@1,@"1":@1,@"2":@2,@"3":@2,@"4":@2,@"5":@3,@"6":@3,@"7":@4,@"8":@5,@"9":@5,@"10":@6,@"11":@6,@"12":@6,@"13":@6,@"14":@6,@"15":@7,@"16":@7,@"17":@7,@"18":@7,@"19":@7,@"20":@7},
                            @{@"0":@1,@"1":@1,@"2":@2,@"3":@3,@"4":@4,@"5":@4,@"6":@5,@"7":@6,@"8":@6,@"9":@7,@"10":@7,@"11":@7,@"12":@7,@"13":@7,@"14":@7,@"15":@7,@"16":@7,@"17":@7,@"18":@7,@"19":@7,@"20":@7},
                            @{@"0":@1,@"1":@2,@"2":@2,@"3":@3,@"4":@3,@"5":@4,@"6":@4,@"7":@5,@"8":@5,@"9":@6,@"10":@6,@"11":@7,@"12":@7,@"13":@7,@"14":@7,@"15":@7,@"16":@7,@"17":@7,@"18":@7,@"19":@7,@"20":@7},
                            @{@"0":@1,@"1":@2,@"2":@2,@"3":@3,@"4":@4,@"5":@5,@"6":@6,@"7":@6,@"8":@7,@"9":@7,@"10":@7,@"11":@7,@"12":@7,@"13":@7,@"14":@7,@"15":@7,@"16":@7,@"17":@7,@"18":@7,@"19":@7,@"20":@7},
                                  ],
                            @"2":@[
                            @{@"0":@7,@"1":@7,@"2":@6,@"3":@5,@"4":@5,@"5":@4,@"6":@4,@"7":@3,@"8":@3,@"9":@3,@"10":@2,@"11":@2,@"12":@2,@"13":@2,@"14":@1,@"15":@1,@"16":@1,@"17":@1,@"18":@1,@"19":@1,@"20":@1},
                            @{@"0":@7,@"1":@7,@"2":@6,@"3":@5,@"4":@4,@"5":@4,@"6":@3,@"7":@2,@"8":@2,@"9":@1,@"10":@1,@"11":@1,@"12":@1,@"13":@1,@"14":@1,@"15":@1,@"16":@1,@"17":@1,@"18":@1,@"19":@1,@"20":@1},
                            @{@"0":@7,@"1":@7,@"2":@7,@"3":@7,@"4":@6,@"5":@5,@"6":@4,@"7":@4,@"8":@3,@"9":@2,@"10":@2,@"11":@1,@"12":@1,@"13":@1,@"14":@1,@"15":@1,@"16":@1,@"17":@1,@"18":@1,@"19":@1,@"20":@1},
                            @{@"0":@7,@"1":@7,@"2":@7,@"3":@7,@"4":@6,@"5":@5,@"6":@5,@"7":@4,@"8":@3,@"9":@2,@"10":@2,@"11":@1,@"12":@1,@"13":@1,@"14":@1,@"15":@1,@"16":@1,@"17":@1,@"18":@1,@"19":@1,@"20":@1}]
                            };
    return rules;
    
}

-(void) drawResultPic:(NSDictionary *)resultDict
{
    self.finnalScore = [[NSMutableArray alloc]init];

    NSArray *labelName = [NSArray arrayWithObjects:@"D(指挥者)",@"I(社交者)",@"S(支持者)",@"C(思考着)", nil];
    UIView *layoutView = [[UIView alloc]initWithFrame:CGRectMake(0, 45, 320, 480)];
    NSDictionary *rules = [self convertResultToRealValueRules];
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
        NSArray *groupRules = [rules objectForKey:key];
        for (int i=0;i<4;i++){
            int score;
            if (groupData && [groupData count]>i) {
                NSDictionary *mapRules = [groupRules objectAtIndex:i];
                NSString *scoreString = [NSString stringWithFormat:@"%@",[groupData objectAtIndex:i]];
                score = [[mapRules objectForKey:scoreString ] intValue];
            }else{
                score = 0;
            }
            [self.finnalScore addObject:[NSNumber numberWithInt:score]];
            UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 40+(i+1)*30+j*160, 75, 20)];
            [label1 setText:[labelName objectAtIndex:i]];
            [label1 setTextColor:[UIColor blackColor]];
            
            [label1 setFont:[UIFont systemFontOfSize:16]];
            [layoutView addSubview:label1];
            
            
            UIView * pillar = [[UIView alloc]initWithFrame:CGRectMake(label1.frame.origin.x+label1.frame.size.width+5, 40+(i+1)*30+160*j, score*29, 20)];
            [pillar setBackgroundColor:[UIColor colorWithRed:1.0*(float)score/7.0 green:0 blue:0.4 alpha:1]];
            [layoutView addSubview:pillar];
            
            UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(pillar.frame.origin.x+pillar.frame.size.width+5, 40+(i+1)*30+160*j, 30, 20)];
            [label2 setText:[NSString stringWithFormat:@"%d",score]];
            [label2 setTextColor:[UIColor blackColor]];
            [layoutView addSubview:label2];
        }
        j++;
    }
    
    [self.view addSubview:layoutView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"结果分析" forState:UIControlStateNormal ];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor colorWithPatternImage:[self scaleImage:[UIImage imageNamed:@"discbutton.png"] toScale:0.5]]];
    [button addTarget:self action:@selector(clickToAnalysisResult) forControlEvents:UIControlEventTouchDown];
    [button setFrame:CGRectMake(55, self.view.frame.size.height-130, 210, 50)];
    [self.view addSubview:button];

}

- (void) showAnalysis {
    NSMutableArray *analysisWords = [[NSMutableArray alloc]init];
    NSMutableArray *additionWords = [[NSMutableArray alloc]init];
    //工作中 和 本我的D
    int d1 = [[self.finnalScore objectAtIndex:0] intValue];
    int d2 = [[self.finnalScore objectAtIndex:4] intValue];
    int i1 = [[self.finnalScore objectAtIndex:1] intValue];
    int i2 = [[self.finnalScore objectAtIndex:5] intValue];
    int s1 = [[self.finnalScore objectAtIndex:2] intValue];
    int s2 = [[self.finnalScore objectAtIndex:6] intValue];
    int c1 = [[self.finnalScore objectAtIndex:3] intValue];
    int c2 = [[self.finnalScore objectAtIndex:7] intValue];
    
    if (d1 == 7) {
        [analysisWords addObject:@"\t你在工作中是一个指挥者，外向，乐观，是一个行动派，做事情想尽快取得结果，勇于接受挑战并且能够迅速做出决策，对现有的现象也会有自己的态度，能够有效的处理麻烦，克服重重的困难。"];
    } else if (d1>4 && d1 < 7) {
        [analysisWords addObject:@"\t你在工作中的性格偏力量型，比较乐观，内心也有接受挑战的冲动，有很好的执行力，想到了就会立即去行动起来。"];
    }
    
    if (i1 == 7) {
        [analysisWords addObject:@"\t职场上，你是一个名副其实的社交者，外向，多话，喜欢不停的参与到别人的圈子中，并且总能够给别人留下较好的印象，你善于语言表达，创造热情，做什么事情都会以一颗积极的态度去面对，你喜欢并且会竭力创造热情且富有激励性的环境，你会是你的圈子里更容易被记住的那群人。"];
    } else if (i1 >4 && i1 < 7) {
        [analysisWords addObject:@"\t职场上，你性格活泼，喜欢参加团队的各种活动，外向而又多话，乐于联系他人，善于表达和沟通，心态积极，你是你那个圈子里特别讨人喜欢的几个人之一，别人愿意与你分享，敞开心扉。"];
    }
    
    if (s1 == 7) {
        [analysisWords addObject:@"\t日常工作中，你表现得极其稳健，性格内向，经常会以一个旁观者的视角很好的看待问题，你表现平稳，同时也充满着耐心，当别人跟你交流的时候，你更加愿意静下心来倾听，冷静分析后给别人足够的建议，你的性格决定你可以在你的专业领域挖掘很深，好好加油吧。"];
    } else if (s1 >4 && s1 < 7) {
        [analysisWords addObject:@"\t日常工作中你很沉稳，看起来比较内向，经常回去旁观，表现稳定，无大起大落，富有耐心，善于倾听，专注专业技术的提升，乐于助人。你是个忠实可靠的人，乐于创造稳定和谐的工作环境。"];
    }
    
    if (c1 == 7) {
        [analysisWords addObject:@"\t工作中的你是一个思考者，不会一味的往前冲而迷失了自己的方向，你乐于关注方针和标准，对细节的关注程度足以让你的朋友们惊叹，你思维非常严谨，能够很冷静的看待事情的利弊，对待冲突，你总是可以想到间接的方式去解决，而且，你在系统的考虑方法和解决方案方面似乎有着独特的天赋。"];
    } else if (c1 >4 && c1 < 7) {
        [analysisWords addObject:@"\t工作中的你喜爱思考，性格内向，有时会让别人觉得悲观，你关注方针和标准，注重细节的准确性，思维严谨，权衡利弊，善于以柔克刚，考虑方法比较系统。"];
    }
    
    if (abs(d1-d2) >= 3 || abs(i1-i2)>=3 || abs(s1-s2)>=3 || abs(c1-c2)>=3) {
        [additionWords addObject:@"\t看看本我吧，真实的你的表现可能跟工作中的你表现得不一样，你可能在失意，现在的工作没能给你一个很好发挥你优势的机会；或者在突破，在工作中不停的突破自己本身的一些极限。人生本身就是一个态度，保持积极的心态，如果失意了，跟老板沟通一下，没什么大不了，如果突破，相信你的朋友，你的亲人最愿意看到你的表现，最重要的是，你要相信你自己，未来的你，一定能实现自己心中的梦想。"];
    }
    self.analysisResult = [NSString stringWithFormat:@"%@ %@",[analysisWords componentsJoinedByString:@"\n"],[additionWords componentsJoinedByString:@"\n"]];
    
    
    
}

- (void) clickToAnalysisResult{
    MoreViewController *moreController = [[MoreViewController alloc]initWithNibName:@"MoreViewController" bundle:Nil];
    [moreController setResult:self.analysisResult];
    [self.navigationController pushViewController:moreController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

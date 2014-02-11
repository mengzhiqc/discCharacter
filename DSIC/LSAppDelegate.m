//
//  AppDelegate.m
//  DSIC
//
//  Created by 孟 智 on 13-8-31.
//  Copyright (c) 2013年 孟 智. All rights reserved.
//

#import "LSAppDelegate.h"
#import "LSHomeViewController.h"
#import "LSAboutAppViewController.h"

static NSString *NOT_FIRST_LAUNCH_TAG = @"firstNotLaunch";
static BOOL DEBUG_MODULE = NO;

@implementation LSAppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize result = _result;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    [MobClick startWithAppkey:@"523434a656240bb37a0618bf"];
    
    BOOL isNotFirstTime = [[NSUserDefaults standardUserDefaults] boolForKey:NOT_FIRST_LAUNCH_TAG];
    
    if ( DEBUG_MODULE ){
    isNotFirstTime = NO;
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeBadge)];
    }
    
    if (isNotFirstTime) {
        UINavigationController *navController = [self createNavigationController];
        self.window.rootViewController = navController;
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:NOT_FIRST_LAUNCH_TAG];
        [self createICETutorial];
    }
    
    self.result = [[NSMutableDictionary alloc]init];
    if ( DEBUG_MODULE ){
        [self mockDataForDebug];
    }
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void) mockDataForDebug
{
    NSDictionary *testData = @{
                               @"1":@{@"always":@"103",@"noalways":@"104"},
                               @"10":@{@"always":@"1001",@"noalways":@"1004"},
                               @"11":@{@"always":@"1101",@"noalways":@"1104"},
                               @"12":@{@"always":@"1201",@"noalways":@"1204"},
                               @"13":@{@"always":@"1301",@"noalways":@"1304"},
                               @"14":@{@"always":@"1401",@"noalways":@"1404"},
                               @"15":@{@"always":@"1501",@"noalways":@"1504"},
                               @"16":@{@"always":@"1601",@"noalways":@"1604"},
                               @"17":@{@"always":@"1701",@"noalways":@"1704"},
                               @"18":@{@"always":@"1801",@"noalways":@"1804"},
                               @"19":@{@"always":@"1901",@"noalways":@"1904"},
                               @"2":@{@"always":@"201",@"noalways":@"204"},
                               @"20":@{@"always":@"2001",@"noalways":@"2004"},
                               @"21":@{@"always":@"2101",@"noalways":@"2104"},
                               @"22":@{@"always":@"2201",@"noalways":@"2204"},
                               @"23":@{@"always":@"2301",@"noalways":@"2304"},
                               @"24":@{@"always":@"2401",@"noalways":@"2404"},
                               @"3":@{@"always":@"301",@"noalways":@"304"},
                               @"4":@{@"always":@"401",@"noalways":@"404"},
                               @"5":@{@"always":@"501",@"noalways":@"504"},
                               @"6":@{@"always":@"601",@"noalways":@"604"},
                               @"7":@{@"always":@"701",@"noalways":@"704"},
                               @"8":@{@"always":@"801",@"noalways":@"804"},
                               @"9":@{@"always":@"901",@"noalways":@"904"},
                               };
    self.result = [NSMutableDictionary dictionaryWithDictionary:testData];

}

- (UINavigationController *)createNavigationController
{
    LSHomeViewController *rootController = [[LSHomeViewController alloc]initWithNibName:@"LSHomeViewController" bundle:nil];
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:rootController];
    return navController;
}

- (void)createICETutorial
{
    // Init the pages texts, and pictures.
    ICETutorialPage *layer1 = [[ICETutorialPage alloc] initWithSubTitle:@""
                                                            description:@""
                                                            pictureName:@"background-1739@2x.png"];
    ICETutorialPage *layer2 = [[ICETutorialPage alloc] initWithSubTitle:@""
                                                            description:@""
                                                            pictureName:@"background-1740@2x.png"];
    ICETutorialPage *layer3 = [[ICETutorialPage alloc] initWithSubTitle:@""
                                                            description:@""
                                                            pictureName:@"background-1741@2x.png"];
    
    // Set the common style for SubTitles and Description (can be overrided on each page).
    ICETutorialLabelStyle *subStyle = [[ICETutorialLabelStyle alloc] init];
    [subStyle setFont:TUTORIAL_SUB_TITLE_FONT];
    [subStyle setTextColor:TUTORIAL_LABEL_TEXT_COLOR];
    [subStyle setLinesNumber:TUTORIAL_SUB_TITLE_LINES_NUMBER];
    [subStyle setOffset:TUTORIAL_SUB_TITLE_OFFSET];
    
    ICETutorialLabelStyle *descStyle = [[ICETutorialLabelStyle alloc] init];
    [descStyle setFont:TUTORIAL_DESC_FONT];
    [descStyle setTextColor:TUTORIAL_LABEL_TEXT_COLOR];
    [descStyle setLinesNumber:TUTORIAL_DESC_LINES_NUMBER];
    [descStyle setOffset:TUTORIAL_DESC_OFFSET];
    
    // Load into an array.
    NSArray *tutorialLayers = @[layer1,layer2,layer3];
    
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.viewController = [[ICETutorialController alloc] initWithNibName:@"ICETutorialController_iPhone"
                                                                      bundle:nil
                                                                    andPages:tutorialLayers];
    } else {
        self.viewController = [[ICETutorialController alloc] initWithNibName:@"ICETutorialController_iPad"
                                                                      bundle:nil
                                                                    andPages:tutorialLayers];
    }
    self.viewController.autoScrollEnabled = FALSE;
    
    
    // Set the common styles, and start scrolling (auto scroll, and looping enabled by default)
    [self.viewController setCommonPageSubTitleStyle:subStyle];
    [self.viewController setCommonPageDescriptionStyle:descStyle];
    
    
    // Set button 1 action.
    __unsafe_unretained typeof(self) weakSelf = self;
    [self.viewController setButton1Block:^(UIButton *button){
        LSAboutAppViewController *aboutApp = [[LSAboutAppViewController alloc]initWithNibName:@"LSAboutAppViewController" bundle:nil];
        [weakSelf.viewController presentViewController:aboutApp animated:YES completion:nil];
    }];
    
    // Set button 2 action, stop the scrolling.
    [self.viewController setButton2Block:^(UIButton *button){
        [weakSelf.viewController presentViewController:[weakSelf createNavigationController] animated:YES completion:nil];
    }];
    self.window.rootViewController = self.viewController;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"DSIC" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"DSIC.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

# pragma mark - APNS
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token = [NSString stringWithFormat:@"%@", deviceToken];
    NSLog(@"My token is:%@", token);
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSString *error_str = [NSString stringWithFormat: @"%@", error];
    NSLog(@"Failed to get token, error:%@", error_str);
}

void uncaughtExceptionHandler(NSException *exception) {
    NSLog(@"CRASH: %@", exception);
    NSLog(@"Stack Trace:%@", [exception callStackSymbols]);
}



@end

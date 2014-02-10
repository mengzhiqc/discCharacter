//
//  AppDelegate.h
//  DSIC
//
//  Created by 孟 智 on 13-8-31.
//  Copyright (c) 2013年 孟 智. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICETutorialPage.h"
#import "ICETutorialController.h"


@interface LSAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic,strong) NSMutableDictionary *result;
@property (nonatomic,strong) ICETutorialController *viewController;


- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator;
- (NSManagedObjectModel *)managedObjectModel;
- (NSManagedObjectContext *)managedObjectContext;

@end

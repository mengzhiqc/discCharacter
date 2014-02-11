//
//  DaoManager.m
//  disc
//
//  Created by 孟 智 on 14-2-11.
//  Copyright (c) 2014年 孟 智. All rights reserved.
//

#import "DaoManager.h"
#import "LSAppDelegate.h"
#import "Discdb.h"
#define ENTITY_NAME @"Discdb"
@interface DaoManager()
@property (nonatomic,strong) LSAppDelegate *delegate;
@property (nonatomic,strong) NSString *entityString;
@end
@implementation DaoManager

- (instancetype)initWithEntityString:(NSString *)entityString
{
    self = [super init];
    if (self) {
        self.entityString = entityString;
    }
    return self;
}


#pragma mark -
#pragma mark request Methods
- (NSArray *)findByPredicate:(NSPredicate *)predicate sorts:(NSArray *)sorts
{
    NSArray *result;
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:self.entityString inManagedObjectContext:self.delegate.managedObjectContext];
    
    [request setEntity:entity];
    
    if (predicate != nil) {
        [request setPredicate:predicate];
    }
    
    if (sorts != nil && sorts.count>0) {
        [request setSortDescriptors:sorts];
    }
    
    NSError *error;
    result = [self.delegate.managedObjectContext executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"#Error: save %@",[error description]);
    }
    return result;
}

- (NSArray *)findByPredicate:(NSPredicate *)predicate sort:(NSSortDescriptor *)sort
{
    NSArray *sorts;
    if (sort == nil) {
        NSLog(@"#Warning: findAllWithSort: sort is nil");
        sorts = nil;
    } else {
        sorts = @[sort];
    }
    return [self findByPredicate:predicate sorts:sorts];
}


- (NSArray *)findByPredicate:(NSPredicate *)predicate
{
    return [self findByPredicate:predicate sorts:nil];
}

- (NSArray *)findAllWithSort:(NSSortDescriptor *)sort
{
    return [self findByPredicate:nil sort:sort];
}

#pragma mark -
#pragma mark update Methods
- (NSArray *)updateByPredicate:(NSPredicate *)predicate data:(NSArray *)data
{
    NSMutableArray *objectIdArray;
    NSArray *managedObjects = [self findByPredicate:predicate];
    if (managedObjects.count>0) {
        for (Discdb *managedObject in managedObjects) {
            for (NSDictionary *dataObject in data) {
                if (dataObject[@"id"] == managedObject.id) {
                    managedObject.name = [dataObject objectForKey:@"name"];
                    managedObject.always = [dataObject objectForKey:@"always"];
                    managedObject.noalways = [dataObject objectForKey:@"noalways"];
                    NSError *saveError;
                    [self.delegate.managedObjectContext save:&saveError];
                    if (saveError == nil) {
                        NSLog(@"#Info: ManagedObject(%@) saved!",managedObject.id);
                    } else {
                        [objectIdArray addObject:managedObject.id];
                    }
                }
            }
        }
    }
    return objectIdArray;
}

#pragma mark -
#pragma mark insert Methods
- (NSArray *)insertData:(NSArray *)data
{
    NSMutableArray *objectIdArray;
    if (data.count > 0) {
        for (NSDictionary *dataObject in data) {
            Discdb *discObject = (Discdb *)[NSEntityDescription insertNewObjectForEntityForName:ENTITY_NAME inManagedObjectContext:self.delegate.managedObjectContext];
            discObject.name = dataObject[@"name"];
            discObject.always = dataObject[@"always"];
            discObject.noalways = dataObject[@"noalways"];
            discObject.id = dataObject[@"id"];
            
            [self.delegate.managedObjectContext insertObject:discObject];
            NSError *saveError;
            [self.delegate.managedObjectContext save:&saveError];
            if (saveError == nil) {
                NSLog(@"#Info: ManagedObject(%@) saved!",discObject.id);
            } else {
                [objectIdArray addObject:discObject.id];
            }
        }
    } else {
        NSLog(@"#warning: data to insert is nil");
    }
    return objectIdArray;
}

#pragma mark -
#pragma mark setters and getters
- (LSAppDelegate *)delegate
{
    return  (LSAppDelegate *)[UIApplication sharedApplication].delegate;
}

@end

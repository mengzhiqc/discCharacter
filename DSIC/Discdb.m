//
//  Discdb.m
//  disc
//
//  Created by 孟 智 on 1/15/14.
//  Copyright (c) 2014 孟 智. All rights reserved.
//

#import "Discdb.h"
#import "LSAppDelegate.h"
#define ENTITY_NAME @"Discdb"

@interface Discdb()
@property (nonatomic,strong) LSAppDelegate *delegate;
@end

@implementation Discdb

@dynamic always;
@dynamic id;
@dynamic name;
@dynamic noalways;



- (NSManagedObjectID *)insertToDiscdbByPage:(NSInteger)page context:(NSManagedObjectContext *)context
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:ENTITY_NAME inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id=%d",page];
    [fetchRequest setPredicate:predicate];
    
    NSArray *fetchedResult = [context executeFetchRequest:fetchRequest error:nil];
    Discdb *node ;
    if ([fetchedResult count]) {
        node = (Discdb *)[fetchedResult lastObject];
    } else {
        node = [NSEntityDescription insertNewObjectForEntityForName:ENTITY_NAME inManagedObjectContext:context];
        [context insertObject:node];
    }
    node.id = self.id;
    node.name = self.name;
    node.always = self.always;
    node.noalways = self.noalways;
    [context save:nil];
    NSLog(@"%@ - %@: Page:%@ Has Saved Successfully.",[self class],NSStringFromSelector(_cmd),self.id);
    return node.objectID;
}


#pragma mark - 
#pragma mark request Methods
- (NSArray *)findByPredicate:(NSPredicate *)predicate sorts:(NSArray *)sorts
{
    NSArray *result;
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:ENTITY_NAME inManagedObjectContext:self.delegate.managedObjectContext];
    
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
            for (Discdb *dataObject in data) {
                if (dataObject.id == managedObject.id) {
                    managedObject.name = dataObject.name;
                    managedObject.always = dataObject.always;
                    managedObject.noalways = dataObject.noalways;
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
        for (Discdb *dataObject in data) {
            Discdb *discObject = (Discdb *)[NSEntityDescription entityForName:ENTITY_NAME inManagedObjectContext:self.delegate.managedObjectContext];
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

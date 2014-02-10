//
//  Discdb.m
//  disc
//
//  Created by 孟 智 on 1/15/14.
//  Copyright (c) 2014 孟 智. All rights reserved.
//

#import "Discdb.h"
#define ENTITY_NAME @"Discdb"

@implementation Discdb

@dynamic always;
@dynamic id;
@dynamic name;
@dynamic noalways;


-(NSManagedObjectID *)insertToDiscdbByPage:(NSInteger)page context:(NSManagedObjectContext *)context
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



@end

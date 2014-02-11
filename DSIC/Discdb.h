//
//  Discdb.h
//  disc
//
//  Created by 孟 智 on 1/15/14.
//  Copyright (c) 2014 孟 智. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "LSAppDelegate.h"


@interface Discdb : NSManagedObject

@property (nonatomic, retain) NSString * always;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * noalways;
-(NSManagedObjectID *)insertToDiscdbByPage:(NSInteger)page context:(NSManagedObjectContext *)context;


- (NSArray *)findByPredicate:(NSPredicate *)predicate sorts:(NSArray *)sorts;
- (NSArray *)findByPredicate:(NSPredicate *)predicate sort:(NSSortDescriptor *)sort;
- (NSArray *)findByPredicate:(NSPredicate *)predicate;
- (NSArray *)findAllWithSort:(NSSortDescriptor *)sort;

- (NSArray *)updateByPredicate:(NSPredicate *)predicate data:(NSArray *)data;
- (NSArray *)insertData:(NSArray *)data;

@end

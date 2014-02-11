//
//  DaoManager.h
//  disc
//
//  Created by 孟 智 on 14-2-11.
//  Copyright (c) 2014年 孟 智. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DaoManager : NSObject

- (instancetype)initWithEntityString:(NSString *)entityString;

- (NSArray *)findByPredicate:(NSPredicate *)predicate sorts:(NSArray *)sorts;
- (NSArray *)findByPredicate:(NSPredicate *)predicate sort:(NSSortDescriptor *)sort;
- (NSArray *)findByPredicate:(NSPredicate *)predicate;
- (NSArray *)findAllWithSort:(NSSortDescriptor *)sort;

- (NSArray *)updateByPredicate:(NSPredicate *)predicate data:(NSArray *)data;
- (NSArray *)insertData:(NSArray *)data;

@end

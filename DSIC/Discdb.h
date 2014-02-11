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

@end

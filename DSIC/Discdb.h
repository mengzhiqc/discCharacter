//
//  Discdb.h
//  DSIC
//
//  Created by 孟 智 on 13-9-2.
//  Copyright (c) 2013年 孟 智. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Discdb : NSManagedObject

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * value;

@end

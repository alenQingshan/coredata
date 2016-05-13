//
//  Person+CoreDataProperties.h
//  coredata
//
//  Created by 刘青山 on 16/5/13.
//  Copyright © 2016年 刘青山. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *age;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *phone;
@property (nullable, nonatomic, retain) Sex *sex;

@end

NS_ASSUME_NONNULL_END

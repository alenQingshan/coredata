//
//  Sex+CoreDataProperties.h
//  coredata
//
//  Created by 刘青山 on 16/5/13.
//  Copyright © 2016年 刘青山. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Sex.h"

NS_ASSUME_NONNULL_BEGIN

@interface Sex (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *sex;
@property (nullable, nonatomic, retain) Person *person;

@end

NS_ASSUME_NONNULL_END

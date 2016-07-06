//
//  Teacher+CoreDataProperties.h
//  Core Data
//
//  Created by 李堪阶 on 16/7/6.
//  Copyright © 2016年 DM. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Teacher.h"

NS_ASSUME_NONNULL_BEGIN

@interface Teacher (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *age;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *t_s;

@end

@interface Teacher (CoreDataGeneratedAccessors)

- (void)addT_sObject:(NSManagedObject *)value;
- (void)removeT_sObject:(NSManagedObject *)value;
- (void)addT_s:(NSSet<NSManagedObject *> *)values;
- (void)removeT_s:(NSSet<NSManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END

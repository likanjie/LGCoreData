//
//  Student+CoreDataProperties.h
//  Core Data
//
//  Created by 李堪阶 on 16/7/6.
//  Copyright © 2016年 DM. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Student.h"

NS_ASSUME_NONNULL_BEGIN

@interface Student (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *age;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) Teacher *s_t;

@end

NS_ASSUME_NONNULL_END

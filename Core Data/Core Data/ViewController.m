//
//  ViewController.m
//  Core Data
//
//  Created by 李堪阶 on 16/7/6.
//  Copyright © 2016年 DM. All rights reserved.
//

#import "ViewController.h"
#import <CoreData/CoreData.h>

#import "Student.h"
#import "Teacher.h"
@interface ViewController ()

/** 上下文 */
@property (strong,nonatomic) NSManagedObjectContext *manageObjectContet;

/** 对象映射模型 */
@property (strong,nonatomic) NSManagedObjectModel *managedObjectModel;

/** 持久化协调器 */
@property (strong,nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1、添加数据到数据库
    
    [self addDataToDb];
    //2、查询数据
    [self selectData];
    
}

- (void)selectData{
    // 初始化一个查询请求
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // 设置要查询的实体
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:self.manageObjectContet];
    
    [fetchRequest setEntity:entity];
    
    // 设置条件过滤
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"age = 23"];
    [fetchRequest setPredicate:predicate];
    
    // 设置排序（按照age降序）
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"age"
                                                                   ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    NSError *error1 = nil;
    
    // 执行请求
    NSArray *fetchedObjects = [self.manageObjectContet executeFetchRequest:fetchRequest error:&error1];
    
    // 遍历数据
    for (Student *stu in fetchedObjects) {
        
        NSLog(@"姓名：%@ 年龄：%@",stu.name,stu.age);
    }
}

/**
 *  添加数据到数据库
 */
- (void)addDataToDb{
    
    //传入上下文 创建一个Student实体对象
    Student *stu = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:self.manageObjectContet];
    
    [stu setName:@"从小就傻呆"];
    [stu setAge:@(23)];
    
    
    Teacher *tea = [NSEntityDescription insertNewObjectForEntityForName:@"Teacher" inManagedObjectContext:self.manageObjectContet];
    [tea setName:@"呆头"];
    [tea setAge:@(34)];
    
    NSError *error = nil;
    
    // 利用上下文对象，将数据同步到持久化存储库
    BOOL success = [self.manageObjectContet save:&error];
    
    if (!success) {
        
        [NSException raise:@"访问数据库错误" format:@"%@",[error localizedDescription]];
    }
    
    NSLog(@"%@",[self applicationDocumentDirectory]);
}


/**
 *  获取文件路径
 */
- (NSURL *)applicationDocumentDirectory {
    
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask  ]lastObject];
}

/**
 *  从应用程序包中加载模型文件
 */
- (NSManagedObjectModel *)managedObjectModel{
    
    if (_managedObjectModel != nil) {
        
        return _managedObjectModel;
    }
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"testCoreData" withExtension:@"momd"];
    
    //从应用程序包中加载模型文件
    _managedObjectModel = [[NSManagedObjectModel alloc]initWithContentsOfURL:modelURL];
    
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator{
    
    if (_persistentStoreCoordinator != nil) {
        
        return _persistentStoreCoordinator;
    }
    
    //传入模型对象 初始化NSPersistentStoreCoordinator
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:[self managedObjectModel]];
    
    //构建SQLite数据库文件的路径
    NSURL *storeURL = [[self applicationDocumentDirectory] URLByAppendingPathComponent:@"testData.sqlite"];
    
    NSError *error = nil;
    
    //添加到持久存储库，这里使用SQLite作为存储库
    NSPersistentStore *store =  [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
    
    if (store == nil) { //直接抛异常
        
        [NSException raise:@"添加数据库错误" format:@"%@",[error localizedDescription]];
    }
    
    return _persistentStoreCoordinator;
}

/**
 *  初始化上下文 设置persistentStoreCoordinator属性
 */
- (NSManagedObjectContext *)manageObjectContet{
    
    if (_manageObjectContet != nil) {
        
        return _manageObjectContet;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    
    if (!coordinator) {
        return nil;
    }
    
    //初始化上下文
    _manageObjectContet = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    //设置persistentStoreCoordinator属性
    [_manageObjectContet setPersistentStoreCoordinator:coordinator];
    
    
    return _manageObjectContet;
}

@end




















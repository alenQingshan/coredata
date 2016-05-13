//
//  ViewController.m
//  coredata
//
//  Created by 刘青山 on 16/5/13.
//  Copyright © 2016年 刘青山. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Person.h"
#import "Sex.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //插入
    [self insert];
    
    //查找
    [self search];
    
    //修改
    [self update];
    
    //查找
    [self search];
    
    //删除
    [self delete];
    
    //查找
    [self search];
    
}


//插入
-(void)insert
{
    //获取AppDelegate中的被管理所有对象的上下文managedObjectContext
    AppDelegate * delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext * context = delegate.managedObjectContext;
    //创建对象,来分别保存输入的内容
    Person * per = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:context];
    //获取输入的各项内容
    per.name = @"刘青山";
    per.age = @"24";
    per.phone = @"17701849938";
    //创建sex对象,把sex对象赋值给Perosn中的sex属性,同时保存sex
    Sex *sex = [NSEntityDescription insertNewObjectForEntityForName:@"Sex" inManagedObjectContext:context];
    sex.sex = @"nan";
    per.sex = sex;
    //保存数据
    NSLog(@"保存");
    [delegate saveContext];
}


//查询
-(void)search
{
    NSString * searchContent = @"刘青山";
    NSPredicate * pre = [NSPredicate predicateWithFormat:@"name CONTAINS %@",searchContent];
    /**
     1.谓词查询内容
     2.如果输入要查询的内容长度为0,则显示保存的所有的数据
     */
    if (searchContent.length == 0) {
        pre = nil;
    }
    
    AppDelegate * delegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext * context = delegate.managedObjectContext;
    
    NSEntityDescription * des = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:context];
    
    NSFetchRequest * request = [NSFetchRequest new];
    request.entity = des;
    request.predicate = pre;
    
    /** 获取查询到的内容---是数组 */
    NSArray * array = [context executeFetchRequest:request error:NULL];
    //遍历查询到的数据,并打印
    for (Person * p in array) {
        NSLog(@" %@ : %@ : %@ : %@",p.name,p.age,p.sex.sex,p.phone);
    }
}

-(void)delete
{
    NSString * deleteContent = @"刘青山";
    
    /** 查询要删除带有输入的关键字的对象 */
    NSPredicate * pre = [NSPredicate predicateWithFormat:@"name CONTAINS %@",deleteContent];
    
    AppDelegate * delegate = [[UIApplication sharedApplication] delegate];
    
    /** 被管理对象上下文--(获取所有被管理对象的实体) */
    NSManagedObjectContext * context = delegate.managedObjectContext;
    
    /** 根据上下文获取查询数据库实体的请求参数---要查询的entity(实体) */
    NSEntityDescription * des = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:context];
    
    /** 查询请求 */
    NSFetchRequest * request = [NSFetchRequest new];
    
    /** 根据参数获取查询内容 */
    request.entity = des;
    
    request.predicate = pre;
    
    /**
     1.获取所有被管理对象的实体---根据查询请求取出实体内容
     2.获取的查询内容是数组
     3.删掉所有查询到的内容
     3.1.这里是模糊查询 即 删除包含要查询内容的字母的内容
     */
    NSArray * array = [context executeFetchRequest:request error:NULL];
    
    /** 对查询的内容进行操作 */
    for (Person * p in array) {
        [context deleteObject:p];
    }
    NSLog(@"删除完成");
    [delegate saveContext];
}

//修改
-(void)update
{
    /** 获取输入内容 */
    NSString * updateContent = @"刘青山";
    NSPredicate * pre = [NSPredicate predicateWithFormat:@"name CONTAINS %@",updateContent];
    
    AppDelegate * delegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext * context = delegate.managedObjectContext;
    NSEntityDescription * des = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:context];
    NSFetchRequest * request = [NSFetchRequest new];
    request.entity = des;
    request.predicate = pre;
    
    NSArray * array = [context executeFetchRequest:request error:NULL];
    
    //这里修改的话把全部查询到的内容修改成了 "张三",可以根据自己的需要进行设置
    for (Person *p in array) {
        p.name = @"张三";
        [context updatedObjects];
    }
    NSLog(@"修改完成");
    [delegate saveContext];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

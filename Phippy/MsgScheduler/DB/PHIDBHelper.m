//
//  PHIDBHelper.m
//  Phippy
//
//  Created by toby on 17/07/2017.
//  Copyright © 2017 kg.self.edu. All rights reserved.
//

#import "PHIDBHelper.h"
#import "FMDatabase.h"

@interface PHIDBHelper ()
@property (nonatomic, strong) FMDatabase *db;
@end

@implementation PHIDBHelper


+ (void)insert{
    
    T_Store *store = [[T_Store alloc]init];
   
    store.store_id = 1001;
    store.store_type = 1;
    store.name = @"最美餐厅";
    store.img_url = @"www";
    store.phone_number = @"0973646464";
    store.wechat = @"wechat";
    store.deliver_time = @"8:00 ~ 24:00";
//    store.qisong_condition = @"600P";
    store.adress = @"";
//    store.rank = @"";

//    NSLog(@"store_id:%@",[store valueForKey:@"store_id"]);
//    NSLog(@"sentence:%@",[self generateINSERTSQLSentenceWithTable:store]);
//    NSLog(@"values:%@",[store getAllValuesAtproperties]);
    
    
    BOOL result = [[self shareInstance].db executeUpdate:[self generateINSERTSQLSentenceWithTable:store] withArgumentsInArray:[store getAllValuesAtproperties]];
    
    if(result){
        NSLog(@"insert 成功");
    }else{
        NSLog(@"insert 失败");
    }
    
    //    for (int i = 0; i<10; i++) {
    //        NSString *name = [NSString stringWithFormat:@"jack-%d", arc4random_uniform(100)];
    //        // executeUpdate : 不确定的参数用?来占位，参数都必须是对象
    //        [[self shareInstance].db executeUpdate:@"INSERT INTO t_student (name, age) VALUES (?, ?);", name, @(arc4random_uniform(40))];
    //        //        [self.db executeUpdate:@"INSERT INTO t_student (name, age) VALUES (?, ?);" withArgumentsInArray:@[name, @(arc4random_uniform(40))]]; // ?方式，参数要是对象，不是对象要包装为对象
    //
    //        // executeUpdateWithFormat : format方式拼接，不确定的参数用%@、%d等来占位
    //        //        [self.db executeUpdateWithFormat:@"INSERT INTO t_student (name, age) VALUES (%@, %d);", name, arc4random_uniform(40)];
    //        // 注意：如果直接写%@不用加单引号两边，会自动加单引号两边，如果'jack_%d'的两边不加单引号就会报错，所以要注意
    //
    //    }
    
    
}

+ (NSString *)generateINSERTSQLSentenceWithTable:(T_Base *)table{
    
    NSString *tableName = [table getTableName];
    NSArray *properties = [table getAllProperties];
    
    NSMutableString *sentence = [NSMutableString stringWithFormat:@"INSERT INTO %@ (",tableName];
    NSMutableString *questionMark = [[NSMutableString alloc]initWithString:@"VALUES ("];
    
    
    
    
    for(NSString *property in properties){
        [sentence appendString:[NSString stringWithFormat:@"%@, ",property]];
        [questionMark appendString:@"?, "];
    }
    
    //去掉 “, ”
    sentence = [NSMutableString stringWithFormat:@"%@) ", [sentence substringToIndex:sentence.length-2]];
    questionMark = [NSMutableString stringWithFormat:@"%@);", [questionMark substringToIndex:questionMark.length-2]];
    
    [sentence appendString:questionMark];
    return sentence;
}

+ (void)insertWithTableModel:(T_Base *)table{
    
}

+ (void)insertWithTableModels:(NSArray<T_Base *> *)tables{
    
}

+ (void)update{
    
}

+ (void)query{
    // 1.执行查询语句
    FMResultSet *resultSet = [[self shareInstance].db executeQuery:@"SELECT * FROM t_student"];
    
    // 2.遍历结果
    while ([resultSet next]) {
        int ID = [resultSet intForColumn:@"id"];
        NSString *name = [resultSet stringForColumn:@"name"];
        int age = [resultSet intForColumn:@"age"];
        NSLog(@"%d %@ %d", ID, name, age);
    }
    
}

+ (void)delData{
    [[self shareInstance].db executeUpdate:@"DROP TABLE IF EXISTS t_student;"];
    [[self shareInstance].db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_student (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL);"];
    
    
}

/*  ~~~~~~~~~~~~~~~~~~~~~~~     单例      ~~~~~~~~~~~~~~~~~~~~~~~~~~   */

#pragma mark lift cycle

static PHIDBHelper * _instance = nil;

+ (PHIDBHelper *)shareInstance{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init];
        
#warning 整理成model形式
        // 1.获得数据库文件的路径
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *filename = [doc stringByAppendingPathComponent:@"phippy.sqlite"];
        NSLog(@"phippy sqlite path:%@",filename);
        // 2.得到数据库
        FMDatabase *db = [FMDatabase databaseWithPath:filename];
        
        // 3.打开数据库
        if ([db open]) {
            // 4.创表
            /*
             @"CREATE TABLE IF NOT EXISTS t_store (
             id integer PRIMARY KEY AUTOINCREMENT,
             store_id integer NOT NULL,
             store_type integer NOT NULL,
             name text,
             img_url text,
             phone_number text,
             wechat text,
             deliver_time text,
             qisong_condition text,
             adress text,
             rank integer);"
             
             
             @"CREATE TABLE IF NOT EXISTS t_goods (
             id integer PRIMARY KEY AUTOINCREMENT,
             goods_id integer NOT NULL,
             store_id integer NOT NULL,
             name text,
             price text,
             publish_time text,
             publisher text,
             remark text,
             describe text,
             img_url text,
             rank integer);"
             
             
             @"CREATE TABLE IF NOT EXISTS t_article (
             id integer PRIMARY KEY AUTOINCREMENT,
             store_id integer NOT NULL,
             title text,
             content text,
             time text,
             img_url text,
             rank integer);"
             */
            BOOL result_store = [db executeUpdate: @"CREATE TABLE IF NOT EXISTS t_store (id integer PRIMARY KEY AUTOINCREMENT,store_id integer NOT NULL,store_type integer NOT NULL,name text,img_url text,phone_number text,wechat text,deliver_time text,qisong_condition text,adress text,rank integer);"];
            
            BOOL result_goods = [db executeUpdate:  @"CREATE TABLE IF NOT EXISTS t_goods (id integer PRIMARY KEY AUTOINCREMENT,goods_id integer NOT NULL,store_id integer NOT NULL,name text,price text,publish_time text,publisher text,remark text,describe text,img_url text,rank integer);"];
            
            BOOL result_article = [db executeUpdate: @"CREATE TABLE IF NOT EXISTS t_article (id integer PRIMARY KEY AUTOINCREMENT,store_id integer NOT NULL,title text,content text,time text,img_url text,rank integer);"];
            
            if (result_store && result_goods && result_article) {
                NSLog(@"成功创表");
            } else {
                NSLog(@"创表失败");
            }
        }
        _instance.db = db;
    }) ;
    return _instance ;
}


+ (id) allocWithZone:(struct _NSZone *)zone
{
    return [PHIDBHelper shareInstance] ;
}

- (id) copyWithZone:(struct _NSZone *)zone
{
    return [PHIDBHelper shareInstance] ;
}

@end

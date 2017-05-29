//
//  ManageMemo.m
//  ios-training-6
//
//  Created by Manami Ichikawa on 5/27/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

#import "ManageMemo.h"
#import "FMDB.h"
//#import "Memo.h"

@interface ManageMemo()

@property(nonatomic,copy) NSString* db_path;

@end

@implementation ManageMemo

-(id)init{
    
    self = [super init];
    if(self){
        FMDatabase* db = [self getConnection];
        [db open];
        NSString *sql = @"CREATE TABLE IF NOT EXISTS  t_memo(memo_id INTEGER PRIMARY KEY AUTOINCREMENT, memo_title TEXT, memo_date DATE, contents TEXT); ";
        [db executeUpdate:sql];
        [db close];
    }
    return self;
}

-(NSArray*)showMemoList{
    
    FMDatabase *db = [self getConnection];
    NSString *sqlite = @"SELECT* FROM t_memo ORDER BY memo_date ASC ";
    [db open];
    FMResultSet* results = [db executeQuery:sqlite];
    NSMutableArray* list = [[NSMutableArray alloc] initWithCapacity:0];
    //       NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //    [formatter setDateFormat:@"yyyy/MM/dd"];
    while ([results next]){
        Memo* memo = [[Memo alloc] init];
        
        memo.memoId       = [results intForColumn:@"memo_id"];
        memo.memoTitle    = [results stringForColumn:@"memo_title"];
        memo.date         = [results stringForColumn:@"memo_date"];
        memo.memoContents = [results stringForColumn:@"contents"];
       
        [list addObject:memo];

    }
    return list;
}

-(void)addNewMemo:(Memo*)memo{
    
    NSString *title      = memo.memoTitle;
    NSString *date       = memo.date;
    NSString *contents   = memo.memoContents;
 
    FMDatabase* db = [self getConnection];
    [db open];
    [db beginTransaction];
    
    NSString *sql = @"INSERT INTO t_memo (memo_title, memo_date, contents) VALUES (?,?,?)";
    
    BOOL t = [db executeUpdate:sql,title,date,contents];
    NSLog(@"%d",t);
    
    [db commit];
    [db close];
    
    if([self.delegate respondsToSelector:@selector(finishedAddingNewMemo)]){
        [self.delegate finishedAddingNewMemo];
    }
}

+(NSString*)getDbFilePath{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSString *dir = [paths
                     objectAtIndex:0];
    return [dir stringByAppendingPathComponent:@"memo.db"];    
}

-(FMDatabase*)getConnection{
    if(self.db_path == nil){
        self.db_path = [ManageMemo getDbFilePath];
    }
    
   // NSLog(@"パス:%@",_db_path);
    
    return [FMDatabase databaseWithPath:self.db_path];
};

@end

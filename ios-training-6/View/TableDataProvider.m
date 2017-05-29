//
//  TableDataProvider.m
//  ios-training-6
//
//  Created by Manami Ichikawa on 5/27/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

#import "TableDataProvider.h"
#import "MemoCell.h"
#import "Memo.h"

@interface TableDataProvider()
@property(nonatomic, strong) NSArray *items;

@end

@implementation TableDataProvider

-(void)setupTableView:(NSArray*)list{
    
    self.items = list;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.items.count;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    MemoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDateFormatter *df =[[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy/MM/dd/HH:mm "];
    //[df setTimeZone:[NSTimeZone defaultTimeZone]];
    //NSDateFormatter *timeZoneFormat = [[NSDateFormatter alloc]init];
   // [timeZoneFormat setTimeZone:];
    Memo *memo = [self.items objectAtIndex:indexPath.row];
    NSString *stringDate = memo.date;
    //NSLog(@"オオおおおお%@",stringDate);
    NSDate *date = [df dateFromString:stringDate];
    //NSLog(@"ううううう%@",date);
    //[NSString stringWithFormat:@"%@", memo.memoTitle];
    cell.titleLabel.text   = memo.memoTitle;
    cell.dateLabel.text    = [NSString stringWithFormat:@"%@", date];
    cell.contentLabel.text = [NSString stringWithFormat:@"%@", memo.memoContents];
    return cell;
    
}





@end

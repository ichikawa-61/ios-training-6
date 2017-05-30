//
//  TableDataProvider.h
//  ios-training-6
//
//  Created by Manami Ichikawa on 5/27/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol  ProvidingTableDataProtocol<NSObject>

@optional
-(void)removeMemoFromTable: (NSIndexPath*)indexPath;

@end

@interface TableDataProvider : NSObject<UITableViewDataSource>

@property(nonatomic, weak) id <ProvidingTableDataProtocol> delegate;

-(void)setupTableView:(NSArray*)list;
@end

//
//  TableDataProvider.h
//  ios-training-6
//
//  Created by Manami Ichikawa on 5/27/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TableDataProvider : NSObject<UITableViewDataSource>

-(void)setupTableView:(NSArray*)list;
@end

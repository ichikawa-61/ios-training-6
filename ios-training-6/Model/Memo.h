//
//  Memo.h
//  ios-training-6
//
//  Created by Manami Ichikawa on 5/27/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Memo : NSObject

@property (nonatomic, assign) NSInteger memoId;
@property (nonatomic, copy) NSString *memoTitle;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *memoContents;


@end

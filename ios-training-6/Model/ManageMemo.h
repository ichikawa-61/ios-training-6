//
//  ManageMemo.h
//  ios-training-6
//
//  Created by Manami Ichikawa on 5/27/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Memo.h"
@protocol ManageMemoDelegate<NSObject>

//@optional

-(void)finishedAddingNewMemo;

@end
@interface ManageMemo : NSObject

@property (weak, nonatomic) id <ManageMemoDelegate> delegate;

-(void)addNewMemo:(Memo*)memo;
-(NSMutableArray*)showMemoList;
-(void)removeMemo:(NSInteger)memoId;

@end

//
//  ImputScreenViewController.m
//  ios-training-6
//
//  Created by Manami Ichikawa on 5/27/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

#import "ImputScreenViewController.h"
#import "ManageMemo.h"
#import "Memo.h"

@interface ImputScreenViewController ()<UITextViewDelegate,ManageMemoDelegate>


@end

@implementation ImputScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem* addButton = [[UIBarButtonItem alloc]
                               initWithTitle:@"登録"
                               style:UIBarButtonItemStylePlain
                               target:self
                               action:@selector(pushRegisterButton)];
    self.navigationItem.rightBarButtonItems = @[addButton];

}



-(void)pushRegisterButton{

    ManageMemo *db = [[ManageMemo alloc]init];
    
    NSMutableArray *lines = [NSMutableArray array];
    [self.textView.text enumerateLinesUsingBlock:^(NSString *line, BOOL *stop){
        [lines addObject:line];
    }];
    
    NSString *firstLine  = lines.firstObject;
    [lines removeObjectAtIndex:0];
    
    NSString *otherLines = [lines componentsJoinedByString:@""];
    
   
    
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd/HH:mm"];
    NSString *createdDate = [formatter stringFromDate:now];
    
    Memo *memo = [[Memo alloc]init];
    memo.memoTitle    = firstLine;
    memo.memoContents = otherLines;
    memo.date         = createdDate;
    
    [db addNewMemo:memo];

    [self.navigationController popViewControllerAnimated:YES];
    
}





@end

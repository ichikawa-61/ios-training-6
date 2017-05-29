//
//  MainViewController.m
//  ios-training-6
//
//  Created by Manami Ichikawa on 5/27/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

//Controller
#import "MainViewController.h"
#import "ImputScreenViewController.h"
//Model
#import "ManageMemo.h"
//View
#import "TableDataProvider.h"

@interface MainViewController ()<ManageMemoDelegate>

@property(nonatomic,strong)NSArray *memoList;
@property(strong, nonatomic) TableDataProvider *dataSource;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong, nonatomic) ManageMemo *db;
- (IBAction)goToInputScreen:(id)sender;
@end

@implementation MainViewController

# pragma mark - private  method

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"MemoCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"Cell"];
    
    self.dataSource = [[TableDataProvider alloc]init];
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate   = self;
    self.db.delegate = self;
    [self accessMemoManager];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self.tableView reloadData];
}

- (IBAction)goToInputScreen:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ImputScreen" bundle:[NSBundle mainBundle]];
    
     ImputScreenViewController *vc = [storyboard instantiateInitialViewController];
    [self.navigationController pushViewController:vc animated:nil];
}

-(void)accessMemoManager{
    
    self.db = [[ManageMemo alloc]init];
    NSArray *memoList  = [self.db showMemoList];
    self.memoList = memoList;
    
    [self.dataSource setupTableView:memoList];
    [self.tableView reloadData];

}

-(void)finishedAddingNewMemo{

    NSLog(@"ああああfinishedAddingNewMemo");
    [self accessMemoManager];
}

#pragma mark - "UITableViewDelegete"


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 60;
}


@end

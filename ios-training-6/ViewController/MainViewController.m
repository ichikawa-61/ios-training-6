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

@interface MainViewController ()<ProvidingTableDataProtocol>

//- (IBAction)showEditMode:(id)sender;
@property(nonatomic,strong)NSMutableArray *memoList;
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
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    self.dataSource = [[TableDataProvider alloc]init];
    self.tableView.dataSource = self.dataSource;
    self.dataSource.delegate = self;
    self.tableView.delegate   = self;
    self.db = [[ManageMemo alloc]init];
    //self.db.delegate = self;
    [self accessMemoManager];
    
}

//-(void)viewWillAppear:(BOOL)animated{
//    
//    [self.tableView reloadData];
//}

- (IBAction)goToInputScreen:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ImputScreen" bundle:[NSBundle mainBundle]];
    
     ImputScreenViewController *vc = [storyboard instantiateInitialViewController];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)accessMemoManager{
    
    
    NSMutableArray *memoList = [self.db showMemoList];
    [self.dataSource setupTableView:memoList];
    
    self.memoList = memoList;
    [self.tableView reloadData];

}

//-(void)finishedAddingNewMemo{
//
//    [self accessMemoManager];
//}

#pragma mark - "UITableViewDelegete"


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return 60;
}

//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    NSLog(@"おk");
//    return YES;
//}

//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"hello2");
//    if(editingStyle == UITableViewCellEditingStyleDelete){
//        
//        NSLog(@"hello3");
//        //[self removeMemoFromTable:indexPath];
//    }
//}

- (void)removeMemoFromTable:(NSIndexPath*)indexPath
{
   // NSMutableArray* booksByAuthor = [self.memoList objectForKey:[self.authors objectAtIndex:indexPath.section]];
    Memo* memo = [self.memoList objectAtIndex:indexPath.row];
    NSLog(@"title:%@", memo.memoTitle);
    NSLog(@"ID:%ld", memo.memoId);
    [self.db removeMemo:memo.memoId];

    
    NSLog(@"helloああああ");
    
    //[self.tableView beginUpdates];
    
//    if( self.memoList.count == 1 )
//    {
        [self.memoList removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView reloadRowsAtIndexPaths:[self.tableView indexPathsForVisibleRows] withRowAnimation:UITableViewRowAnimationAutomatic];
    
//    }
//    else
//    {
//        [booksByAuthor removeObjectAtIndex:indexPath.row];
//        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    }
//    
    //[self.tableView endUpdates];
}


- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    
    NSLog(@"呼ばれた");
    [super setEditing:editing animated:animated];
    
    if (editing)
    {
        self.editButtonItem.title = NSLocalizedString(@"Done",@"Done");
        
        [self.tableView setEditing:!self.tableView.editing animated:YES];
        [self.tableView performSelector:@selector(reloadData) withObject:nil afterDelay:0.5f];
        
        UIAlertController *alert = [[UIAlertController alloc]init];
        UIAlertAction* deleteAllButton = [UIAlertAction
                                    actionWithTitle:@"一斉削除"
                                    style:UIAlertActionStyleDestructive
                                    handler:^(UIAlertAction * action) {
                                        //Handle your yes please button action here
                                      
                                    }];
        
        UIAlertAction* cancelButton = [UIAlertAction
                                   actionWithTitle:@"Cancel"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       //Handle no, thanks button
                                   }];
        [alert addAction:deleteAllButton];
        [alert addAction:cancelButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        self.editButtonItem.title = NSLocalizedString(@"Edit", @"Edit");
        [self.tableView setEditing:!self.tableView.editing animated:YES];
    }
}

//- (IBAction)showEditMode:(id)sender {
//    
//    self.tableView.editing = isEditing;
//    //self.navigationItem.title = @"完了";
//    NSLog(@"%d",isEditing);
//    
//    isEditing = !isEditing;
//    NSLog(@"%d",isEditing);
//    
//}
@end

//
//  HSearchViewController.m
//  DemoForInterviewingCrazybaby
//
//  Created by 吴海文 on 16/12/27.
//  Copyright © 2016年 韩. All rights reserved.
//

#import "HSearchViewController.h"
#import "NetworkManager.h"
#import "RepoModel.h"
#import "HDetailViewController.h"
#import "MJRefresh.h"

@interface HSearchViewController () <UISearchBarDelegate,UISearchResultsUpdating,UIScrollViewDelegate>
@property(nonatomic, assign)NSInteger page;
@property(nonatomic, strong)UISearchController *searchController;
@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic, strong)UIActivityIndicatorView *indicator;
@end

@implementation HSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"search on github";
    _dataArray = [[NSMutableArray alloc] init];
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
    _page = 1;
    
    _indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _indicator.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);
    [self.view addSubview:_indicator];
}

- (void)addFooter
{
    MJRefreshAutoStateFooter *footer =[MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
        _page += 1;
        [[NetworkManager sharedManager] searchWithKeywords:self.searchController.searchBar.text page:_page success:^(id response) {
            [_dataArray addObjectsFromArray:response];
            [self.tableView reloadData];
            [self.tableView.mj_footer endRefreshing];
            if ([(NSArray *)response count] == 0) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        } Failed:^(NSError *error) {
            
        }];
    }];
    self.tableView.mj_footer = footer;
}

- (void)startAnimation {
    [_indicator startAnimating];
}
- (void)stopAnimation {
    [_indicator stopAnimating];
}

-(UISearchController *)searchController
{
    if (!_searchController) {
        
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchController.searchBar.frame = CGRectMake(0, 0, 0, 44);
        _searchController.dimsBackgroundDuringPresentation = NO;
        _searchController.hidesNavigationBarDuringPresentation = NO;
        [_searchController.searchBar sizeToFit];
        _searchController.searchResultsUpdater = self;
        _searchController.searchBar.delegate = self;
    }
    
    return _searchController;
}
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    if (searchController.searchBar.text.length > 0) {
        [self startAnimation];
        _page = 1;
        [[NetworkManager sharedManager] searchWithKeywords:searchController.searchBar.text page:_page success:^(id response) {
            [self stopAnimation];
            _dataArray = [NSMutableArray arrayWithArray:response];
            [self.tableView reloadData];
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
            if ([response count] > 0) {
                [self addFooter];
            } else
            {
                self.tableView.mj_footer = nil;
            }
        } Failed:^(NSError *error) {
            NSLog(@"fail == %@",error);
        }];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"SeachTableCellId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    RepoModel *model = _dataArray[indexPath.row];
    cell.textLabel.text = model.ownerName;
    cell.detailTextLabel.text = model.repoName;
    
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.searchController.searchBar resignFirstResponder];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_searchController setActive:NO];
    HDetailViewController *detail = [[HDetailViewController alloc] init];
    detail.model = _dataArray[indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [_dataArray removeAllObjects];
    [self.tableView reloadData];
    self.tableView.mj_footer = nil;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

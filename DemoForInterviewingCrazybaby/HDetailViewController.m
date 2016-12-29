//
//  HDetailViewController.m
//  DemoForInterviewingCrazybaby
//
//  Created by Han on 16/12/28.
//  Copyright © 2016年 韩. All rights reserved.
//


#import "HDetailViewController.h"
#import "HWebViewController.h"

@interface HDetailViewController ()

@end

@implementation HDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.title = @"details";
    
    [self createHeader];
    self.tableView.tableFooterView = [UIView new];
    
}

- (void) createHeader
{
    UIView *headerView = [[UIView alloc ]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH / 3 * 2)];
    self.tableView.tableHeaderView = headerView;
    
    UIImageView *headerImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 90, 90)];
    [headerView addSubview:headerImg];
    headerImg.center = headerView.center;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSURL *url = [NSURL URLWithString:self.model.avatar_url];
        NSData *data = [NSData dataWithContentsOfURL:url];
        dispatch_async(dispatch_get_main_queue(), ^{
            headerImg.image = [UIImage imageWithData:data];
        });
        
    });
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
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"detailCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Owner Name";
            cell.detailTextLabel.text = _model.ownerName;
            break;
        case 1:
            cell.textLabel.text = @"Full Name";
            cell.detailTextLabel.text = _model.full_name;
            break;
        case 2:
            cell.textLabel.text = @"Language";
            cell.detailTextLabel.text = _model.language;
            break;
        case 3:
            cell.textLabel.text = @"Star Count";
            cell.detailTextLabel.text = _model.stargazers_count.stringValue;
            break;
        case 4:
            cell.textLabel.text = @"Link Url";
            cell.detailTextLabel.text = _model.html_url;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        default:
            break;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 4) {
        HWebViewController *web = [[HWebViewController alloc] init];
        web.linkUrl = _model.html_url;
        web.webTitle = _model.full_name;
        [self.navigationController pushViewController:web animated:YES];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

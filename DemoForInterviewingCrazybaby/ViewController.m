//
//  ViewController.m
//  DemoForInterviewingCrazybaby
//
//  Created by Han on 16/12/27.
//  Copyright © 2016年 韩. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "NetworkManager.h"
#import "HSearchViewController.h"

@interface ViewController () <UISearchBarDelegate,UISearchResultsUpdating>
@property(nonatomic, strong)UISearchController *searchController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
   
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

//
//  HDetailViewController.h
//  DemoForInterviewingCrazybaby
//
//  Created by Han on 16/12/28.
//  Copyright © 2016年 韩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RepoModel.h"
// 屏幕高度
#define SCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height
// 屏幕宽度
#define SCREEN_WIDTH    [[UIScreen mainScreen] bounds].size.width

@interface HDetailViewController : UITableViewController

@property(nonatomic, strong) RepoModel *model;

@end

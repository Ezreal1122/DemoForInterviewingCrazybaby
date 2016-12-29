//
//  HWebViewController.m
//  DemoForInterviewingCrazybaby
//
//  Created by Han on 16/12/28.
//  Copyright © 2016年 韩. All rights reserved.
//

#import "HWebViewController.h"
#import "HDetailViewController.h"
@interface HWebViewController ()
@property(nonatomic,retain)UIWebView *myWeb;
@end

@implementation HWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = _webTitle;
    _myWeb = [[UIWebView alloc]initWithFrame:self.view.frame];

    [_myWeb sizeToFit];
    
    NSString *urlString = _linkUrl;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [_myWeb loadRequest:request];
    [self.view insertSubview:_myWeb atIndex:0];
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.navigationItem.title = title;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

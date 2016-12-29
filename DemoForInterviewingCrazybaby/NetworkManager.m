//
//  NetworkManager.m
//  DemoForInterviewingCrazybaby
//
//  Created by Han on 16/12/27.
//  Copyright © 2016年 韩. All rights reserved.
//

#import "NetworkManager.h"
#import "RepoModel.h"

static NSString *const ApiHost = @"https://api.github.com/";
static NSString *const access_token = @"&access_token=e18edd243ff7f68a142c8f5c7e194b946977f189";

static NSString *const searchApi = @"search/repositories";

@interface NetworkManager ()
@property(nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation NetworkManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSURL *url = [NSURL URLWithString:ApiHost];
//        _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
        _manager = [AFHTTPSessionManager manager];
        AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
        responseSerializer.removesKeysWithNullValues = YES;
        responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/json", @"application/json", @"text/javascript", @"text/html", nil];
        _manager.responseSerializer = responseSerializer;
    }
    return self;
}

+ (instancetype)sharedManager {
    static NetworkManager *_sharedManager= nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
    });
    
    return _sharedManager;
}

- (void)searchWithKeywords:(NSString *)keyword page:(NSInteger) page success:(void(^)(id response))successBlock Failed:(void(^)(NSError *error))failedBlock
{
    NSString *url = [NSString stringWithFormat:@"https://api.github.com/search/repositories"];
    NSLog(@"my url == %@",url);
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"q"] = keyword;
    parameters[@"page"] = [NSString stringWithFormat:@"%ld",page];
    [_manager.operationQueue cancelAllOperations];
        [_manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"success == %@",responseObject);
            NSMutableArray *data = [NSMutableArray array];
            for (NSDictionary *dic in responseObject[@"items"]) {
                RepoModel *repo = [[RepoModel alloc] initWithDictionary:dic];
                [data addObject:repo];
            }
            successBlock(data);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failedBlock(error);
        }];
    

    
}



@end

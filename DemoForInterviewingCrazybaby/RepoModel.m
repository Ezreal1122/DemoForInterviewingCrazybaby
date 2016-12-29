//
//  RepoModel.m
//  DemoForInterviewingCrazybaby
//
//  Created by 吴海文 on 16/12/27.
//  Copyright © 2016年 韩. All rights reserved.
//

#import "RepoModel.h"

@implementation RepoModel

-(instancetype)initWithDictionary:(NSDictionary *)itemDic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:itemDic];
        _repoName = itemDic[@"name"];
        _ownerName = itemDic[@"owner"][@"login"];
        _avatar_url = itemDic[@"owner"][@"avatar_url"];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end

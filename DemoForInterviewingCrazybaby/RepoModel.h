//
//  RepoModel.h
//  DemoForInterviewingCrazybaby
//
//  Created by 吴海文 on 16/12/27.
//  Copyright © 2016年 韩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RepoModel : NSObject

@property (nonatomic, copy)NSString *repoName;
@property (nonatomic, copy)NSString *ownerName;
@property (nonatomic, copy)NSString *html_url;
@property (nonatomic, copy)NSString *full_name;
@property (nonatomic, copy)NSString *language;
@property (nonatomic, copy)NSString *score;
@property (nonatomic, copy)NSString *watchers;
@property (nonatomic, copy)NSString *avatar_url;
@property (nonatomic, retain)NSNumber *stargazers_count;

-(instancetype)initWithDictionary:(NSDictionary *)itemDic;

@end

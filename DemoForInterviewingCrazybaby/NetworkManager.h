//
//  NetworkManager.h
//  DemoForInterviewingCrazybaby
//
//  Created by 吴海文 on 16/12/27.
//  Copyright © 2016年 韩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface NetworkManager : NSObject

+ (instancetype)sharedManager;

- (void)searchWithKeywords:(NSString *)keyword page:(NSInteger) page success:(void(^)(id response))successBlock Failed:(void(^)(NSError *error))failedBlock;
@end

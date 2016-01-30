//
//  AcronymDataFetch.h
//  AcronymFinder
//
//  Created by mugunth chandran on 1/29/16.
//  Copyright © 2016 Mugunth Chandran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface AcronymDataFetch : NSObject


+ (AcronymDataFetch *)instance;
+ (void)fetchAcronym:(NSString *)acronym success:(void (^)(NSURLSessionDataTask *task, id response))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end

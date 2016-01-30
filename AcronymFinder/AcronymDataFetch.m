//
//  AcronymDataFetch.m
//  AcronymFinder
//
//  Created by mugunth chandran on 1/29/16.
//  Copyright © 2016 Mugunth Chandran. All rights reserved.
//

#import "AcronymDataFetch.h"
#import "AFNetworkActivityIndicatorManager.h"

@interface AcronymDataFetch()
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

@implementation AcronymDataFetch

static NSString *BASE_URL = @"http://www.nactem.ac.uk/software/acromine/";

+ (AcronymDataFetch *)instance {
    static AcronymDataFetch *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (id)init {
    self = [super init];
    if (self) {
        self.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString: BASE_URL]];
        self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"text/plain"]];
        self.manager.completionQueue = dispatch_queue_create("FetchData", DISPATCH_QUEUE_SERIAL);
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    }
    return self;
}

+ (void)fetchAcronym:(NSString *)acronym success:(void (^)(NSURLSessionDataTask *task, id response))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    NSDictionary *parameters = @{@"sf": acronym, @"lf": @""};
    [[self instance].manager GET:@"dictionary.py" parameters:parameters progress:nil success:success failure:failure];
}

@end

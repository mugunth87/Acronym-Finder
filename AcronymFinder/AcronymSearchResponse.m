//
//  AcronymSearchResponse.m
//  AcronymFinder
//
//  Created by mugunth chandran on 1/29/16.
//  Copyright © 2016 Mugunth Chandran. All rights reserved.
//

#import "AcronymSearchResponse.h"

@interface AcronymSearchResponse()

@property (nonatomic, strong) NSDictionary *data;

@end

@implementation AcronymSearchResponse

@synthesize data=_data;

- (id)init {
    if (self = [self initWithDict:nil]) {
    }
    return self;
}

- (id)initWithDict:(NSDictionary *)data {
    if (self = [super init]) {
        _data = data;
        if (_data == nil) {
            _data = [NSDictionary dictionary];
        }
    }
    return self;
}

- (NSArray *)searchResults {
    return self.data[@"lfs"];
}

@end

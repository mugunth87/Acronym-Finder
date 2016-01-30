//
//  AcronymSearchResponse.h
//  AcronymFinder
//
//  Created by mugunth chandran on 1/29/16.
//  Copyright © 2016 Mugunth Chandran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AcronymSearchResponse : NSObject

- (id)initWithDict:(NSDictionary *)data;

@property (nonatomic, strong) NSArray *searchResults;

@end

//
//  fetchData.h
//  bitGray
//
//  Created by Mario Vizcaino on 15/02/17.
//  Copyright © 2017 Mario Vizcaino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFHTTPSessionManager.h>
#import <AFNetworking/AFURLSessionManager.h>

@interface FetchData : NSObject

+ (NSURLSessionDataTask *)getUsers:(NSString *)url completionHandler:(void (^)(NSArray *responseData, NSError *error))completionHandler;
@end

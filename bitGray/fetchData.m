//
//  fetchData.m
//  bitGray
//
//  Created by Mario Vizcaino on 15/02/17.
//  Copyright © 2017 Mario Vizcaino. All rights reserved.
//

#import "fetchData.h"

@implementation FetchData

+ (NSURLSessionDataTask *)getUsers:(NSString *)url completionHandler:(void (^)(NSArray *responseData, NSError *error))completionHandler {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:url ];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            completionHandler(nil, error);
        } else {
            completionHandler(responseObject, nil);
        }
    }];
    [dataTask resume];
    
    return dataTask;
    
}
@end

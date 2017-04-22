//
//  ApiHandler.m
//  Catalouge
//
//  Created by Lucky  on 4/22/17..
//  Copyright (c) 2017 Lucky. All rights reserved.
//

#import "ApiHandler.h"

static ApiHandler *apiHandler;
@implementation ApiHandler


+(ApiHandler*)sharedApiHandler{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    
        if (!apiHandler) {
            apiHandler = [[ApiHandler alloc] init];
            
        }
    });
    
    return apiHandler;
}


- (NSOperationQueue*)apiHandlerQueue{

    
    if (!_apiHandlerQueue) {
        
        _apiHandlerQueue = [[NSOperationQueue alloc] init];
        [_apiHandlerQueue setName:@"com.diona.apihandler"];
    }
    
    return _apiHandlerQueue;
}


- (void)getServiceProviderListApiHandlerWithCallBlock:(GetServiceProviderListApiCallBlock)getServiceProviderListApiCallBlock profileId:(NSString*)Id{
    [[[NSURLSession sharedSession] dataTaskWithRequest:Id == nil ?[self getURLRequestForAPIHitsProfileId:@""]: [self getURLRequestForAPIHitsProfileId:Id] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            getServiceProviderListApiCallBlock(nil,error);
        }else{
            NSError *jsonError = nil;
            id responsedData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&jsonError];
            getServiceProviderListApiCallBlock(responsedData,error);
        }
        
    }] resume];
    
}


#pragma mark - NSURLRequest
- (NSURLRequest*)getURLRequestForAPIHitsProfileId:(NSString*)Id{
    
    NSURL *url = [NSURL URLWithString: !Id.length ? ROOT_API_PATH : [NSString stringWithFormat:@"%@/%@",ROOT_API_PATH,Id]];
    
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:180];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    return request;
}


@end

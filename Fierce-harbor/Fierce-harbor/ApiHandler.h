//
//  ApiHandler.h
//  Catalouge
//
//  Created by Lucky  on 4/22/17.
//  Copyright (c) 2017 Lucky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApiHandler : NSObject

@property(nonatomic,strong ) NSOperationQueue *apiHandlerQueue;

+(ApiHandler*)sharedApiHandler;
typedef void(^GetServiceProviderListApiCallBlock)(id data,NSError *error);
- (void)getServiceProviderListApiHandlerWithCallBlock:(GetServiceProviderListApiCallBlock)getServiceProviderListApiCallBlock profileId:(NSString*)Id;

@end

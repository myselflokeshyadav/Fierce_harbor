//
//  BaseClass.h
//
//  Created by Lucky  on 4/22/17
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface BaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double internalBaseClassIdentifier;
@property (nonatomic, strong) NSString *profilePicture;
@property (nonatomic, strong) NSString *fullName;
@property (nonatomic, strong) NSString *profile_picture;
@property (assign) BOOL isfav;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

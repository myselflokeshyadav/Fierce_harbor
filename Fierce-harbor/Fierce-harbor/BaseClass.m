//
//  BaseClass.m
//
//  Created by Lucky  on 4/22/17
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "BaseClass.h"


NSString *const kBaseClassId = @"id";
NSString *const kBaseClassProfilePicture = @"profile_picture";


@interface BaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BaseClass

@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize profilePicture = _profilePicture;
@synthesize isfav = _isfav;
@synthesize fullName = _fullName;
@synthesize profile_picture = _profile_picture;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.internalBaseClassIdentifier = [[self objectOrNilForKey:kBaseClassId fromDictionary:dict] doubleValue];
            self.profilePicture = [self objectOrNilForKey:kBaseClassProfilePicture fromDictionary:dict];
            self.isfav = false;

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.internalBaseClassIdentifier] forKey:kBaseClassId];
    [mutableDict setValue:self.profilePicture forKey:kBaseClassProfilePicture];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.internalBaseClassIdentifier = [aDecoder decodeDoubleForKey:kBaseClassId];
    self.profilePicture = [aDecoder decodeObjectForKey:kBaseClassProfilePicture];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_internalBaseClassIdentifier forKey:kBaseClassId];
    [aCoder encodeObject:_profilePicture forKey:kBaseClassProfilePicture];
}

- (id)copyWithZone:(NSZone *)zone
{
    BaseClass *copy = [[BaseClass alloc] init];
    
    if (copy) {

        copy.internalBaseClassIdentifier = self.internalBaseClassIdentifier;
        copy.profilePicture = [self.profilePicture copyWithZone:zone];
        copy.isfav = self.isfav;
        copy.fullName = self.fullName;
    }
    
    return copy;
}


@end

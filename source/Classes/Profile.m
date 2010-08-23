//
//  Profile.m
//  Greenhouse
//
//  Created by Roy Clarkson on 6/11/10.
//  Copyright 2010 VMware, Inc. All rights reserved.
//

#import "Profile.h"


@implementation Profile

@synthesize accountId;
@synthesize displayName;
@synthesize pictureUrl;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
	if ((self = [super init]))
	{
		if (dictionary)
		{
			self.accountId = [dictionary integerForKey:@"accountId"];
			self.displayName = [dictionary stringByReplacingPercentEscapesForKey:@"displayName" usingEncoding:NSUTF8StringEncoding];			
			self.pictureUrl = [dictionary urlForKey:@"pictureUrl"];
		}
	}
	
	return self;
}


#pragma mark -
#pragma mark NSObject methods

- (NSString *)description
{
	return self.displayName;
}

- (void)dealloc
{
	[displayName release];
	[pictureUrl release];
	
	[super dealloc];
}

@end
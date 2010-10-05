//
//  EventSession.m
//  Greenhouse
//
//  Created by Roy Clarkson on 7/21/10.
//  Copyright 2010 VMware, Inc. All rights reserved.
//

#import "EventSession.h"
#import "EventSessionLeader.h"


@interface EventSession()

- (NSArray *)processLeaderData:(NSArray *)leadersJson;

@end


@implementation EventSession

@synthesize number;
@synthesize title;
@synthesize startTime;
@synthesize endTime;
@synthesize description;
@synthesize leaders;
@synthesize hashtag;
@synthesize isFavorite;
@synthesize rating;
@synthesize location;
@dynamic leaderCount;
@dynamic leaderDisplay;


#pragma mark -
#pragma mark Public methods

- (NSInteger)leaderCount
{
	if (leaders)
	{
		return [leaders count];
	}
	
	return 0;
}

- (NSString *)leaderDisplay
{
	if (leaders)
	{
		return [self.leaders componentsJoinedByString:@", "];
	}
	
	return @"";
}


#pragma mark -
#pragma mark Private methods

- (NSArray *)processLeaderData:(NSArray *)leadersJson
{
	if (leadersJson)
	{
		NSMutableArray *tmpLeaders = [[NSMutableArray alloc] initWithCapacity:[leadersJson count]];
		
		for (NSDictionary *d in leadersJson) 
		{
			EventSessionLeader *leader = [[EventSessionLeader alloc] initWithDictionary:d];
			[tmpLeaders addObject:leader];
			[leader release];
		}
		
		NSArray *leadersArray = [NSArray arrayWithArray:tmpLeaders];
		[tmpLeaders release];
		
		return leadersArray;
	}
	
	return [NSArray array];
}


#pragma mark -
#pragma mark WebDataModel methods

- (id)initWithDictionary:(NSDictionary *)dictionary
{
	if ((self = [super init]))
	{
		if (dictionary)
		{
			self.number = [dictionary stringForKey:@"number"];
			self.title = [dictionary stringByReplacingPercentEscapesForKey:@"title" usingEncoding:NSUTF8StringEncoding];
			self.startTime = [dictionary dateWithMillisecondsSince1970ForKey:@"startTime"];
			self.endTime = [dictionary dateWithMillisecondsSince1970ForKey:@"endTime"];
			self.description = [[dictionary stringForKey:@"description"] stringBySimpleXmlDecoding];
			self.leaders = [self processLeaderData:[dictionary objectForKey:@"leaders"]];
			self.hashtag = [dictionary stringByReplacingPercentEscapesForKey:@"hashtag" usingEncoding:NSUTF8StringEncoding];
			self.isFavorite = [dictionary boolForKey:@"favorite"];
			self.rating = [dictionary doubleForKey:@"rating"];
			self.location = [[dictionary stringForKey:@"location"] stringBySimpleXmlDecoding];
		}
	}
	
	return self;
}


#pragma mark -
#pragma mark NSObject methods

- (void)dealloc
{
	[number release];
	[title release];
	[startTime release];
	[endTime release];
	[description release];
	[leaders release];
	[hashtag release];
	[location release];
	
	[super dealloc];
}

@end
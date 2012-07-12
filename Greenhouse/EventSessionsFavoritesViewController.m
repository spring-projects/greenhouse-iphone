//
//  Copyright 2010-2012 the original author or authors.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
//
//  EventSessionsFavoritesViewController.m
//  Greenhouse
//
//  Created by Roy Clarkson on 8/2/10.
//

#import "EventSessionsFavoritesViewController.h"


@interface EventSessionsFavoritesViewController()

@property (nonatomic, retain) EventSessionController *eventSessionController;

- (void)completeFetchFavoriteSessions:(NSArray *)sessions;

@end


@implementation EventSessionsFavoritesViewController

@synthesize eventSessionController;

- (void)completeFetchFavoriteSessions:(NSArray *)sessions
{
	[eventSessionController release];
	self.eventSessionController = nil;
	self.arraySessions = sessions;
	[self.tableView reloadData];
	[self dataSourceDidFinishLoadingNewData];
}

#pragma mark -
#pragma mark EventSessionControllerDelegate methods

- (void)fetchFavoriteSessionsDidFinishWithResults:(NSArray *)sessions
{
	[self completeFetchFavoriteSessions:sessions];
}

- (void)fetchFavoriteSessionsDidFailWithError:(NSError *)error
{
	NSArray *array = [[NSArray alloc] init];
	[self completeFetchFavoriteSessions:array];
	[array release];
}

#pragma mark -
#pragma mark PullRefreshTableViewController methods

- (BOOL)shouldReloadData
{
	return (!self.arraySessions || self.lastRefreshExpired || [EventSessionController shouldRefreshFavorites]);
}

- (void)reloadTableViewDataSource
{
	self.eventSessionController = [[EventSessionController alloc] init];
	eventSessionController.delegate = self;
	
	[eventSessionController fetchFavoriteSessionsByEventId:self.event.eventId];
}


#pragma mark -
#pragma mark UIViewController methods

- (void)viewDidLoad 
{
	self.lastRefreshKey = @"EventSessionFavoritesViewController_LastRefresh";
	
    [super viewDidLoad];
	
	self.title = @"My Favorites";
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload 
{
    [super viewDidUnload];
	
	self.eventSessionController = nil;
}


#pragma mark -
#pragma mark NSObject methods

- (void)dealloc 
{
    [super dealloc];
}


@end
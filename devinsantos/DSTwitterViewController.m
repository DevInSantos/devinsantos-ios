//
//  DSTwitterViewController.m
//  devinsantos
//
//  Created by Fernando Ribeiro on 10/19/12.
//  Copyright (c) 2012 Fernando Bass. All rights reserved.
//

#import "DSTwitterViewController.h"
#import "DSTwitterViewCell.h"
#import "AFNetworking.h"
#import "DSTwitter.h"
#import "DSTwitterParser.h"
#import "LoadingView.h"

@interface DSTwitterViewController ()
{
    NSArray *array;
    LoadingView *loadingView;
    EGORefreshTableHeaderView *_refreshHeaderView;
	BOOL _reloading;
}
@end

@implementation DSTwitterViewController

- (void)viewDidLoad
{
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"texture"]]];
    loadingView = [[LoadingView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self reloadTableViewDataSource];
    
    if (_refreshHeaderView == nil) {
		
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, 320, self.tableView.bounds.size.height)];
		view.delegate = self;
		[self.tableView addSubview:view];
		_refreshHeaderView = view;
		
	}
	[_refreshHeaderView refreshLastUpdatedDate];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)loadTwitter
{
    NSURL *url = [NSURL URLWithString:@"http://search.twitter.com/search.json?q=devinsantos"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        array = [NSArray arrayWithArray:[DSTwitterParser parseTwitterWithJSON:[JSON objectForKey:@"results"]]];
        [self.tableView reloadData];
        [self doneLoadingTableViewData];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {

    }];
    
    [operation start];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DSTwitterViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    DSTwitter *twitter = [array objectAtIndex:indexPath.row];
    
    cell.name.text = twitter.name;
    cell.textView.text = twitter.text;
    
    NSURL *url = [NSURL URLWithString:twitter.imageUrlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [cell.imageView setImageWithURLRequest:request placeholderImage:[UIImage imageNamed:@"Icon"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        cell.imageView.image = [self scaleTheImage:image];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        
    }];
    return cell;
}

-(UIImage*)scaleTheImage:(UIImage*)image
{
    CGSize size = CGSizeMake(80, 80);
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource
{
    [self loadTwitter];
    [loadingView showOnView:self.navigationController.view animated:YES];
	_reloading = YES;
	
}

- (void)doneLoadingTableViewData
{
	_reloading = NO;
    [loadingView hideAnimated:YES];
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
	
}

#pragma mark - UIScrollViewDelegate Methods

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}


#pragma mark - EGORefreshTableHeaderDelegate 

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
	[self reloadTableViewDataSource];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view
{
	return _reloading;
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view
{
	return [NSDate date];
	
}

@end

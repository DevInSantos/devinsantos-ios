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

@interface DSTwitterViewController ()
{
    NSArray *array;
}
@end

@implementation DSTwitterViewController

- (void)viewDidLoad
{
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"texture"]]];
    [self loadTwitter];
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
@end

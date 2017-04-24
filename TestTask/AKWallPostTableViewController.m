//
//  AKWallPostTableViewController.m
//  TestTask
//
//  Created by Andrii on 4/13/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import "AKWallPostTableViewController.h"
#import "AKServerManager.h"

#import "AKPost.h"

#import "AKCommentTableViewCell.h"
#import "AKImageTableViewCell.h"
#import "AKVideoTableViewCell.h"
#import "AKPostTableViewCell.h"

#import "AKDetailTableViewController.h"

#import "UIView+MyCell.h"
#import "UIImageView+AFNetworking.h"
#import "UIColor+MyColors.h"

static NSInteger postsCount = 20;
static NSString *eventFeedID = @"-57846937";

@interface AKWallPostTableViewController () <AKPostDelegate>

@property (assign,nonatomic) BOOL loadingData;

@property (strong, nonatomic) NSMutableArray *posts;
@property (strong, nonatomic) NSMutableDictionary *heightAtIndexPath;
@property (strong, nonatomic) NSMutableDictionary *likesIndexPaths;

@end

// MDK -57846937
// IOS -58860049

@implementation AKWallPostTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.posts = [NSMutableArray array];
    self.heightAtIndexPath = [NSMutableDictionary new];
    self.likesIndexPaths = [NSMutableDictionary dictionary];
    
    [self getPostsFromServer];
    
    
    self.loadingData = YES;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 500;
    
    self.tableView.decelerationRate = UIScrollViewDecelerationRateNormal;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

#pragma mark - AKPostDelegate

- (void)commentButton:(UIButton *)sender {
    AKPostTableViewCell *postCell = (AKPostTableViewCell *)[sender superCell];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:postCell];
    
    AKPost *post = [self.posts objectAtIndex:indexPath.row];
    
    AKDetailTableViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AKDetailTableViewController"];
    vc.groupID = eventFeedID;
    
}
- (void)likeButton:(UIButton *)sender {
    AKPostTableViewCell *postCell = (AKPostTableViewCell *)[sender superCell];
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:postCell];
    
    if ([self.likesIndexPaths objectForKey:indexPath]) {
        [self.likesIndexPaths removeObjectForKey:indexPath];

        postCell.likeButton.backgroundColor = [UIColor clearColor];
        
    } else {
        [self.likesIndexPaths setObject:@(1) forKey:indexPath];

        postCell.likeButton.backgroundColor = [UIColor yellowColor];
    }
}

- (void)sheetButton:(UIButton *)sender {
    AKPostTableViewCell *postCell = (AKPostTableViewCell *)[sender superCell];
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:postCell];
    
    UIAlertAction *doSomting1 = [UIAlertAction actionWithTitle:@"doSomting1"
                                                     style:UIAlertActionStyleDefault
                                                   handler:nil];
    
    UIAlertAction *doSomting2 = [UIAlertAction actionWithTitle:@"doSomting2"
                                                         style:UIAlertActionStyleDefault
                                                       handler:nil];
    
    UIAlertAction *doSomting3 = [UIAlertAction actionWithTitle:@"doSomting3"
                                                         style:UIAlertActionStyleDefault
                                                       handler:nil];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:nil];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Sectio: %zd, Row: %zd", indexPath.section, indexPath.row]
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertController addAction:doSomting1];
    [alertController addAction:doSomting2];
    [alertController addAction:doSomting3];
    [alertController addAction:cancel];

    [self presentViewController:alertController animated:YES completion:nil];
    
}


- (void)getPostsFromServer {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[AKServerManager sharedManager] getWallPostsWithUserID:eventFeedID offset:self.posts.count count:postsCount resultBlock:^(NSArray *posts, NSError *error, NSInteger statusCode) {
            
            [self.posts addObjectsFromArray:posts];
            
            NSMutableArray *newPath = [NSMutableArray array];
            for (int i = (int)[self.posts count] - (int)[posts count]; i < [self.posts count]; i++) {
                [newPath addObject:[NSIndexPath indexPathForRow:i inSection:0]];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.tableView reloadData];
                self.loadingData = NO;
            });
        }];
    });
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = nil;
    AKTableViewCell *postCell = nil;
    AKPost *post =  [self.posts objectAtIndex:indexPath.row];
  
    if (post.type == AKPostTypeComment) {
        postCell = [tableView dequeueReusableCellWithIdentifier:@"AKPostTableViewCell"];

    } else if (post.type == AKPostTypeImage) {
        postCell = [tableView dequeueReusableCellWithIdentifier:@"AKImageTableViewCell"];

    } else if (post.type == AKPostTypeVideo) {
        postCell = [tableView dequeueReusableCellWithIdentifier:@"AKVideoTableViewCell"];
        return postCell;

    } else {
        identifier = @"Cell";
    }
    
    postCell.post = post;
    
    return postCell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSNumber *height = @(cell.frame.size.height);
    [self.heightAtIndexPath setObject:height forKey:indexPath];
    
    AKTableViewCell *postCell = (AKTableViewCell *)cell;
    
    if ([self.likesIndexPaths objectForKey:indexPath]) {
        postCell.likeButton.backgroundColor = [UIColor yellowColor];
    }
    
    
    AKPost *post =  [self.posts objectAtIndex:indexPath.row];
    
    if ([cell isKindOfClass:[AKVideoTableViewCell class]]) {
        postCell.post = post;
    }
    
    postCell.delegate = self;


    if (self.posts.count <= indexPath.row + postsCount / 2  && !self.loadingData) {
        self.loadingData = YES;
        [self getPostsFromServer];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath {
    
    if ([cell isKindOfClass:[AKVideoTableViewCell class]]) {
        AKVideoTableViewCell *videoCell = (AKVideoTableViewCell *)cell;
        //videoCell.webView = nil;
        
    } else if ([cell isKindOfClass:[AKImageTableViewCell class]]) {
        AKImageTableViewCell *imageCell = (AKImageTableViewCell *)cell;
        imageCell.ownerPostImageView.image = nil;
        
    }
    
    AKTableViewCell *postCell = (AKTableViewCell *)cell;
    postCell.likeButton.backgroundColor = [UIColor clearColor];
    
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSNumber *height = [self.heightAtIndexPath objectForKey:indexPath];
    if(height) {
        return height.floatValue;
        
    } else {
        return UITableViewAutomaticDimension;
    }
}





@end

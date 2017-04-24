//
//  AKDetailTableViewController.m
//  TestTask
//
//  Created by Andrii on 4/20/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import "AKDetailTableViewController.h"

#import "AKPost.h"
#import "AKComment.h"

#import "AKCommentTableViewCell.h"

#import "AKServerManager.h"

const NSInteger commentsCount = 20;

@interface AKDetailTableViewController ()

@property (strong, nonatomic) NSMutableArray *comments;

@end

@implementation AKDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.comments = [NSMutableArray array];
    [self getCommentsFromServer];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) getCommentsFromServer {
    [[AKServerManager sharedManager] getCommentsFromGroupID:self.groupID
                                                 withPostID:self.post.ID
                                                 withOffset:self.comments.count
                                                      count:commentsCount
                                                resultBlock:^(NSArray *comments, NSError *error) {
                                                    
                                                    [self.comments addObjectsFromArray:comments];
//                                                    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
//                                                    [self.comments sortUsingDescriptors:[NSArray arrayWithObject:descriptor]];
                                                    [self.tableView reloadData];
                                                }];
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.comments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"AKCommentTableViewCell";
    
    AKComment *comment = [self.comments objectAtIndex:indexPath.row];
    
    AKCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.comment = comment;
    
    return cell;
}


@end

//
//  AKWallPost.m
//  HomeTask_43_Client_Server_APIs_Part_1_Basics
//
//  Created by Andrii on 10/11/16.
//  Copyright © 2016 Andrii. All rights reserved.
//

#import "AKPost.h"


@implementation AKPost

- (instancetype)initWithResponse:(NSDictionary *)response {
    
    self = [super init];
    if (self) {
        
        NSDictionary *attachment = [[response objectForKey:@"attachments"] firstObject];
        
        if (attachment) {
            NSString *type = [attachment objectForKey:@"type"];
            
            if ([type isEqualToString:@"photo"]) {
                self.type = AKPostTypeImage;
                
            } else if ([type isEqualToString:@"video"]) {
                self.type = AKPostTypeVideo;

            } else {
                self.type = AKPostTypeComment;
            }
            
        } else {
            self.type = AKPostTypeComment;
        }
        
        self.ID = [response objectForKey:@"id"];

        NSDictionary *likes = [response objectForKey:@"likes"];
        NSDictionary *comments = [response objectForKey:@"comments"];
        
        self.likesCount = [[likes objectForKey:@"count"] integerValue];
        self.comentsCount = [[comments objectForKey:@"count"] intValue];

        self.ownerID = [[response objectForKey:@"from_id"] stringValue];
        self.dateOfPost = [[response objectForKey:@"date"] doubleValue];
        self.text =  [response objectForKey:@"text"];
        
        self.text = [self.text stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
   
        NSDictionary *photo = [attachment objectForKey:@"photo"];
        NSDictionary *video = [attachment objectForKey:@"video"];

        self.photo_130 = [NSURL URLWithString:[video objectForKey:@"photo_604"]];
        self.photo_320 = [NSURL URLWithString:[video objectForKey:@"photo_807"]];
        self.photo_640 = [NSURL URLWithString:[video objectForKey:@"photo_1280"]];
        
        self.photo_604 = [NSURL URLWithString:[photo objectForKey:@"photo_604"]];
        self.photo_807 = [NSURL URLWithString:[photo objectForKey:@"photo_807"]];
        self.photo_1280 = [NSURL URLWithString:[photo objectForKey:@"photo_1280"]];
        
        self.width = [[photo objectForKey:@"width"] floatValue];
        self.height = [[photo objectForKey:@"height"] floatValue];

    }
    return self;
}


@end

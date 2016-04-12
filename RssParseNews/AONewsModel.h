//
//  AONewsModel.h
//  RssParseNews
//
//  Created by admin on 3/18/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AONewsModel : NSObject

@property (strong, nonatomic) NSString* autor;
@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* pubDate;
@property (strong, nonatomic) NSString* image;
@property (strong, nonatomic) NSString* link;

- (instancetype) initWithTitle:(NSString*) title
                      andAutor:(NSString*) autor
                    andPubDate:(NSString*) pubDate
                      andImage:(NSString*) image
                       andLink:(NSString*) link;

@end

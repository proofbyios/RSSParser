//
//  AONewsModel.m
//  RssParseNews
//
//  Created by admin on 3/18/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import "AONewsModel.h"

@implementation AONewsModel

- (instancetype) initWithTitle:(NSString*) title
                      andAutor:(NSString*) autor
                    andPubDate:(NSString*) pubDate
                      andImage:(NSString*) image
                       andLink:(NSString*) link {
    
    self = [super init];
    if (self) {
        self.autor = autor;
        self.title = title;
        self.pubDate = pubDate;
        self.image = image;
        self.link = link;
    }
    return self;
    
}


@end

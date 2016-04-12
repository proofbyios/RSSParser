//
//  AONewsFeedTableViewController.m
//  RssParseNews
//
//  Created by admin on 3/18/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import "AONewsFeedTableViewController.h"
#import "AONewsModel.h"
#import "AONewsTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "AONewsViewController.h"

@interface AONewsFeedTableViewController () <NSXMLParserDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSString* currentElement;
@property (strong, nonatomic) NSString* currentTitle;
@property (strong, nonatomic) NSString* currentAutor;
@property (strong, nonatomic) NSString* currentLink;
@property (strong, nonatomic) NSString* currentImageLink;
@property (strong, nonatomic) NSString* currentPubDate;

@property (strong, nonatomic) NSMutableArray* newsArray;

@property (strong, nonatomic) AONewsModel* selectedNews;

@end

@implementation AONewsFeedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIEdgeInsets insets = UIEdgeInsetsMake(10, 0, 0, 0);
    self.tableView.contentInset = insets;
    
    self.newsArray = [NSMutableArray array];

    NSURL* url = [NSURL URLWithString:@"http://rss.cbc.ca/lineup/topstories.xml"];
    
    NSXMLParser* parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    parser.delegate = self;
    [parser parse];
    
    
}

#pragma mark - NSXMLParserDelegate

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    NSLog(@"parserDidStartDocument");
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    NSLog(@"parserDidEndDocument");
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(NSDictionary<NSString *, NSString *> *)attributeDict {
    
    self.currentElement = elementName;
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if ([self.currentElement isEqualToString:@"title"]) {
        self.currentTitle = string;
    } else if ([self.currentElement isEqualToString:@"pubDate"]) {
        self.currentPubDate = string;
    } else if ([self.currentElement isEqualToString:@"author"]) {
        self.currentAutor = string;
    } else if ([self.currentElement isEqualToString:@"link"]) {
        self.currentLink = string;
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock {
    
    [self parseCDATABlockWithBlock:CDATABlock];
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName {
    
    if ([elementName isEqualToString:@"item"]) {
        
        AONewsModel* news = [[AONewsModel alloc] initWithTitle:self.currentTitle
                                                      andAutor:self.currentAutor
                                                    andPubDate:self.currentPubDate
                                                      andImage:self.currentImageLink
                                                       andLink:self.currentLink];
        
        [self.newsArray addObject:news];
    }
    
    self.currentElement = nil;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.newsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* identifier = @"Cell";
    
    AONewsModel* news = [self.newsArray objectAtIndex:indexPath.row];
    
    AONewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell.titleNewsLabel.text = [NSString stringWithFormat:@"%@", news.title];
    cell.pubDateNewsLabel.text = [NSString stringWithFormat:@"%@", news.pubDate];
    cell.autorNewsLabel.text = [NSString stringWithFormat:@"Autor: %@", news.autor];

    NSURL* imageURL = [NSURL URLWithString:news.image];
    [cell.imageNewsImageView setImageWithURL:imageURL];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (nullable NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.selectedNews = [self.newsArray objectAtIndex:indexPath.row];
    
    return indexPath;
}


#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   
    AONewsViewController* dvc = [segue destinationViewController];
    [dvc setCurrentNews:self.selectedNews];
    
}

#pragma mark - Methods

- (void) parseCDATABlockWithBlock:(NSData*) block {
    
    NSString* cdataString = [[NSString alloc] initWithData:block encoding:NSUTF8StringEncoding];
    
    NSString* searchString = @"src='";
    
    if ([cdataString rangeOfString:searchString].location != NSNotFound) {
        /*
        NSString* tempString = nil;
        
        NSRange startRange = [cdataString rangeOfString:searchString];
        
        if (startRange.location != NSNotFound) {
            tempString = [cdataString substringFromIndex:startRange.location + [searchString length]];
        }
        
        NSRange endRange = [tempString rangeOfString:@"'"];
        
        if (endRange.location != NSNotFound) {
            tempString = [tempString substringToIndex:endRange.location];
        }
    
        self.currentImageLink = tempString;
     */
    
        NSError* error = nil;
        NSDataDetector* detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:&error];
        
        NSArray* matches = [detector matchesInString:cdataString options:0 range:NSMakeRange(0, [cdataString length])];
        
        NSTextCheckingResult* result = [matches firstObject];
        NSURL* tempUrl = result.URL;
        NSString* tempString2 = [tempUrl absoluteString];
        
        if ([tempString2 rangeOfString:@"'"].location != NSNotFound) {
            NSInteger fullString = [tempString2 length] - 1;
            tempString2 = [tempString2 substringToIndex:fullString];
        }

        self.currentImageLink = tempString2;
        
    } else {
        
        self.currentTitle = cdataString;
        
    }
}

#pragma mark - didReceiveMemoryWarning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

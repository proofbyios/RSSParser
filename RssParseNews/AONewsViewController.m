//
//  AONewsViewController.m
//  RssParseNews
//
//  Created by admin on 3/19/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import "AONewsViewController.h"

@interface AONewsViewController () <UIWebViewDelegate>

@end

@implementation AONewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.currentNews.title;
    
    self.webView.delegate = self;
    
    NSURL* url = [NSURL URLWithString:self.currentNews.link];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:request];
    
    [self checkButtons];
    
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    [self checkButtons];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    [self checkButtons];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    [self checkButtons];
    
}

#pragma mark - Actions

- (IBAction)actionGoBack:(UIBarButtonItem *)sender {
    if ([self.webView canGoBack]) {
        [self.webView stopLoading];
        [self.webView goBack];
    }
}

- (IBAction)actionGoForward:(UIBarButtonItem *)sender {
    if ([self.webView canGoForward]) {
        [self.webView stopLoading];
        [self.webView goForward];
    }
}

- (IBAction)actionRefresh:(UIBarButtonItem *)sender {
        [self.webView stopLoading];
        [self.webView reload];
}

#pragma  mark - Methods 

- (void) checkButtons {
    
    self.backButtonItem.enabled = [self.webView canGoBack];
    self.forwardButtonItem.enabled = [self.webView canGoForward];
    
}

#pragma mark - didReceiveMemoryWarning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

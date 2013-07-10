//
//  AttendanceOAuthViewController.m
//  mobile-attendance
//
//  Created by nlambson on 7/9/13.
//  Copyright (c) 2013 nlambson. All rights reserved.
//

#import "AttendanceOAuthViewController.h"

@interface AttendanceOAuthViewController ()

@end

@implementation AttendanceOAuthViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;
    
    NSString *address = @"https://www.google.com/search?";
    NSString *params1 = @"q=instructure+panda&tbm=isch";
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",address,params1];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

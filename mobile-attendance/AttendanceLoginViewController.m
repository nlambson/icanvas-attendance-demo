//
//  AttendanceLoginViewController.m
//  mobile-attendance
//
//  Created by nlambson on 7/9/13.
//  Copyright (c) 2013 nlambson. All rights reserved.
//

#import "AttendanceLoginViewController.h"

@interface AttendanceLoginViewController ()

@property (strong, nonatomic) IBOutlet UIButton *login;

@end

@implementation AttendanceLoginViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeWindow:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:Nil ];
}

@end

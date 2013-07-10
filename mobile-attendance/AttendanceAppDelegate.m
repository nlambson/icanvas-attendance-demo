//
//  AttendanceAppDelegate.m
//  mobile-attendance
//
//  Created by nlambson on 7/9/13.
//  Copyright (c) 2013 nlambson. All rights reserved.
//

#import "AttendanceAppDelegate.h"
#import "AttendanceViewController.h"

@implementation AttendanceAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    ////// USE THIS CODE IF YOU HAVE REMOVE THE MainStoryboard from the Project Summary Settings //////
    ////// THIS CODE LOADS ALL STORYBOARDS AND VIEWCONTROLLERS MANUALLY //////
    /*
    // Override point for customization after application launch.
    UIViewController *controller = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    // You can set up lots of things here
    // Styling
    // Tracking services
    // configuration and api
    // Verify that we have the access_token, otherwise load up another viewcontroller for the user
    // This Code can be extracted into its own method like "requestAccessTokenIfNecessary" similar to iCanvas
    UIStoryboard *loginStoryboard = [UIStoryboard storyboardWithName:@"AttendanceLoginStoryboard" bundle:nil];
    UIViewController *initialLoginVC = [loginStoryboard instantiateInitialViewController];
    initialLoginVC.modalPresentationStyle = UIModalPresentationPageSheet;
    
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    
    //This method "reloadUserInterface" loads up all the iphone/ipad views itself
    //[self reloadUserInterface]; //I've just put what reloadUserInterface and setupIphoneViews do inline
    [self.window.rootViewController dismissViewControllerAnimated:NO completion:NULL];
    UINavigationController *nav = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateInitialViewController];
    AttendanceViewController *dash = nav.viewControllers[0];
    self.window.rootViewController = nav;
    
    [controller presentViewController:initialLoginVC animated:YES completion:nil];
    
    //you may want a local variable keeping track of the viewcontroller you presented to login, see iCanvasAppDelegate
    //It appears that canvaskit has some fancy networking calls which can wait until you are logged in before executing.
    */
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    UIApplicationState state = [[UIApplication sharedApplication] applicationState];
    if (state == UIApplicationStateActive) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"CS 428" message:@"Checkin for class?" delegate:self cancelButtonTitle:@"Ignore" otherButtonTitles: @"Go", nil];
        [alert setTag: 2];
        [alert show];
    } else {
        //just ignore it...
    }
}

@end

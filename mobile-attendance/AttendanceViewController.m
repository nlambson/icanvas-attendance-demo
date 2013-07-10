//
//  AttendanceViewController.m
//  mobile-attendance
//
//  Created by nlambson on 7/9/13.
//  Copyright (c) 2013 nlambson. All rights reserved.
//

#import "AttendanceViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface AttendanceViewController () <CLLocationManagerDelegate> {
    BOOL _didStartMonitoringRegion;
}

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSMutableArray *geofences;

@end

@implementation AttendanceViewController

static NSString *GeofenceCellIdentifier = @"GeofenceCell";

#pragma mark -
#pragma mark Initialization
- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialize Location Manager
    self.locationManager = [[CLLocationManager alloc] init];
    
    // Configure Location Manager
    [self.locationManager setDelegate:self];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    
    // Load Geofences
    self.geofences = [NSMutableArray arrayWithArray:[[self.locationManager monitoredRegions] allObjects]];
}

#pragma mark -
#pragma mark View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Setup View
    [self setupView];
    
    // You could just do a simple check here to see if we have the users access_token
    UIStoryboard *loginStoryboard = [UIStoryboard storyboardWithName:@"AttendanceLoginStoryboard" bundle:nil];
    UIViewController *initialLoginVC = [loginStoryboard instantiateInitialViewController];
    initialLoginVC.modalPresentationStyle = UIModalPresentationPageSheet;
    
    [self presentViewController:initialLoginVC animated:YES completion:nil];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}

#pragma mark -
#pragma mark Table View Data Source Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.geofences ? 1 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.geofences count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:GeofenceCellIdentifier];
    
    // Fetch Geofence
    CLRegion *geofence = [self.geofences objectAtIndex:[indexPath row]];
    
    // Configure Cell
    CLLocationCoordinate2D center = [geofence center];
    NSString *text = [NSString stringWithFormat:@"%.5f | %.5f", center.latitude, center.longitude];
    [cell.textLabel setText:text];
    [cell.detailTextLabel setText:[geofence identifier]];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Fetch Monitored Region
        CLRegion *region = [self.geofences objectAtIndex:[indexPath row]];
        
        // Stop Monitoring Region
        [self.locationManager stopMonitoringForRegion:region];
        
        // Update Table View
        [self.geofences removeObject:region];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
        
        // Update View
        [self updateView];
    }
}

#pragma mark -
#pragma mark Location Manager Delegate Methods
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    if (locations && [locations count] && !_didStartMonitoringRegion) {
        // Update Helper
        _didStartMonitoringRegion = YES;
        
        // Fetch Current Location
        CLLocation *location = [locations objectAtIndex:0];
        
        // Initialize Region to Monitor
        CLRegion *region = [[CLRegion alloc] initCircularRegionWithCenter:[location coordinate] radius:200.0 identifier:[[NSUUID UUID] UUIDString]];
        
        // Start Monitoring Region
        [self.locationManager startMonitoringForRegion:region];
        [self.locationManager stopUpdatingLocation];
        
        // Update Table View
        [self.geofences addObject:region];
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:([self.geofences count] - 1) inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
        
        // Update View
        [self updateView];
    }
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    
    NSLog(@"entered region - %@", region.identifier);
    
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    localNotification.alertAction = @"Canvas Checkin";
    localNotification.alertBody = @"Checkin for class?";
    
    //localNotification.userInfo = Put Extra info here like Course info, professor, times and info to load the right assignment
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    
    [[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];
    
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    
    //NSLog(@"%s", __PRETTY_FUNCTION__);
}

#pragma mark -
#pragma mark View Methods
- (void)setupView {
    // Create Add Button
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCurrentLocation:)];
    
    // Create Edit Button
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Edit", nil) style:UIBarButtonItemStyleBordered target:self action:@selector(editTableView:)];
}

- (void)updateView {
    if (![self.geofences count]) {
        // Update Table View
        [self.tableView setEditing:NO animated:YES];
        
        // Update Edit Button
        [self.navigationItem.rightBarButtonItem setEnabled:NO];
        [self.navigationItem.rightBarButtonItem setTitle:NSLocalizedString(@"Edit", nil)];
        
    } else {
        // Update Edit Button
        [self.navigationItem.rightBarButtonItem setEnabled:YES];
    }
    
    // Update Add Button
    if ([self.geofences count] < 20) {
        [self.navigationItem.leftBarButtonItem setEnabled:YES];
    } else {
        [self.navigationItem.leftBarButtonItem setEnabled:NO];
    }
}

#pragma mark -
#pragma mark Actions
- (void)addCurrentLocation:(id)sender {
    // Update Helper
    _didStartMonitoringRegion = NO;
    
    // Start Updating Location
    [self.locationManager startUpdatingLocation];
}

- (void)editTableView:(id)sender {
    // Update Table View
    [self.tableView setEditing:![self.tableView isEditing] animated:YES];
    
    // Update Edit Button
    if ([self.tableView isEditing]) {
        [self.navigationItem.rightBarButtonItem setTitle:NSLocalizedString(@"Done", nil)];
    } else {
        [self.navigationItem.rightBarButtonItem setTitle:NSLocalizedString(@"Edit", nil)];
    }
}

@end
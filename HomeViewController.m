//
//  HomeViewController.m
//  JuspayEdu
//
//  Created by Saurabh TheRockStar on 28/06/17.
//  Copyright © 2017 saurabhrode@gmail.com. All rights reserved.
//

#import "HomeViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "AppDelegate.h"
#import "UserCredentials.h"
#import "Constants.h"
#import "AlertsWithVC.h"
#import "GFQuery.h"
#import "GFRegionQuery.h"
#import "GFCircleQuery.h"
#import "GFQuery+Private.h"
#import "GeoFire.h"
#import "GeoFire+Private.h"
#import "GFGeoHashQuery.h"

@import FirebaseDatabase;




@interface HomeViewController ()<CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    BOOL isFirstLoaded;
    NSMutableArray *usersDict ;
    GMSMapView *mapView;
    GeoFire *geoFire ;
    
}

@property (strong, nonatomic) FIRDatabaseReference *ref;



@end

@implementation HomeViewController

-(void)viewWillAppear:(BOOL)animated{

    [self setupNavigationBar];
}

-(void)viewDidAppear:(BOOL)animated{

    

}

- (void)loadViewGoogleMap:(CLLocation *)usersLocation {
   
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:usersLocation.coordinate.latitude
                                                            longitude:usersLocation.coordinate.longitude
                                                                 zoom:15];
    mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.myLocationEnabled = YES;
  
    self.view = mapView;
    
//     Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(usersLocation.coordinate.latitude, usersLocation.coordinate.longitude);
    marker.title = @"ME";
    marker.snippet = @"I AM HERE !";
    marker.map = mapView;
    marker.icon = [UIImage imageNamed:@"currentlocation"];
    [mapView setSelectedMarker:marker];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    usersDict =[[NSMutableArray alloc]init];
    isFirstLoaded = false;
    
 
    
//    [[[self.ref child:@"users"] queryOrderedByKey]observeEventType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot * _Nonnull snapshot)
//        
//     }];
    
    
    

   
    locationManager = [CLLocationManager new];
    
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
    }
    [locationManager startUpdatingLocation];
   
  
    
    // Do any additional setup after loading the view.
}

-(void)setupNavigationBar{

    self.navigationItem.hidesBackButton = YES;
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor]];
    self.navigationController.navigationBar.topItem.title = @"JuspAyEdu";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd  target:self action:@selector(sendWhatsAppMessages)];
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    currentLocation = [locations objectAtIndex:0];
    [locationManager stopUpdatingLocation];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (!(error))
         {
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
             NSString *Area = [[NSString alloc]initWithString:placemark.locality];
             NSString *Country = [[NSString alloc]initWithString:placemark.country];

         
             

             
             if (!isFirstLoaded) {
                 isFirstLoaded=true;
                 self.ref = [[FIRDatabase database] reference];
                 NSString * latitude1 = [NSString stringWithFormat:@"%f",currentLocation.coordinate.latitude];
                 NSString * longitude1 = [NSString stringWithFormat:@"%f",currentLocation.coordinate.longitude];
                 NSString * email1 =[[UserCredentials sharedMySingleton]getEmailId];
                 NSString * username1 =[[UserCredentials  sharedMySingleton]getUserName];
                 NSString * uid1 = [[UserCredentials sharedMySingleton]getuid];
                 NSString * domain1 =[[UserCredentials sharedMySingleton]getUserDomain];
                 NSString * linkedin1=[[UserCredentials sharedMySingleton]getlinkedin];
                 NSString * youtube1 =[[UserCredentials sharedMySingleton]getyoutube];
                 NSString * skills1 = [[UserCredentials sharedMySingleton]getskills];
                 NSString * mobile = [[UserCredentials sharedMySingleton]getmobilenumber];
                 
                 
                 
                 if ([domain1 isEqualToString:teacher]) {
                     NSDictionary * userDictionary =@{email:email1,longitude:longitude1,latitude:latitude1,
                                                      area:Area,linkedin:linkedin1,youtubelink:youtube1,
                                                      skills:skills1,mobilenumber:mobile,username:username1,domain:domain1,uid:uid1};
                     
                     [[[self.ref child:teachernode]child:uid1]setValue:userDictionary];
                     
                 }else if([domain1 isEqualToString:learner]){
                     NSDictionary * userDictionary =@{email:email1,longitude:longitude1,latitude:latitude1,
                                                      area:Area,linkedin:linkedin1,youtubelink:youtube1,
                                                      skills:skills1,mobilenumber:mobile,username:username1,domain:domain1,uid:uid1};
                     
                     [[[self.ref child:learnernode]child:uid1]setValue:userDictionary];
                 }
                 [self loadViewGoogleMap:currentLocation];
                 [self readData];
                 //child("users").child(uid).updateChildValues(["Places": values])
             }
          
         
             
             
            
           
         }
         else
         {
             [[AlertsWithVC sharedMySingleton]letsAlertUserWithMessage:@"Unable to load location" WithVC:self];
             
         }
         
     }];
}



-(void)readData{
    
  
    
//    [[[self.ref child:@"juspayedu"] child:@"users"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
//        // Get user value
//        //        User *user = [[User alloc] initWithUsername:snapshot.value[@"username"]];
//        NSDictionary *usersDict = snapshot.value;
//        
//        NSLog(@"HEHEHEHE%@",usersDict);
//        // ...
//    } withCancelBlock:^(NSError * _Nonnull error) {
//        NSLog(@"%@", error.localizedDescription);
//    }];
    
    
//    NSString * uid = [[UserCredentials sharedMySingleton]getuid];
    
    NSString * domain2 =[[UserCredentials sharedMySingleton]getUserDomain];
    NSString * node2;
    if ([domain2 isEqualToString:teacher]) {
         node2=teachernode;
    }else{
   
        node2=learnernode;
    }
    geoFire = [[GeoFire alloc] initWithFirebaseRef:[self.ref child:users]];
    [geoFire setLocation:currentLocation
                  forKey:[[UserCredentials sharedMySingleton]getuid]
     withCompletionBlock:^(NSError *error) {
         if (error != nil) {
             NSLog(@"An error occurred: %@", error);
         } else {
             NSLog(@"Saved location successfully!");
         }
     }];
    
    
  
    GFCircleQuery *circleQuery = [geoFire queryAtLocation:currentLocation withRadius:1.0];
    MKCoordinateSpan span = MKCoordinateSpanMake(0.001, 0.001);
    MKCoordinateRegion region = MKCoordinateRegionMake(currentLocation.coordinate, span);
//    GFRegionQuery *regionQuery = [geoFire queryWithRegion:region];
     NSMutableArray *usersNearby = [[NSMutableArray alloc]init];
    
    [circleQuery observeEventType:GFEventTypeKeyEntered withBlock:^(NSString *uid, CLLocation *location) {
        NSLog(@"Key '%@' entered the search area and is at location '%@'", uid, location);
        
        
  
        
        [usersNearby addObject:uid];
       
    }];
    
    [circleQuery observeReadyWithBlock:^{
        NSLog(@"All initial data has been loaded and events have been fired!");
        
        for (int i=0;i< usersNearby.count;i++) {
            NSString * domain1 =[[UserCredentials sharedMySingleton]getUserDomain];
            NSString * node;
            if ([domain1 isEqualToString:teacher]) {
                domain1=learner;
                node=learnernode;
            }else{
                domain1=teacher;
                node=teachernode;
            }
            
            [[[[self.ref child:node]queryOrderedByChild:uid]queryEqualToValue:usersNearby[i]] observeEventType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
                
                
                
                NSDictionary * dictionary=snapshot.value;
                NSString * lat = [dictionary valueForKey:latitude];
                NSString * log= [dictionary valueForKey:longitude];
                NSString * username1= [dictionary valueForKey:username];
                NSString * area1= [dictionary valueForKey:area];
                NSString * domain1 =[dictionary valueForKey:domain];
                NSString * mobile = [dictionary valueForKey:mobilenumber];
                NSString * linkedin1;
                NSString * youtube1;
                NSString * skills1;
                
                
                linkedin1=[dictionary valueForKey:linkedin];
                youtube1 =[dictionary valueForKey:youtubelink];
                skills1 = [dictionary valueForKey:skills];
                
                
                
                
                
                CLLocation * location1 =[[CLLocation alloc] initWithLatitude:[lat doubleValue] longitude:[log doubleValue]];
                
                
                
                
                
                NSString *latcutstring = [lat substringFromIndex:1];
                NSLog(@"cut lat: %@", latcutstring);
                NSString *loncutstring = [log substringFromIndex:1];
                NSLog(@"cut lon: %@", loncutstring);
                double latdouble = [latcutstring doubleValue];
                NSLog(@"latdouble: %f", latdouble);
                double londouble = [loncutstring doubleValue];
                NSLog(@"londouble: %f", londouble);
                
                
                
                CLLocation *locA = [[CLLocation alloc] initWithLatitude:currentLocation.coordinate.latitude longitude:currentLocation.coordinate.longitude];
                
                CLLocation *locB = [[CLLocation alloc] initWithLatitude:location1.coordinate.latitude longitude:location1.coordinate.longitude];
                
                CLLocationDistance distance = [locA distanceFromLocation:locB];
                
                if ([mobile isEqualToString:[[UserCredentials sharedMySingleton]getmobilenumber]]) {
                    
                    return ;
                }
                
                if (distance < 3000.00000) {
                    GMSMarker *marker = [[GMSMarker alloc] init];
                    marker.position = CLLocationCoordinate2DMake(location1.coordinate.latitude,location1.coordinate.longitude);
                    marker.title =area1;
                    marker.snippet =username1;
                    marker.map = mapView;
                    if ([domain1 isEqualToString:teacher]) {
                        marker.icon =[UIImage imageNamed:@"teacher"];
                    }else{
                        marker.icon =[UIImage imageNamed:@"learner"];
                    }
                    
                    //            [mapView setSelectedMarker:marker];
                }
                
                
            }];

        }
    }];
    
}

-(void)sendWhatsAppMessages{
    NSURL *whatsappURL = [NSURL URLWithString:@"whatsapp://send?text=Hello%2C%20World!"];
    if ([[UIApplication sharedApplication] canOpenURL: whatsappURL]) {
        [[UIApplication sharedApplication] openURL: whatsappURL];
    }
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

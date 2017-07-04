//
//  LocationManager.h
//  JuspayEdu
//
//  Created by Saurabh TheRockStar on 28/06/17.
//  Copyright © 2017 saurabhrode@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol LocationHandler <NSObject>

-(void)getLocation:(CLLocation *)usersLocation;

@end

@interface LocationManager : NSObject <CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    CLLocation *currentLocation;

}

@property (nonatomic,weak) id <LocationHandler> currentlocactionDelegate ;



-(void)CurrentLocationIdentifier:(id)locationdelegate;



@end

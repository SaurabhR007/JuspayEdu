//
//  AppDelegate.h
//  JuspayEdu
//
//  Created by Saurabh TheRockStar on 28/06/17.
//  Copyright © 2017 saurabhrode@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SocialCommunication/SocialCommunication.h>

@import FirebaseDatabase;



@interface AppDelegate : C2CallAppDelegate

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) FIRDatabaseReference *ref;
-(void)callTheNumber;


@end


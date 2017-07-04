//
//  AlertsWithVC.h
//  JuspayEdu
//
//  Created by Saurabh TheRockStar on 30/06/17.
//  Copyright © 2017 saurabhrode@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AlertsWithVC : NSObject

+(AlertsWithVC*)sharedMySingleton;
-(void)letsAlertUserWithMessage:(NSString *)message WithVC:(UIViewController * )vc;

@end

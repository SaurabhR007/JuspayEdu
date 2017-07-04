//
//  AlertsWithVC.m
//  JuspayEdu
//
//  Created by Saurabh TheRockStar on 30/06/17.
//  Copyright © 2017 saurabhrode@gmail.com. All rights reserved.
//

#import "AlertsWithVC.h"


@implementation AlertsWithVC

static AlertsWithVC* _sharedMySingleton = nil;

+(AlertsWithVC*)sharedMySingleton
{
    @synchronized([AlertsWithVC class])
    {
        if (!_sharedMySingleton)
            _sharedMySingleton = [[super alloc] init];
        
        return _sharedMySingleton;
    }
    
    return nil;
}


-(void)letsAlertUserWithMessage:(NSString *)message WithVC:(UIViewController * )vc{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Edujuspay APP"                                       message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }]];
    
    [vc presentViewController:alert animated:YES completion:nil];
}


- (id)init
{
    self = [super init];
    
    if (self) {
        
    }
    
    return self;
}


@end

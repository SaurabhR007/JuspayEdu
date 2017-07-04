//
//  FormValidations.h
//  JuspayEdu
//
//  Created by Saurabh TheRockStar on 04/07/17.
//  Copyright © 2017 saurabhrode@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FormValidations : NSObject

-(BOOL) NSStringIsValidEmail:(NSString *)checkString;

-(BOOL) NSStringIsValidMobileNumber:(NSString *)code;

@end

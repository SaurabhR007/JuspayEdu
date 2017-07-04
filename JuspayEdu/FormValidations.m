//
//  FormValidations.m
//  JuspayEdu
//
//  Created by Saurabh TheRockStar on 04/07/17.
//  Copyright © 2017 saurabhrode@gmail.com. All rights reserved.
//

#import "FormValidations.h"

@implementation FormValidations

-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

-(BOOL) NSStringIsValidMobileNumber:(NSString *)code{
    
    int ans=0;
    for (int i=0 ;i < code.length ; i++){
        
        
        int matchascii=([code characterAtIndex:i] - '0');
        
        if (matchascii < 47 || matchascii > 58)
        {
            return false;
        }
        
        ans= ans * 10 + matchascii ;
    }
    
    return true;
}




@end

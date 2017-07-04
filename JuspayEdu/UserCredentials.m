//
//  UserCredentials.m
//  JuspayEdu
//
//  Created by Saurabh TheRockStar on 30/06/17.
//  Copyright © 2017 saurabhrode@gmail.com. All rights reserved.
//

#import "UserCredentials.h"
#import "Constants.h"

@implementation UserCredentials

static UserCredentials* _sharedMySingleton = nil;

+(UserCredentials*)sharedMySingleton
{
    @synchronized([UserCredentials class])
    {
        if (!_sharedMySingleton)
             _sharedMySingleton = [[super alloc] init];
        
        return _sharedMySingleton;
    }
    
    return nil;
}


- (id)init
{
    self = [super init];
    
    if (self) {
    
    }
    
    return self;
}


-( NSString *)getEmailId{
    
    NSString * email1 =[[NSUserDefaults standardUserDefaults] objectForKey:email];
    
    return email1;
}
-(NSString *)getUserName{
    NSString * email =[[NSUserDefaults standardUserDefaults] objectForKey:username];
    
    return email;
}
-(NSString *)getmobilenumber{
    NSString * email =[[NSUserDefaults standardUserDefaults] objectForKey:mobilenumber];
    
    return email;
}
-(NSString *)getskills{
    NSString * email =[[NSUserDefaults standardUserDefaults] objectForKey:skills];
    
    return email;
}
-(NSString *)getlinkedin{
    NSString * email =[[NSUserDefaults standardUserDefaults] objectForKey:linkedin];
    
    return email;
}
-(NSString *)getyoutube{
    NSString * email =[[NSUserDefaults standardUserDefaults] objectForKey:youtubelink];
    
    return email;
}

-(NSString *)getuid{
    NSString * email =[[NSUserDefaults standardUserDefaults] objectForKey:uid];
    
    return email;
}

-(NSString *)getpassword{
    NSString * email =[[NSUserDefaults standardUserDefaults] objectForKey:password];
    
    return email;
}

-(NSString *)getUserDomain{
    
    NSString * email =[[NSUserDefaults standardUserDefaults] objectForKey:domain];
    
    return email;
    
}



-(void)setEmailId:(NSString *)emailId{
    
    [[NSUserDefaults standardUserDefaults] setObject:emailId forKey:email];
    
}
-(void)setUserName:(NSString *)username1{
  
    [[NSUserDefaults standardUserDefaults] setObject:username1 forKey:username];
}
-(void)setmobilenumber:(NSString *)mobilenumber1{
   
    [[NSUserDefaults standardUserDefaults] setObject:mobilenumber1 forKey:mobilenumber];

}
-(void)setskills:(NSString *)skills1{

    [[NSUserDefaults standardUserDefaults] setObject:skills1 forKey:skills];
}
-(void)setlinkedin:(NSString *)linkedin1{

    [[NSUserDefaults standardUserDefaults] setObject:linkedin1 forKey:linkedin];
}
-(void)setyoutube:(NSString *)youtube1{
  
    [[NSUserDefaults standardUserDefaults] setObject:youtube1 forKey:youtubelink];
 
}

-(void)setuid:(NSString *)uid1{
  
    [[NSUserDefaults standardUserDefaults] setObject:uid1 forKey:uid];
}

-(void)setpassword:(NSString *)passowrd1{
  
     [[NSUserDefaults standardUserDefaults] setObject:passowrd1 forKey:password];
}

-(void)setUserDomain:(NSString *)domain1{
    [[NSUserDefaults standardUserDefaults] setObject:domain1 forKey:domain];
}






@end

//
//  UserCredentials.h
//  JuspayEdu
//
//  Created by Saurabh TheRockStar on 30/06/17.
//  Copyright © 2017 saurabhrode@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserCredentials : NSObject

+(UserCredentials*)sharedMySingleton;

-(NSString *)getEmailId;
-(NSString *)getUserName;
-(NSString *)getmobilenumber;
-(NSString *)getskills;
-(NSString *)getlinkedin;
-(NSString *)getyoutube;
-(NSString *)getpassword;
-(NSString *)getuid;
-(NSString *)getUserDomain;



-(void)setEmailId:(NSString *)emailId;
-(void)setUserName:(NSString *)username;
-(void)setmobilenumber:(NSString *)mobilenumber;
-(void)setskills:(NSString *)skills;
-(void)setlinkedin:(NSString *)linkedin;
-(void)setyoutube:(NSString *)youtube;
-(void)setuid:(NSString *)uid;
-(void)setpassword:(NSString *)passowrd;
-(void)setUserDomain:(NSString *)domain;



@end

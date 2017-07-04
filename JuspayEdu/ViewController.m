//
//  ViewController.m
//  JuspayEdu
//
//  Created by Saurabh TheRockStar on 28/06/17.
//  Copyright © 2017 saurabhrode@gmail.com. All rights reserved.
//

#import "ViewController.h"
#import "HomeViewController.h"
#import "UserCredentials.h"
#import "AlertsWithVC.h"
#import "Constants.h"
#import "FormValidations.h"
@import Firebase;
@import FirebaseAuth;


@interface ViewController ()
{
    UIInterfaceOrientation currentOrientation;
}

@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];


}


- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [UIView animateWithDuration:2 animations:^{
      self.signUpLabelHeight.constant =  0;
    }];
   
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    
    [UIView animateWithDuration:2 animations:^{
            self.signUpLabelHeight.constant =  150;
        }];

 
   
    return YES;
}


-(IBAction)signUpButtonClicked:(id)sender{
    
    
    FormValidations * validate =[[FormValidations alloc]init];
   bool isValidMobile=[validate NSStringIsValidMobileNumber:self.mobilenumberTF.text];
    
    if (!isValidMobile) {
        [[AlertsWithVC sharedMySingleton]letsAlertUserWithMessage:@"Looks Problem with Mobile Number" WithVC:self];
    }
   
    NSInteger selectedSegment = _segmentedControl.selectedSegmentIndex;
    
    
    
    if (selectedSegment == 0) {
        if ([self.emailIdTF.text  isEqualToString: @""]  || [self.mobilenumberTF.text  isEqualToString: @""] || [self.usernameTF.text  isEqualToString: @""] || [self.passwordTF.text  isEqualToString: @""] || [self.skillsTF.text  isEqualToString: @""] ) {
            [[AlertsWithVC sharedMySingleton]letsAlertUserWithMessage:@"Required field looks empty !" WithVC:self];
           
         
        }else{
            
            [self signUpCheck];
             [[UserCredentials sharedMySingleton]setUserDomain:teacher];
        }
    }
    else{
        if ([self.emailIdTF.text  isEqualToString: @""]  || [self.mobilenumberTF.text  isEqualToString: @""] || [self.usernameTF.text  isEqualToString: @""] || [self.passwordTF.text  isEqualToString: @""]) {
            
            [[AlertsWithVC sharedMySingleton]letsAlertUserWithMessage:@"Required field looks empty !" WithVC:self];
        }else{
            
            [self signUpCheck];
             [[UserCredentials sharedMySingleton]setUserDomain:learner];
        }
    }


    
  
}







- (IBAction)segmentSwitch{
   
    NSInteger selectedSegment = _segmentedControl.selectedSegmentIndex;
    
    if (selectedSegment == 0) {
        [self.teacherFieldsView setHidden:false];
    }
    else{
        [self.teacherFieldsView setHidden:true];
    }
}


-(void)signUpCheck{
    [[FIRAuth auth] createUserWithEmail:self.emailIdTF.text password:self.passwordTF.text completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
        
        if (error) {
            
           [[AlertsWithVC sharedMySingleton]letsAlertUserWithMessage:error.localizedDescription WithVC:self];
            NSLog(@"Error in FIRAuth := %@",error.localizedDescription);
            
        }
        
        else{
            
             NSLog(@"user Id : %@", user.uid);
             [[UserCredentials sharedMySingleton]setuid:user.uid];
             [[UserCredentials  sharedMySingleton]setUserName:self.usernameTF.text];
            if ([self.linkedinTF.text isEqualToString:@""]) {
                self.linkedinTF.text=@"NA";
            }
            if([self.youtubeTF.text isEqualToString:@""]){
                self.youtubeTF.text=@"NA";
            }
            if ([self.skillsTF.text isEqualToString:@""]) {
                self.skillsTF.text =@"NA";
            }
             [[UserCredentials sharedMySingleton]setlinkedin:self.linkedinTF.text];
             [[UserCredentials sharedMySingleton]setyoutube:self.youtubeTF.text];
             [[UserCredentials sharedMySingleton]setskills:self.skillsTF.text];
             [[UserCredentials sharedMySingleton]setmobilenumber:self.mobilenumberTF.text];
             [[UserCredentials sharedMySingleton]setEmailId:self.emailIdTF.text];
             [[UserCredentials sharedMySingleton]setpassword:self.passwordTF.text];
             [self pushVC];
            
        }
        
    }];
}

-(void)pushVC{
    NSString * storyboardName = @"Main";
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    HomeViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
    
    
    [[self navigationController] pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

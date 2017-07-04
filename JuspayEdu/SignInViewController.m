//
//  SignUpViewController.m
//  JuspayEdu
//
//  Created by Saurabh TheRockStar on 30/06/17.
//  Copyright © 2017 saurabhrode@gmail.com. All rights reserved.
//

#import "SignInViewController.h"
#import "UserCredentials.h"
#import "HomeViewController.h"
#import "AlertsWithVC.h"
#import "AppDelegate.h"
@import Firebase;
@import FirebaseAuth;

@interface SignInViewController ()

@end

@implementation SignInViewController


-(void)viewWillAppear:(BOOL)animated{
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
}

- (IBAction)cancelButtonClicked:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}


- (IBAction)signInButtonClicked:(id)sender {
    
    if ([self.emailid.text  isEqualToString: @""]  || [self.password.text  isEqualToString: @""]) {
      
        [[AlertsWithVC sharedMySingleton]letsAlertUserWithMessage:@"Required field looks empty !" WithVC:self];
    }else{
        
      [self singnInCheck];
    }
}

-(void)singnInCheck{
    
      [[FIRAuth auth]signInWithEmail:self.emailid.text password:self.password.text completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
        if (error) {
            
         
             [[AlertsWithVC sharedMySingleton]letsAlertUserWithMessage:error.localizedDescription WithVC:self];
             NSLog(@"Error in FIRAuth := %@",error.localizedDescription);

            
        }
        else{
            NSLog(@"user Id : %@", user.uid);
            if (![self.emailid.text  isEqualToString: @""]  && ![self.password.text  isEqualToString: @""]) {
                [[UserCredentials sharedMySingleton]setEmailId:self.emailid.text];
                [[UserCredentials sharedMySingleton]setpassword:self.password.text];
             
                
            }
            [[UserCredentials sharedMySingleton]setuid:user.uid];
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

- (IBAction)CallButtonClicked:(id)sender{
    AppDelegate * appdel = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [appdel callTheNumber];
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

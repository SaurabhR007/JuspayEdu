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
#import "Constants.h"
@import Firebase;
@import FirebaseAuth;
@import FirebaseDatabase;

@interface SignInViewController ()

@property (strong, nonatomic) FIRDatabaseReference *ref;

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
            if (![self.password.text  isEqualToString: @""]) {
            
                [[UserCredentials sharedMySingleton]setpassword:self.password.text];
                [self readdata:user.uid];
             
            }
            [[UserCredentials sharedMySingleton]setuid:user.uid];
           
        }
    }];
}


-(void)readdata:(NSString *)checkuid{
    
    self.ref = [[FIRDatabase database] reference];
    [[[[self.ref child:teachernode]queryOrderedByChild:uid]queryEqualToValue:checkuid] observeEventType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
    
            
        
        if (snapshot.exists) {
            
            
            NSDictionary * dictionary=snapshot.value;
            
            [self setuserdata:dictionary];
    }else{
        [[AlertsWithVC sharedMySingleton]letsAlertUserWithMessage:@"Account Data Not Available . Please signup again!" WithVC:self];
    }
     
    
        
        
        
    }];
    
    
    
    [[[[self.ref child:learnernode]queryOrderedByChild:uid]queryEqualToValue:checkuid] observeEventType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        
        if (snapshot.exists) {
            
            NSDictionary * dictionary=snapshot.value;
            
            [self setuserdata:dictionary];
            
        
        }else{
            [[AlertsWithVC sharedMySingleton]letsAlertUserWithMessage:@"Account Data Not Available . Please signup again!" WithVC:self];
        }
        
    }];
    

}



-(void)setuserdata:(NSDictionary *)dictionary{

    
    NSString * username1= [dictionary valueForKey:username];
    NSString * domain1 =[dictionary valueForKey:domain];
    NSString * mobile = [dictionary valueForKey:mobilenumber];
    NSString * email1 =[dictionary valueForKey:email];
    NSString * linkedin1;
    NSString * youtube1;
    NSString * skills1;
    linkedin1=[dictionary valueForKey:linkedin];
    youtube1 =[dictionary valueForKey:youtubelink];
    skills1 = [dictionary valueForKey:skills];
    NSString * uid1 =[dictionary valueForKey:uid];
    
    [[UserCredentials sharedMySingleton]setlinkedin:linkedin1];
    [[UserCredentials sharedMySingleton]setyoutube:youtube1];
    [[UserCredentials sharedMySingleton]setskills:skills1];
    [[UserCredentials sharedMySingleton]setmobilenumber:mobile];
    [[UserCredentials sharedMySingleton]setEmailId:email1];
    [[UserCredentials sharedMySingleton]setuid:uid1];
    [[UserCredentials sharedMySingleton]setUserName:username1];
    [[UserCredentials sharedMySingleton]setUserDomain:domain1];
    [self pushVC];
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

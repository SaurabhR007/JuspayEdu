//
//  SignUpViewController.h
//  JuspayEdu
//
//  Created by Saurabh TheRockStar on 30/06/17.
//  Copyright © 2017 saurabhrode@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignInViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *emailid;
@property (weak, nonatomic) IBOutlet UITextField *password;

- (IBAction)signInButtonClicked:(id)sender;
- (IBAction)cancelButtonClicked:(id)sender;

- (IBAction)CallButtonClicked:(id)sender;
@end

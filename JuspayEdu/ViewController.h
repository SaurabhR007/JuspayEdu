//
//  ViewController.h
//  JuspayEdu
//
//  Created by Saurabh TheRockStar on 28/06/17.
//  Copyright © 2017 saurabhrode@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *emailIdTF;
@property (weak, nonatomic) IBOutlet UITextField *usernameTF;
@property (weak, nonatomic) IBOutlet UITextField *mobilenumberTF;
@property (weak, nonatomic) IBOutlet UITextField *skillsTF;
@property (weak, nonatomic) IBOutlet UITextField *linkedinTF;
@property (weak, nonatomic) IBOutlet UITextField *youtubeTF;
@property (weak, nonatomic) IBOutlet UIView * teacherFieldsView;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;


@property(nonatomic , weak) IBOutlet NSLayoutConstraint * signUpLabelHeight;

@end


//
//  ViewController.h
//  FaceBookAPI
//
//  Created by Aditya Narayan on 6/21/16.
//  Copyright © 2016 TurnToTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

@interface ViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, FBSDKSharingDelegate>

@property (retain, nonatomic) IBOutlet FBSDKLoginButton * loginButton;
@property (weak, nonatomic) IBOutlet UIImageView * imagePicked;

- (IBAction)openCamera:(id)sender;
- (IBAction)openPhotoLibrary:(id)sender;
- (IBAction)saveImage:(id)sender;

@end


//
//  ViewController.m
//  FaceBookAPI
//
//  Created by Aditya Narayan on 6/21/16.
//  Copyright © 2016 TurnToTech. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.loginButton = [[FBSDKLoginButton alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)openCamera:(id)sender {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
        picker.allowsEditing = false;
        [self presentViewController:picker animated:true completion:nil];
    }
}

- (IBAction)openPhotoLibrary:(id)sender {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        picker.allowsEditing = true;
        [self presentViewController:picker animated:true completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    self.imagePicked.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    FBSDKSharePhoto * photo = [[FBSDKSharePhoto alloc] init];
    photo.image = self.imagePicked.image;
    photo.userGenerated = YES;
    FBSDKSharePhotoContent * content = [[FBSDKSharePhotoContent alloc] init];
    content.photos = @[photo];
    [FBSDKShareDialog showFromViewController:self.navigationController.viewControllers[0] withContent:content delegate:self];
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results {
    NSLog(@"Photo shared");
}

- (void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error {
    NSLog(@"Sharing failed");
}

- (void)sharerDidCancel:(id<FBSDKSharing>)sharer {
    NSLog(@"Sharing canceled");
}

- (IBAction)saveImage:(id)sender {

    NSData *imageData = UIImageJPEGRepresentation(_imagePicked.image, 0.6);
    UIImage *compressedJPGImage = [UIImage imageWithData:imageData];
    UIImageWriteToSavedPhotosAlbum(compressedJPGImage, nil, nil, nil);
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"Wow" message:@"Your image has been saved to the Photo Library!" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    
    [alertController addAction:ok];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end

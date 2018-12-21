//
//  THImagePicker.m
//  TaphouseKit
//
//  Created by Jared Sorge on 8/6/14.
//  Copyright (c) 2014 Taphouse Software LLC. All rights reserved.
//

#import "THImagePicker.h"

@import UIKit;
@import MobileCoreServices;

@interface THImagePicker () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, weak) id<THImagePickerDelegate> delegate;
@property (nonatomic, strong) UIImagePickerController *imagePicker;
@property (nonatomic) BOOL hasCamera;
@property (nonatomic, weak) UIViewController *viewControllerPresentingPicker;
@property (nonatomic) BOOL saveToCameraRoll;
@property (nonatomic) BOOL editFromCamera;
@end

@implementation THImagePicker

#pragma mark - Properties
- (BOOL)hasCamera
{
    if (!_hasCamera) {
        _hasCamera = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    }
    return _hasCamera;
}

- (UIImagePickerController *)imagePicker
{
    if (!_imagePicker) {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.delegate = self;
    }
    return _imagePicker;
}

#pragma mark - API
- (instancetype)initWithDelegate:(id<THImagePickerDelegate>)delegate
                    saveToCamera:(BOOL)saveToCamera
                  editFromCamera:(BOOL)cameraEdit
{
    self = [super init];
    if (self) {
        self.delegate = delegate;
        self.saveToCameraRoll = saveToCamera;
        self.editFromCamera = cameraEdit;
    }
    return self;
}

- (BOOL)deviceHasCamera;
{
    return self.hasCamera;
}

- (void)showCameraInViewController:(UIViewController *)viewController
{
    [self showImagePickerViewWithType:UIImagePickerControllerSourceTypeCamera
                     inViewController:viewController];
}

- (void)showImagePickerInViewController:(UIViewController *)viewController
{
    [self showImagePickerViewWithType:UIImagePickerControllerSourceTypePhotoLibrary
                     inViewController:viewController];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if ([self.delegate respondsToSelector:@selector(imagePickerDelegate:didSelectImageAtURL:)]) {
        NSURL *imageURL;
        if (info[UIImagePickerControllerEditedImage] != nil) {
            NSURL *tempURL = [[NSFileManager defaultManager] temporaryDirectory];
            tempURL = [tempURL URLByAppendingPathComponent:@"image.jpg"];
            NSData *imageData = UIImageJPEGRepresentation(info[UIImagePickerControllerEditedImage], 1.0);
            [imageData writeToURL:tempURL atomically:YES];
            imageURL = tempURL;
        }
        else {
            imageURL = info[UIImagePickerControllerImageURL];
        }

        [self.delegate imagePickerDelegate:self didSelectImageAtURL:imageURL];
    }
    else if ([self.delegate respondsToSelector:@selector(imagePickerDelegate:didSelectImage:)]) {
        UIImage *pickedImage = info[UIImagePickerControllerEditedImage];
        if (!pickedImage) {
            pickedImage = info[UIImagePickerControllerOriginalImage];
        }

        if (self.saveToCameraRoll && picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            UIImageWriteToSavedPhotosAlbum(pickedImage, nil, nil, nil);
        }

        [self.delegate imagePickerDelegate:self didSelectImage:pickedImage];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.delegate imagePickerDelegateDidCancel:self];
}

#pragma mark - Private
- (void)showImagePickerViewWithType:(UIImagePickerControllerSourceType)sourceType
                   inViewController:(UIViewController *)viewController
{
    if (self.editFromCamera) {
        self.imagePicker.allowsEditing = YES;
    } else {
        self.imagePicker.allowsEditing = NO;
    }
    
    self.imagePicker.sourceType = sourceType;
    self.viewControllerPresentingPicker = viewController;
    [viewController presentViewController:self.imagePicker animated:YES completion:nil];
}

@end

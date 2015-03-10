//
//  THImagePicker.h
//  TaphouseKit
//
//  Created by Jared Sorge on 8/6/14.
//  Copyright (c) 2014 Taphouse Software LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIImage;
@class UIViewController;

@protocol THImagePickerDelegate;

@interface THImagePicker : NSObject
/**
 *  Create an instance of this class to use in place of implementing the UIImagePickerController and all of its things
 *
 *  @param delegate     Object that receives the delegate callbacks
 *  @param saveToCamera YES if you want to save picked images from the camera to the camera roll
 *  @param cameraEdit   YES if you want to enable editing on picked images
 *
 *  @return Usable instance of the image picker
 */
- (instancetype)initWithDelegate:(id<THImagePickerDelegate>) delegate saveToCamera:(BOOL)saveToCamera editFromCamera:(BOOL)cameraEdit;

/**
 *  Checks if the device running the code has a camera
 *
 *  @return YES if there is a camera, NO if there isn't
 */
- (BOOL)deviceHasCamera;

/**
 *  Displays the camera for taking a picture. Calls the delegate when finished
 *
 *  @param viewController The view controller that is presenting the camera
 */
- (void)showCameraInViewController:(UIViewController *)viewController;

/**
 *  Opens the image picker for taking an image out of the photo library. Calls the delegate when finished
 *
 *  @param viewController The view controller that is presenting the picker
 */
- (void)showImagePickerInViewController:(UIViewController *)viewController;
@end

@protocol THImagePickerDelegate <NSObject>
/**
 *  Called when the image picker picked or took an image successfully
 *
 *  @param picker The instance of this class
 *  @param image  The image picked
 */
- (void)imagePickerDelegate:(THImagePicker *)picker didSelectImage:(UIImage *)image;

/**
 *  Called when the image picker was cancelled by the user
 *
 *  @param picker The instance of this class
 */
- (void)imagePickerDelegateDidCancel:(THImagePicker *)picker;
@end
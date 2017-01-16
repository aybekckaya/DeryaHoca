//
//  KullaniciEkleVC.h
//  DeryaHoca
//
//  Created by aybek can kaya on 15/11/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import "BaseVC.h"
#import "NSString+formInput.h"
#import "User.h"


typedef enum KullaniciEklePageType
{
    kKullaniciEklePageTypeDefault,
     kKullaniciEklePageTypeEdit
    
}KullaniciEklePageType;

@interface KullaniciEkleVC : BaseVC<UIAlertViewDelegate , UIImagePickerControllerDelegate>
{
    UIImage *selectedProfileImage;
    
    
}

@property(nonatomic , strong) id viewController;
@property(nonatomic) KullaniciEklePageType typePage;
@property(nonatomic) int userID;


- (IBAction)kaydetOnTap:(id)sender;
- (IBAction)iptalOnTap:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollForm;
@property (weak, nonatomic) IBOutlet UITextField *tfName;
@property (weak, nonatomic) IBOutlet UIImageView *imViewProfile;



@end

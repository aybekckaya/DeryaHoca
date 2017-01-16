//
//  KullaniciEkleVC.m
//  DeryaHoca
//
//  Created by aybek can kaya on 15/11/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import "KullaniciEkleVC.h"
#import "KullanicilarVC.h"

@interface KullaniciEkleVC ()

@end

@implementation KullaniciEkleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.imViewProfile.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *recTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imViewDidTapped)];
    recTap.numberOfTouchesRequired  = 1;
    recTap.numberOfTapsRequired = 1;
    [self.imViewProfile addGestureRecognizer:recTap];
    
    
    if(self.typePage == kKullaniciEklePageTypeEdit)
    {
        [self initSelectedUser];
    }
        
}


-(void)initSelectedUser
{
    User *theUser = [[User alloc] initWithID:self.userID];
    
    UIImage *profileImage = [theUser getProfileImage];
    self.imViewProfile.image = profileImage;
    self.tfName.text = theUser.name;
    
    
}


#pragma mark Tap Gesture 

-(void)imViewDidTapped
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Derya Hoca" message:@"" delegate:self cancelButtonTitle:@"İptal" otherButtonTitles:@"Albümden seç",@"Resim Çek", nil];
    alert.tag = 1000;
    
    [alert show];
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 1000)
    {
        if(buttonIndex == 1)
        {
            [self selectPhoto];
        }
        else if(buttonIndex == 2)
        {
            [self takePhoto];
        }
    }
}





-(void)takePhoto
{
   UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

-(void)selectPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    selectedProfileImage = info[@"UIImagePickerControllerOriginalImage"];
    
    self.imViewProfile.image = selectedProfileImage;
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
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

- (IBAction)kaydetOnTap:(id)sender {
    
    NSString *strUserName = [self.tfName.text trimWhitespacesInString];
    
    if(strUserName.length == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hata" message:@"Lütfen öğrencinin adını ve soyadını giriniz." delegate:self cancelButtonTitle:@"Tamam" otherButtonTitles: nil];
        [alert show];
        
        return;
    }
    
    NSString *name = self.tfName.text ;
    
    User *theUser = [[User alloc] init];
    theUser.ID = [theUser newIDForTable];
    
    if(self.typePage == kKullaniciEklePageTypeEdit)
    {
        theUser = [[User alloc] initWithID:self.userID];
    }
    
    
    theUser.name = name;
    if(selectedProfileImage != nil)
    {
         [theUser saveProfileImage:selectedProfileImage];
    }
   
    [theUser saveModel];
    
    
   // [(KullanicilarVC *)self.viewController updateTableView];
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
        
        
        
    }];
}

- (IBAction)iptalOnTap:(id)sender {
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}
@end

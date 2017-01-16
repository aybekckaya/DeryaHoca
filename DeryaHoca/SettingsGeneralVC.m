//
//  SettingsGeneralVC.m
//  DeryaHoca
//
//  Created by aybek can kaya on 20/11/15.
//  Copyright © 2015 aybek can kaya. All rights reserved.
//

#import "SettingsGeneralVC.h"

@interface SettingsGeneralVC ()

@end

@implementation SettingsGeneralVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    User *currentUser = [User currentUser];
    settingsCurrent = [[Settings alloc] initWithUserID:currentUser.ID];
    
    [self guiUpdate];
    
    [self initSettings];
}

-(void)guiUpdate
{
    
    User *currentUser = [User currentUser ];
    
    navbarTeacher = [Story GetViewFromNibByName:@"TeacherNavBar"];
    navbarTeacher.delegateNavbar = self;
    navbarTeacher.lblStudentName.text = currentUser.name;
    [self.view addSubview:navbarTeacher];
    
    
    navbarTeacher.typeScreen = kTeacherNavBarScreenTypeSettings;
    
    
    
    // seslendirme
    self.viewSeslendirmeKadin.layer.cornerRadius = self.viewSeslendirmeKadin.frame.size.height/2;
    self.viewSeslendirmeKadin.layer.masksToBounds = YES;
    
    self.viewSeslendirmeErkek.layer.cornerRadius = self.viewSeslendirmeKadin.frame.size.height/2;
    self.viewSeslendirmeErkek.layer.masksToBounds = YES;
    
    
    [self.view bringSubviewToFront:self.btnKaydet];
   
    
}



-(void)initSettings
{
    [self.switchCumleSeridi setOn:NO];
    [self.switchSilmeTusu setOn:NO];
    
    [self selectSeslendirmeWithType:kSesTuruMale];
    
   // User *currUser = [User currentUser];
   // Settings *currentSettings = [[Settings alloc] initWithUserID:currUser.ID];
    
   // //NSLog(@"settings : %@" , [currentSettings getDictionary]);
    
    
    [self.switchCumleSeridi setOn:settingsCurrent.cumleSeridiEnabled];
    [self.switchSilmeTusu setOn:settingsCurrent.cumleSeridiSilmeTusuEnabled];
    [self selectSeslendirmeWithType:settingsCurrent.typeSesTuru];
    
}


#pragma mark NavigationBar delegate 

-(void)teacherNavBarHomepageOnTap:(TeacherNavBar *)navbar
{
    [self.navigationController popViewControllerAnimated:YES];
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


-(void)selectSeslendirmeWithType:(SettingsSesTuru) typeVoice
{
    
    self.viewSeslendirmeErkek.backgroundColor = [UIColor clearColor];
    self.viewSeslendirmeKadin.backgroundColor = [UIColor clearColor];
    
    self.viewSeslendirmeErkek.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.viewSeslendirmeErkek.layer.borderWidth = 2;
    
    self.viewSeslendirmeKadin.layer.borderWidth = 2;
    self.viewSeslendirmeKadin.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    if(typeVoice == kSesTuruFemale)
    {
         self.viewSeslendirmeKadin.backgroundColor = [UIColor colorWithR:54 G:215 B:183 A:1.0];
        
       
    }
    else if(typeVoice == kSesTuruMale)
    {
         self.viewSeslendirmeErkek.backgroundColor = [UIColor colorWithR:54 G:215 B:183 A:1.0];
    }
}


- (IBAction)seslendirmeOnTap:(id)sender {
    
    //User *currentUser = [User currentUser];
    //Settings *settingsCurrent = [[Settings alloc] initWithUserID:currentUser.ID];
    
    if([sender tag] == 11)
    {
        settingsCurrent.typeSesTuru = kSesTuruMale;
    }
    else if([sender tag] == 12)
    {
        settingsCurrent.typeSesTuru = kSesTuruFemale;
    }
    
    [self selectSeslendirmeWithType:settingsCurrent.typeSesTuru];
    
}

- (IBAction)switchValueChangeCumleSeridi:(id)sender {
    //User *currentUser = [User currentUser];
    //Settings *settingsCurrent = [[Settings alloc] initWithUserID:currentUser.ID];
    
    settingsCurrent.cumleSeridiEnabled = self.switchCumleSeridi.isOn;
    settingsCurrent.cumleSeridiSilmeTusuEnabled = self.switchSilmeTusu.isOn;
    
}

- (IBAction)switchValueChangeCumleSeridiSilme:(id)sender {
   // User *currentUser = [User currentUser];
    //Settings *settingsCurrent = [[Settings alloc] initWithUserID:currentUser.ID];
    
    settingsCurrent.cumleSeridiEnabled = self.switchCumleSeridi.isOn;
    settingsCurrent.cumleSeridiSilmeTusuEnabled = self.switchSilmeTusu.isOn;
}

- (IBAction)kaydetOnTap:(id)sender {
   
   // User *currentUser = [User currentUser];
   // Settings *settingsCurrent = [[Settings alloc] initWithUserID:currentUser.ID];

    [settingsCurrent save];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Derya Hoca" message:@"Ayarlarınız kaydedilmiştir." delegate:self cancelButtonTitle:@"Tamam" otherButtonTitles: nil];
    alert.tag = 1000;
    [alert show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 1000)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}




@end

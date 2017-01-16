//
//  SettingsGeneralVC.h
//  DeryaHoca
//
//  Created by aybek can kaya on 20/11/15.
//  Copyright © 2015 aybek can kaya. All rights reserved.
//

#import "BaseVC.h"
#import "TeacherNavBar.h"
#import "Story.h"
#import "User.h"

#import "UIColor+Convert.h"

#import "Settings.h"



@interface SettingsGeneralVC : BaseVC<TeacherNavBarDelegate , UIAlertViewDelegate>
{
    Settings *settingsCurrent;
    
    // Teacher Type
    TeacherNavBar *navbarTeacher;
    
    
    
}

@property (weak, nonatomic) IBOutlet UISwitch *switchCumleSeridi;
@property (weak, nonatomic) IBOutlet UISwitch *switchSilmeTusu;

@property (weak, nonatomic) IBOutlet UIView *viewSeslendirmeErkek;
@property (weak, nonatomic) IBOutlet UIView *viewSeslendirmeKadin;
@property (weak, nonatomic) IBOutlet UIButton *btnKaydet;

- (IBAction)seslendirmeOnTap:(id)sender;


- (IBAction)switchValueChangeCumleSeridi:(id)sender;
- (IBAction)switchValueChangeCumleSeridiSilme:(id)sender;

- (IBAction)kaydetOnTap:(id)sender;

@end

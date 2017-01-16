//
//  TeacherNavBar.h
//  DeryaHoca
//
//  Created by aybek can kaya on 18/11/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TeacherNavBar;
@protocol TeacherNavBarDelegate <NSObject>

-(void)teacherNavBarResimEkleOnTap:(TeacherNavBar *)navbar;

-(void)teacherNavBarKategoriEkleOnTap:(TeacherNavBar *)navbar;

-(void)teacherNavBarAyarlarOnTap:(TeacherNavBar *)navbar;

-(void)teacherNavBarHomepageOnTap:(TeacherNavBar *)navbar;

-(void)teacherNavbarKategoriSettingsOnTap:(TeacherNavBar *)navbar;

-(void)teacherNavbarCancelOnTap:(TeacherNavBar *)navbar;

-(void)teacherNavBarArsivdenSecOnTap:(TeacherNavBar *)navbar;


@end


typedef enum TeacherNavBarScreenType
{
    kTeacherNavBarScreenTypeNormal,
    kTeacherNavBarScreenTypeSettings
    
}TeacherNavBarScreenType;



@interface TeacherNavBar : UIView
{
    
}

@property(nonatomic , weak) id<TeacherNavBarDelegate> delegateNavbar;

@property(nonatomic , assign) TeacherNavBarScreenType typeScreen;


@property (weak, nonatomic) IBOutlet UIImageView *imViewAyarlar;

@property (weak, nonatomic) IBOutlet UIButton *btnHomePage;
@property (weak, nonatomic) IBOutlet UIImageView *imViewAnasayfa;
@property (weak, nonatomic) IBOutlet UILabel *lblBack;
@property (weak, nonatomic) IBOutlet UIButton *btnAyarlar;

@property (weak, nonatomic) IBOutlet UILabel *lblStudentName;




@property (weak, nonatomic) IBOutlet UILabel *lblKategoriEkle;
@property (weak, nonatomic) IBOutlet UIButton *btnKategoriEkle;
@property (weak, nonatomic) IBOutlet UILabel *lblResimEkle;
@property (weak, nonatomic) IBOutlet UIButton *btnResimEkle;
@property (weak, nonatomic) IBOutlet UILabel *lblArsivdenSec;
@property (weak, nonatomic) IBOutlet UIButton *btnArsivdenSec;


- (IBAction)btnKategoriEkleOnTap:(id)sender;

- (IBAction)btnResimEkleOnTap:(id)sender;

- (IBAction)btnArsivdenSecOnTap:(id)sender;



- (IBAction)kategoriSettingsOnTap:(id)sender;

//- (IBAction)btnResimEkleOnTap:(id)sender;
//- (IBAction)btnKategoriEkleOnTap:(id)sender;

- (IBAction)btnAyarlarDidTap:(id)sender;
- (IBAction)btnHomepageDidTap:(id)sender;
//- (IBAction)cancelOnTap:(id)sender;

@end

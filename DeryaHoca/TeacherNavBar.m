//
//  TeacherNavBar.m
//  DeryaHoca
//
//  Created by aybek can kaya on 18/11/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import "TeacherNavBar.h"

@implementation TeacherNavBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)setTypeScreen:(TeacherNavBarScreenType)typeScreen
{
    if(typeScreen == kTeacherNavBarScreenTypeSettings)
    {
        CGPoint centerImView = self.imViewAnasayfa.center;
        CGRect currFrameLblBack = self.lblBack.frame;
        currFrameLblBack.origin.x = centerImView.x-30;
        self.lblBack.frame = currFrameLblBack;
        
        self.imViewAnasayfa.alpha = 0;
        
        CGRect currFrameName = self.lblStudentName.frame;
        currFrameName.origin.x -= 30;
        self.lblStudentName.frame= currFrameName;
        
        self.btnAyarlar.alpha = 0;
        self.imViewAyarlar.alpha = 0;
        
        self.lblResimEkle.alpha = 0;
        self.lblKategoriEkle.alpha = 0;
        
        self.btnKategoriEkle.alpha = 0;
        self.btnResimEkle.alpha = 0;
        
        self.lblArsivdenSec.alpha = 0;
        self.btnArsivdenSec.alpha = 0 ;
        
    }
    else
    {
        
    }
    
    _typeScreen = typeScreen;
}




- (IBAction)btnKategoriEkleOnTap:(id)sender {
    
    if([self.delegateNavbar respondsToSelector:@selector(teacherNavBarKategoriEkleOnTap:)])
    {
        [self.delegateNavbar teacherNavBarKategoriEkleOnTap:self];
    }
    
}

- (IBAction)btnResimEkleOnTap:(id)sender {
    
    if([self.delegateNavbar respondsToSelector:@selector(teacherNavBarResimEkleOnTap:)])
    {
        [self.delegateNavbar teacherNavBarResimEkleOnTap:self];
    }
}

- (IBAction)btnArsivdenSecOnTap:(id)sender {
    
    if([self.delegateNavbar respondsToSelector:@selector(teacherNavBarArsivdenSecOnTap:)])
    {
        [self.delegateNavbar teacherNavBarArsivdenSecOnTap:self];
    }
    
}

- (IBAction)kategoriSettingsOnTap:(id)sender {
    
    if([self.delegateNavbar respondsToSelector:@selector(teacherNavbarKategoriSettingsOnTap:)])
    {
        [self.delegateNavbar teacherNavbarKategoriSettingsOnTap:self];
    }
}



- (IBAction)btnAyarlarDidTap:(id)sender {
    
    if([self.delegateNavbar respondsToSelector:@selector(teacherNavBarAyarlarOnTap:)])
    {
        [self.delegateNavbar teacherNavBarAyarlarOnTap:self];
    }
}

- (IBAction)btnHomepageDidTap:(id)sender {
    
    if([self.delegateNavbar respondsToSelector:@selector(teacherNavBarHomepageOnTap:)])
    {
        [self.delegateNavbar teacherNavBarHomepageOnTap:self];
    }
    
}

- (IBAction)cancelOnTap:(id)sender {
    
    if([self.delegateNavbar respondsToSelector:@selector(teacherNavbarCancelOnTap:)])
    {
        [self.delegateNavbar teacherNavbarCancelOnTap:self];
    }
    
}
@end

//
//  MainActionPageVC.h
//  DeryaHoca
//
//  Created by aybek can kaya on 16/11/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import "BaseVC.h"

#import "User.h"

#import "TeacherNavBar.h"
#import "StudentNavBar.h"
#import "Story.h"
#import "BottomBar.h"
#import "SettingsGeneralVC.h"
#import "KategoriSecVC.h"
#import "CategoryScroll.h"

#import "KategoriView.h"
#import "Kategori.h"
#import "KategoriStudent.h"

#import "KategoriEkleVC.h"
#import "NavigationController.h"
#import "ArsivVC.h"





typedef enum MainActionPageType
{
    kMainActionPageTypeStudent,
    kMainActionPageTypeTeacher
    
}MainActionPageType;


/**
 @property(nonatomic) int ID;
 @property(nonatomic) int studentID;
 @property(nonatomic) int kategoriID;
 
 // category specs for student
 
 @property(nonatomic) KategoriTypeStudent typeKategori;
 
 @property(nonatomic) int parentID;
 @property(nonatomic, strong) NSString *name;
 @property(nonatomic ,strong) NSString *imagePlace;
 @property(nonatomic) int puntoLabel;
 
 @property(nonatomic , strong) NSString *clBgYazi;
 @property(nonatomic ,strong) NSString *clBgMn; // color bg main
 
 @property(nonatomic ,strong) NSString *fontName;
 
 
 @property(nonatomic ) int yaziEnabled;
 @property(nonatomic) int gorselEnabled;
 @property(nonatomic) int sesEnabled;
 
 @property(nonatomic  , strong) NSString *frameString;
 
 // for Kategori View
 @property(nonatomic ) BOOL isSelectedItem;

 
 */

/*
 
 #define RADIANS(degrees) ((degrees * M_PI) / 180.0)
 
 CGAffineTransform leftWobble = CGAffineTransformRotate(CGAffineTransformIdentity, RADIANS(-2.0));
 CGAffineTransform rightWobble = CGAffineTransformRotate(CGAffineTransformIdentity, RADIANS(2.0));
 
 cell.transform = leftWobble;  // starting point
 cell.deleteButton.hidden = NO;
 
 [UIView animateWithDuration:0.125 delay:0 options:(UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse) animations:^{
 cell.transform = rightWobble;
 }completion:^(BOOL finished){
 }];
 */

@interface MainActionPageVC : BaseVC<StudentNavBarDelegate , TeacherNavBarDelegate, BottomBardelegate, CategoryScrollDatasource , CategoryScrollDelegate, KategoriViewDelegate , UIAlertViewDelegate , BottomBarDatasource , StudentNavBarDatasource>
{
    
    Sound *soundObject;
    
    NSArray *itemsReadyToDelete;
    
   // BOOL showCategorySelectedItems; // ögrenci hangi kategorileri görecek
   // BOOL kategoriSettingsEnabled;
    
    int currentSelectedParentID;
    
    // Kategori Elements
    NSMutableArray *arrCategoryObjects;
    
    BottomBar *barBottom;
    
    // Student Type
    StudentNavBar *navbarStudent;
    
    // Teacher Type
    TeacherNavBar *navbarTeacher;
    
    
    // dynamic Items
    CumleSeridiItem *viewCumleSeridiItem;
    CGRect cumleSeridiItemBeginFrame;
    
    int pageWillDelete;
    
    BOOL isKategoriViewAnimating;
    
}

@property(nonatomic) MainActionPageType typePage;

@property (weak, nonatomic) IBOutlet CategoryScroll *scrollCategory;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;



@end

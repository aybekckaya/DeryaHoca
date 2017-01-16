//
//  ArsivVC.h
//  DeryaHoca
//
//  Created by aybek can kaya on 27/11/15.
//  Copyright © 2015 aybek can kaya. All rights reserved.
//

#import "BaseVC.h"
#import "BottomBar.h"
#import "Story.h"

#import "KategoriEkleVC.h"
#import "NavigationController.h"

#import "CategoryScroll.h"
#import "Kategori.h"

#import "KategoriView.h"

#import "User.h"
#import "Settings.h"

typedef enum ArsivVCPageType
{
    kArsivVCPageTypeDefault,
    kArsivVCPageTypeFromAyarlar
    
}ArsivVCPageType;


typedef enum ArsivVCFilterType
{
    kArsivVCFilterNone,
    kArsivVCFilterKategori,
    kArsivVCFilterResim
    
}ArsivVCFilterType;

@interface ArsivVC : BaseVC<BottomBardelegate , CategoryScrollDatasource , KategoriViewDelegate , UIAlertViewDelegate , CategoryScrollDelegate>
{
    BottomBar *barBottom ;
    NSMutableArray *stackOldBarBottom;
    NSMutableArray *stackCurrentBarBottom;
    
    BOOL comeFromKategoriEkleInner;
    
    //NSMutableArray *kategoriIDsOnBottomBar;
    NSMutableArray *kategoriObjectsArr;
    
    int currentSelectedParentCategoryID;
    
    NSMutableArray *kategoriDctsWillRemove;
    
    // ayarlar icinden girilirse
    NSArray *kategoriIDsArrAddedToStudent;
    
}

// supply outside
@property(nonatomic) ArsivVCPageType typePage;
@property(nonatomic) ArsivVCFilterType typeFilter;
@property(nonatomic) int parentID;
@property(nonatomic) CGPoint emptyCenter;

@property (weak, nonatomic) IBOutlet UIButton *btnKategoriEkle;
@property (weak, nonatomic) IBOutlet UILabel *lblKategoriEkle;
@property (weak, nonatomic) IBOutlet UILabel *lblResimEkle;
@property (weak, nonatomic) IBOutlet UIButton *btnResimEkle;

@property (weak, nonatomic) IBOutlet CategoryScroll *scrollCategory;

@property (weak, nonatomic) IBOutlet UIButton *btnHomepage;
@property (weak, nonatomic) IBOutlet UIImageView *imViewHomePage;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (weak, nonatomic) IBOutlet UIButton *btnKapat;

- (IBAction)btnKapatOnTap:(id)sender;

- (IBAction)resimEkleOnTap:(id)sender;

- (IBAction)kategoriEkleOnTap:(id)sender;

- (IBAction)homepageOnTap:(id)sender;




@end

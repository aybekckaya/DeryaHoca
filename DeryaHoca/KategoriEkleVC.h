//
//  KategoriEkleVC.h
//  DeryaHoca
//
//  Created by aybek can kaya on 21/11/15.
//  Copyright © 2015 aybek can kaya. All rights reserved.
//

#import "BaseVC.h"
#import "Story.h"
#import "BottomBar.h"
#import "ISColorWheel.h"
#import "UIView+staticAdditions.h"
#import "UIImage+ImageEffects.h"
#import "ColorChooseView.h"
#import "NSString+LabelSize.h"
#import "FontSelectorTable.h"
#import "Kategori.h"
#import "KategoriStudent.h"
#import "NSString+documentPath.h"
#import "NSString+component.h"
#import "Sound.h"
#import "Settings.h"
#import "User.h"

typedef enum KategoriEkleScreenType
{
    kKategoriEkleScreenTypeKategoriEkle,
    kKategoriEkleScreenTypeResimEkle
    
}KategoriEkleScreenType;


typedef enum KategoriEkleScreenAreaType
{
    kKategoriEkleScreenAreaArsiv,
    kKategoriEkleScreenAreaKategoriSelected,
    kKategoriEkleScreenAreaKategoriSelectedAyarlar,
     kKategoriEkleScreenAreaFromStudentPage
    
}KategoriEkleScreenAreaType;

typedef enum KategoriEkleViewSesTuru
{
    kKategoriEkleViewSesTuruMale,
     kKategoriEkleViewSesTuruFemale
    
}KategoriEkleViewSesTuru;


@interface KategoriEkleVC : BaseVC<BottomBardelegate , ISColorWheelDelegate , UIGestureRecognizerDelegate , ColorChooseViewDelegate, UIScrollViewDelegate ,UINavigationControllerDelegate , UIImagePickerControllerDelegate , UIPickerViewDataSource , UIPickerViewDelegate , FontSelectorTableDelegate , UIAlertViewDelegate>
{
    BottomBar *barBottom;
    
    ISColorWheel *colorWheel;
    
    UIImageView *blurImView;
    
    ColorChooseView *viewColorChoose;
    FontSelectorTable *viewFontSelector;
   
    
    // imageViewArea Main
    
   // CGSize defaultSizeImView;
   // CGSize defaultSizeLabel;
    
    UIImage *imageSelectedMain;
    float currentPunto;
    
    NSString *fontNameCurrent;
    
    KategoriEkleViewSesTuru typeSesTuruOnSelect;
    
    BOOL yaziEnabled;
    BOOL gorselEnabled;
    BOOL sesEnabled;
    
    float currentScaleLabel;
    float currentScaleImView;
    
    // Sound
    Sound *soundObject;
    NSString *outputFileName_Male;
    NSString *outputFileName_Female;
    
}

/*
 KategoriStudent
 
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
 @property(nonatomic ) int chosenItem;
 
 
 // Default variables
 @property(nonatomic , strong) NSString *cntPtMn;
 @property(nonatomic ,strong) NSString *cntPtImView;
 @property(nonatomic ,strong) NSString *cntPtLbl;
 
 @property(nonatomic) float scMn;
 @property(nonatomic) float scImView; // do not change dynamically -> change only in kategoriEkleVC
 @property(nonatomic)float scLbl; // do not change dynamically -> change only in kategoriEkleVC
 @property (nonatomic , strong) NSString *frLbl;
 
 
 
 
 */

// supplied from Outside
@property(nonatomic) KategoriEkleScreenType typeScreen;
@property(nonatomic) KategoriEkleScreenAreaType typeAreaScreen;
@property(nonatomic) int categoryParentID;
@property(nonatomic) Kategori *selectedKategoriObject;
@property(nonatomic) KategoriStudent *selectedKategoriStudentObject;
@property(nonatomic ,strong) NSMutableArray *stackBarBottom;
@property(nonatomic) int studentIDCurrent;
@property(nonatomic) int kategoriIDCurrent;
@property(nonatomic) BOOL pinchEnabled;
@property(nonatomic) BOOL panEnabled;
@property(nonatomic) CGPoint viewCenter;


@property (weak, nonatomic) IBOutlet UILabel *lblHeader;

@property (weak, nonatomic) IBOutlet UIView *viewImagePictureArea;
@property (weak, nonatomic) IBOutlet UIImageView *imViewPicture;
@property (weak, nonatomic) IBOutlet UILabel *lblPicture;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollForm;
@property (weak, nonatomic) IBOutlet UITextField *tfYaziEkle;

@property (weak, nonatomic) IBOutlet UISlider *sliderPunto;
@property (weak, nonatomic) IBOutlet UILabel *lblCurrentPunto;

@property (weak, nonatomic) IBOutlet UIView *viewColorWheel;
@property (weak, nonatomic) IBOutlet UITextField *tfRedColor;
@property (weak, nonatomic) IBOutlet UITextField *tfGreenColor;
@property (weak, nonatomic) IBOutlet UITextField *tfBlueColor;
@property (weak, nonatomic) IBOutlet UISlider *sliderBrightness;
@property (weak, nonatomic) IBOutlet UILabel *lblBrightness;

@property (weak, nonatomic) IBOutlet UIView *viewStudentArea;

@property (weak, nonatomic) IBOutlet UIView *viewSesSelectionRadio;
@property (weak, nonatomic) IBOutlet UIView *viewYaziSelectionRadio;
@property (weak, nonatomic) IBOutlet UIView *viewGorselSelectionRadio;

@property (weak, nonatomic) IBOutlet UILabel *lblRecordingSeconds;
@property (weak, nonatomic) IBOutlet UIView *viewSesTuruRadioMale;
@property (weak, nonatomic) IBOutlet UIView *viewSesTuruRadioFemale;

@property (weak, nonatomic) IBOutlet UIButton *btnYaziRengi;
@property (weak, nonatomic) IBOutlet UIButton *btnArkaPlanRengi;

@property (weak, nonatomic) IBOutlet UITextField *tfRedColorArkaPlan;
@property (weak, nonatomic) IBOutlet UITextField *tfGreenColorArkaPlan;
@property (weak, nonatomic) IBOutlet UITextField *tfBlueColorArkaPlan;
@property (weak, nonatomic) IBOutlet UILabel *lblFontNameSelected;

@property (weak, nonatomic) IBOutlet UIImageView *imViewRecord;
@property (weak, nonatomic) IBOutlet UIImageView *imViewPlay;
@property (weak, nonatomic) IBOutlet UILabel *lblSesStatic;
@property (weak, nonatomic) IBOutlet UIButton *btnPlay;
@property (weak, nonatomic) IBOutlet UIButton *btnRecord;
@property (weak, nonatomic) IBOutlet UIButton *btnSil;

@property (weak, nonatomic) IBOutlet UIView *viewSesArea;

@property (weak, nonatomic) IBOutlet UIView *redIconBottom;
@property (weak, nonatomic) IBOutlet UIView *greenIconBottom;
@property (weak, nonatomic) IBOutlet UIView *blueIconBottom;

@property (weak, nonatomic) IBOutlet UIView *redIconUpper;
@property (weak, nonatomic) IBOutlet UIView *greenIconUpper;
@property (weak, nonatomic) IBOutlet UIView *blueIconUpper;

@property (weak, nonatomic) IBOutlet UIImageView *imViewSes;
@property (weak, nonatomic) IBOutlet UIImageView *imViewYazi;
@property (weak, nonatomic) IBOutlet UIImageView *imViewGorsel;




- (IBAction)iptalOnTap:(id)sender;

- (IBAction)kaydetOnTap:(id)sender;

- (IBAction)btnRecordingPlayOnTap:(id)sender;
- (IBAction)btnRecordingStopOnTap:(id)sender;



- (IBAction)sesRadioOnTap:(id)sender;
- (IBAction)yaziRadioOnTap:(id)sender;
- (IBAction)gorselRadioOnTap:(id)sender;

- (IBAction)sesTuruMaleOnTap:(id)sender;
- (IBAction)sesTuruFemaleOnTap:(id)sender;


-(IBAction)puntoSliderValueChanged:(id)sender;

- (IBAction)btnYaziTipiOnTap:(id)sender;


- (IBAction)btnYaziRengiSecOnTap:(id)sender;
- (IBAction)btnArkaPlanResmiSecOnTap:(id)sender;

-(IBAction)tfYaziEkleValueOnChange:(id)sender;

- (IBAction)colorYaziRengiOnChange:(id)sender;

- (IBAction)colorArkaPlanOnChange:(id)sender;

- (IBAction)silBtnOnTap:(id)sender;

+(CGSize) sizeOfViewPictureArea;

+(CGSize) sizeOfImageViewPicture;


@end

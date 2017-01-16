//
//  KategoriEkleVC.m
//  DeryaHoca
//
//  Created by aybek can kaya on 21/11/15.
//  Copyright © 2015 aybek can kaya. All rights reserved.
//

#import "KategoriEkleVC.h"

@interface KategoriEkleVC ()

@end

@implementation KategoriEkleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    soundObject = [[Sound alloc] init];
    
    
    NSString *docPath = [NSString devicePath];
    
   // self.lblPicture.backgroundColor = [UIColor greenColor];
    
    
    [self initGUI];
    [self setDefaultValues];
    
    
    // 9 .12 .2015
    
    self.redIconBottom.alpha = 0;
    self.greenIconBottom.alpha = 0;
    self.blueIconBottom.alpha = 0;
    
    self.greenIconUpper.alpha = 0;
    self.blueIconUpper.alpha = 0;
    self.greenIconUpper.alpha = 0;
    
    
    self.tfBlueColor.alpha = 0;
    self.tfBlueColorArkaPlan.alpha = 0;
    self.tfGreenColor.alpha = 0;
    self.tfGreenColorArkaPlan.alpha = 0;
    self.tfRedColor.alpha = 0;
    self.tfRedColorArkaPlan.alpha = 0;
    
    
    
    UITapGestureRecognizer *recTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnScroll)];
    recTap.numberOfTapsRequired = 1;
    recTap.numberOfTouchesRequired = 1;
    
    [self.scrollForm  addGestureRecognizer:recTap];
    
    
    // Pan + pinch Gestures
    self.imViewPicture.userInteractionEnabled = YES;
    self.lblPicture.userInteractionEnabled = YES;
    
    UIPanGestureRecognizer *recPanImView = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewPictureOnPan:)];
    [self.imViewPicture addGestureRecognizer:recPanImView];
    
    UIPanGestureRecognizer *recPanLbl = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(lblPictureOnPan:)];
    [self.lblPicture addGestureRecognizer:recPanLbl];
    
    
    UIPinchGestureRecognizer *recPinchImView = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewPictureOnPinch:)];
    [self.imViewPicture addGestureRecognizer:recPinchImView];
    
    
    UIPinchGestureRecognizer *recPinchLbl = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(lblPictureOnPinch:)];
    [self.lblPicture addGestureRecognizer:recPinchLbl];
    
    
}


-(void)tapOnScroll
{
    [self.view endEditing:YES];
}




-(void)initGUI
{
    currentScaleImView = 1;
    currentScaleLabel = 1;
    
  //  self.lblPicture.backgroundColor = [UIColor greenColor];
    
    // picture view
    
    CGSize sizePictureView = [KategoriEkleVC sizeOfViewPictureArea];
    CGRect currRect = self.viewImagePictureArea.frame;
    currRect.size.height = sizePictureView.height;
    currRect.size.width = sizePictureView.width;
    
    self.viewImagePictureArea.frame = currRect;
    
    self.viewImagePictureArea.layer.cornerRadius = 10;
     self.viewImagePictureArea.layer.masksToBounds = NO;
    
     self.viewImagePictureArea.layer.shadowOffset = CGSizeMake(-1, 10);
     self.viewImagePictureArea.layer.shadowRadius = 5;
     self.viewImagePictureArea.layer.shadowOpacity = 0.5;
    
    
    
    
    
    // bottom bar
    
    barBottom = [Story GetViewFromNibByName:@"BottomBar"];
    CGRect currFrame = barBottom.frame ;
    currFrame.origin.y = self.view.frame.size.height - currFrame.size.height;
    barBottom.delegateBarBottom = self;
    barBottom.frame = currFrame;
    barBottom.typePage = kBottomBarPageTypeKategoriEkle;
    
    [self.view addSubview:barBottom];
    
    [barBottom setStackObjects:self.stackBarBottom];
    
    /*
    UIImage *theImage = [UIImage imageNamed:@"anasayfaIcon.png"];
    UIImageView *imView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 72, 72)];
    imView.image = theImage;
    
    [barBottom pushUIImageView:imView];
    */
    
    
    if(self.typeScreen == kKategoriEkleScreenTypeKategoriEkle)
    {
        self.lblHeader.text = @"Kategori Ekle";
    }
    else if(self.typeScreen == kKategoriEkleScreenTypeResimEkle)
    {
        self.lblHeader.text = @"Resim Ekle";
    }
    
    
    if(self.typeAreaScreen == kKategoriEkleScreenAreaKategoriSelected)
    {
       
    }
    else if(self.typeAreaScreen == kKategoriEkleScreenAreaArsiv)
    {
         self.btnSil.alpha = 0;
    }
    else if(self.typeAreaScreen == kKategoriEkleScreenAreaKategoriSelectedAyarlar)
    {
        
    }
    else if(self.typeAreaScreen == kKategoriEkleScreenAreaFromStudentPage)
    {
         self.btnSil.alpha = 0;
    }
    
    
    
    self.scrollForm.contentSize = CGSizeMake(self.scrollForm.contentSize.width, 1139);
    
    self.scrollForm.frame = CGRectMake(0, 96, 650, 602);
    self.scrollForm.delegate = self;
    
    
    
    
    viewColorChoose = [Story GetViewFromNibByName:@"ColorChooseView"];
    viewColorChoose.delegateColorChoose = self;
    [self.view addSubview:viewColorChoose];
    
    
    viewFontSelector = [Story GetViewFromNibByName:@"FontSelectorTable"];
    viewFontSelector.delegateView = self;
    [self.view addSubview:viewFontSelector];
    
  //  viewColorChoose.center = self.view.center;
    
   // [self performSelector:@selector(openColorChoose) withObject:nil afterDelay:2];
    
    // Tap gesture To ImageView
    
    self.imViewPicture.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *recTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewMainOnTap)];
    recTap.numberOfTapsRequired = 1;
    recTap.numberOfTouchesRequired = 1;
    [self.imViewPicture addGestureRecognizer:recTap];
    
    
    UIPinchGestureRecognizer *recPinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchOnImageView:)];
    [self.imViewPicture addGestureRecognizer:recPinch];
    
    
   // slider Punto
    
    self.sliderPunto.minimumValue = 1;
    self.sliderPunto.maximumValue = 60;
    self.sliderPunto.value = (self.sliderPunto.minimumValue+self.sliderPunto.maximumValue)/2;
    
    if(self.selectedKategoriStudentObject == nil)
    {
         [self puntoSliderValueChanged:nil];
    }
   
    
    
    [self radioSesTuruOnSelect:kKategoriEkleViewSesTuruMale];
    
    yaziEnabled = YES;
    sesEnabled = YES;
    gorselEnabled = YES;
    
    [self updateViewStudentArea];
    
    self.viewStudentArea.backgroundColor = [UIColor clearColor];
    
    
    if(self.typeScreen == kKategoriEkleScreenTypeResimEkle)
    {
       
        
    }
    else if(self.typeScreen == kKategoriEkleScreenTypeKategoriEkle)
    {
        self.viewSesArea.backgroundColor = [UIColor clearColor];
        
      //  self.viewSesArea.alpha = 0.3;
        //self.viewStudentArea.alpha = 0.5;
        
        //UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.viewSesArea.frame.size.width, self.viewSesArea.frame.size.height)];
       // tempView.backgroundColor = [UIColor clearColor];
       // [self.viewSesArea addSubview:tempView];
    }
    
    
      [self.viewImagePictureArea bringSubviewToFront:self.lblPicture];
    
    
    int curr_user_id = [[User currentUser] ID];
    if(curr_user_id > 0)
    {
        if([Settings userExist:curr_user_id])
        {
            Settings *st = [[Settings alloc]initWithUserID:curr_user_id];
            
            if(st.typeSesTuru == kSesTuruFemale)
            {
                [self sesTuruFemaleOnTap:nil];
            }
            else
            {
                [self sesTuruMaleOnTap:nil];
            }
            
        }
    }
    
}



-(void)setDefaultValues
{
    
    
    self.lblPicture.text = @"";
    fontNameCurrent = @"HelveticaNeue-Light";
    self.lblPicture.font = [UIFont fontWithName:fontNameCurrent size:currentPunto];
    
    self.tfBlueColor.text = @"0";
    self.tfGreenColor.text = @"0";
    self.tfRedColor.text = @"0";
    
    self.tfBlueColorArkaPlan.text = @"0";
    self.tfGreenColorArkaPlan.text = @"0";
    self.tfRedColorArkaPlan.text = @"0";
    
    self.lblFontNameSelected.text= fontNameCurrent;
    
    if(self.selectedKategoriStudentObject != nil)
    {
        //NSLog(@"selected cat : %@" , [self.selectedKategoriStudentObject getDictionary]);
        
        // set selected Kategori Values
        
        imageSelectedMain = [self.selectedKategoriStudentObject getCategoryImage];
        self.imViewPicture.image = [self.selectedKategoriStudentObject getCategoryImage];
        self.lblPicture.text = self.selectedKategoriStudentObject.name;
        self.tfYaziEkle.text = self.selectedKategoriStudentObject.name;
        self.lblFontNameSelected.text = self.selectedKategoriStudentObject.fontName;
        
        // font picker selection
        [viewFontSelector selectFontName:self.selectedKategoriStudentObject.fontName];
        fontNameCurrent = self.selectedKategoriStudentObject.fontName;
        currentPunto = self.selectedKategoriStudentObject.puntoLabel;
        
        // color set
        NSString *strColorBG = [self.selectedKategoriStudentObject.clBgMn stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSArray *componentsBG = [strColorBG componentsSeparatedByString:@","];
        self.tfRedColorArkaPlan.text = componentsBG[0];
        self.tfGreenColorArkaPlan.text = componentsBG[1];
        self.tfBlueColorArkaPlan.text = componentsBG[2];
        
        UIColor *colorBG = [strColorBG colorValueFromComponent];
        self.viewImagePictureArea.backgroundColor = colorBG;
        
        NSString *strColorYazi = [self.selectedKategoriStudentObject.clBgYazi stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSArray *componentsYazi = [strColorYazi componentsSeparatedByString:@","];
        self.tfRedColor.text = componentsYazi[0];
        self.tfGreenColor.text = componentsYazi[1];
        self.tfBlueColor.text = componentsYazi[2];
        
        UIColor *colorYazi = [strColorYazi colorValueFromComponent];
        self.lblPicture.textColor = colorYazi;
        
        self.imViewPicture.transform = CGAffineTransformMakeScale(self.selectedKategoriStudentObject.scImView, self.selectedKategoriStudentObject.scImView);
        self.imViewPicture.center = [self.selectedKategoriStudentObject.cntPtImView pointValueFromComponent];
        self.lblPicture.frame = [self.selectedKategoriStudentObject.frLbl frameValueFromComponent];
        
        
        
        // slider Value
        self.sliderPunto.value = self.selectedKategoriStudentObject.puntoLabel;
        
        yaziEnabled = self.selectedKategoriStudentObject.yaziEnabled;
        sesEnabled = self.selectedKategoriStudentObject.sesEnabled;
        gorselEnabled = self.selectedKategoriStudentObject.gorselEnabled;
        [self updateViewStudentArea];
        
         [self puntoSliderValueChanged:nil];

    }
    else if(self.selectedKategoriObject != nil)
    {
        //NSLog(@"selected cat : %@" , [self.selectedKategoriObject getDictionary]);
        
        // set selected Kategori Values
        
        imageSelectedMain = [self.selectedKategoriObject getCategoryImage];
        self.imViewPicture.image = [self.selectedKategoriObject getCategoryImage];
        self.lblPicture.text = self.selectedKategoriObject.name;
        self.tfYaziEkle.text = self.selectedKategoriObject.name;
        self.lblFontNameSelected.text = self.selectedKategoriObject.fontName;
        
        // font picker selection
        [viewFontSelector selectFontName:self.selectedKategoriObject.fontName];
        fontNameCurrent = self.selectedKategoriObject.fontName;
        
        // color set
        NSString *strColorBG = [self.selectedKategoriObject.clBgMn stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSArray *componentsBG = [strColorBG componentsSeparatedByString:@","];
        self.tfRedColorArkaPlan.text = componentsBG[0];
        self.tfGreenColorArkaPlan.text = componentsBG[1];
        self.tfBlueColorArkaPlan.text = componentsBG[2];
        
        UIColor *colorBG = [strColorBG colorValueFromComponent];
        self.viewImagePictureArea.backgroundColor = colorBG;
        
        NSString *strColorYazi = [self.selectedKategoriObject.clBgYazi stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSArray *componentsYazi = [strColorYazi componentsSeparatedByString:@","];
        self.tfRedColor.text = componentsYazi[0];
        self.tfGreenColor.text = componentsYazi[1];
        self.tfBlueColor.text = componentsYazi[2];
        
        UIColor *colorYazi = [strColorYazi colorValueFromComponent];
        self.lblPicture.textColor = colorYazi;
        
        
        // slider Value
        self.sliderPunto.value = self.selectedKategoriObject.puntoLabel;
        
        yaziEnabled = self.selectedKategoriObject.yaziEnabled;
        sesEnabled = self.selectedKategoriObject.sesEnabled;
        gorselEnabled = self.selectedKategoriObject.gorselEnabled;
        [self updateViewStudentArea];
        
        [self puntoSliderValueChanged:nil];
        
    }
    
    
    
}


-(void)openColorChoose
{
    [viewColorChoose openFromPoint:CGPointMake(10, 10)];
}


/**
  @ sets variables from category/picture selected
 */
-(void)guiUpdate
{
    
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

- (IBAction)iptalOnTap:(id)sender {
    
    
    if(self.selectedKategoriObject == nil && self.selectedKategoriStudentObject == nil)
    {
        if(outputFileName_Female != nil)
        {
            [outputFileName_Female removeItem];
        }
        
        if(outputFileName_Male != nil)
        {
            [outputFileName_Female removeItem];
        }

    }
    
    
    
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}


-(BOOL)validateInputs
{
   
    
    
    return YES;
    
    /*
    NSString *yaziTrimmed = [self.tfYaziEkle.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if(yaziTrimmed.length == 0 && imageSelectedMain == nil)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Derya Hoca" message:@"Yazı veya resim eklenmelidir." delegate:self cancelButtonTitle:@"Tamam" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    
    
    return YES;
     
     */
    
}


- (IBAction)kaydetOnTap:(id)sender
{
    if(![self validateInputs])
    {
        return;
    }
    
    
    if(self.typeAreaScreen == kKategoriEkleScreenAreaArsiv)
    {
        Kategori *ktTemp = [[Kategori alloc] init];
        int newID = [ktTemp newIDForTable];
        
        [self saveCategoryWithCategoryID:newID];
        
    }
    else if(self.typeAreaScreen == kKategoriEkleScreenAreaKategoriSelected)
    {
        [self saveCategoryWithCategoryID:self.selectedKategoriObject.ID];
    }
    else if(self.typeAreaScreen == kKategoriEkleScreenAreaKategoriSelectedAyarlar)
    {
        [self saveSelectedKategoriStudentObject];
    }
    else if(self.typeAreaScreen == kKategoriEkleScreenAreaFromStudentPage)
    {
       // newly added category student
        [self saveCategoryForStudentPage];
       
    }
    
    
}


-(void)saveCategoryForStudentPage
{
    KategoriStudent *ks = [[KategoriStudent alloc] init];
    ks.ID = [ks newIDForTable];
    ks.parentID = self.categoryParentID;
    ks.studentID = self.studentIDCurrent ;
    ks.kategoriID = self.kategoriIDCurrent;
    ks.typeKategori = kKategoriTypeKategoriStudent;
    ks.name = self.tfYaziEkle.text;
    
    
    if(self.typeScreen == kKategoriEkleScreenTypeResimEkle)
    {
        ks.typeKategori = kKategoriTypeResimStudent;
    }
    
    [ks saveCategoryImage:imageSelectedMain];
    
    ks.imagePlace = @"asd";
    ks.puntoLabel = currentPunto;
    ks.fontName = fontNameCurrent;
    ks.clBgMn = [NSString stringComponentFromColor:self.viewImagePictureArea.backgroundColor];
    ks.clBgYazi = [NSString stringComponentFromColor:self.lblPicture.textColor];
    ks.scMn = 1;
    
    CGPoint defaultPt = CGPointMake(0, 0);
    
    ks.cntPtMn = [NSString stringComponentFromCGPoint:defaultPt];
    
    if(self.viewCenter.x != 0 || self.viewCenter.y != 0)
    {
        ks.cntPtMn = [NSString stringComponentFromCGPoint:self.viewCenter];
    }
    
    ks.frLbl = [NSString stringComponentFromFrame:self.lblPicture.frame];
    
    CGSize defaultSizeImage = [KategoriEkleVC sizeOfImageViewPicture];
    ks.scImView = (float) self.imViewPicture.frame.size.width / defaultSizeImage.width;
    ks.cntPtImView = [NSString stringComponentFromCGPoint:self.imViewPicture.center];
    
    
    ks.gorselEnabled = gorselEnabled;
    ks.sesEnabled = sesEnabled;
    ks.yaziEnabled = yaziEnabled;
    
    
    //NSLog(@"%@" , [ks getDictionary]);
    
    ////NSLog(@"image View Frame : %@" , NSStringFromCGRect(self.imViewPicture.frame));
    // //NSLog(@"Label Frame : %@" , NSStringFromCGRect(self.lblPicture.frame));
    
   
    
    [ks saveModel];
    
    
    
    // Debug
    
    //KategoriStudent *st = [[KategoriStudent alloc] initWithID:ks.ID];
    ////NSLog(@"st : %@" , [st getDictionary]);
    
    
    if(self.typeScreen == kKategoriEkleScreenTypeKategoriEkle)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Derya Hoca" message:@"Kategori kaydedildi." delegate:self cancelButtonTitle:@"Tamam" otherButtonTitles: nil];
        alert.tag = 1002;
        [alert show];
    }
    else if(self.typeScreen == kKategoriEkleScreenTypeResimEkle)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Derya Hoca" message:@"Resim kaydedildi." delegate:self cancelButtonTitle:@"Tamam" otherButtonTitles: nil];
        alert.tag = 1002;
        [alert show];
    }
        
    
    
    
    
    
    
}



-(void)saveSelectedKategoriStudentObject
{
    
    if(![self validateInputs])
    {
        return;
    }
    
    
    [self.selectedKategoriStudentObject saveCategoryImage:imageSelectedMain];
    
    self.selectedKategoriStudentObject.clBgMn = [NSString stringComponentFromColor:self.viewImagePictureArea.backgroundColor];
    self.selectedKategoriStudentObject.clBgYazi = [NSString stringComponentFromColor:self.lblPicture.textColor];
    self.selectedKategoriStudentObject.puntoLabel = currentPunto;
    self.selectedKategoriStudentObject.fontName = fontNameCurrent;
    self.selectedKategoriStudentObject.yaziEnabled = yaziEnabled;
    self.selectedKategoriStudentObject.gorselEnabled = gorselEnabled;
    self.selectedKategoriStudentObject.sesEnabled = sesEnabled;
    self.selectedKategoriStudentObject.name = self.tfYaziEkle.text;
    
    //CGPoint defaultPt = CGPointMake(0, 0);
    
    //self.selectedKategoriStudentObject.cntPtMn = [NSString stringComponentFromCGPoint:defaultPt];
    
    
    self.selectedKategoriStudentObject.frLbl = [NSString stringComponentFromFrame:self.lblPicture.frame];
    
    CGSize defaultSizeImage = [KategoriEkleVC sizeOfImageViewPicture];
    self.selectedKategoriStudentObject.scImView = (float) self.imViewPicture.frame.size.width / defaultSizeImage.width;
    self.selectedKategoriStudentObject.cntPtImView = [NSString stringComponentFromCGPoint:self.imViewPicture.center];
    
  //  //NSLog(@"%@" , [self.selectedKategoriStudentObject getDictionary]);

    
    
    [self.selectedKategoriStudentObject saveModel];
    
    
    if(self.typeScreen == kKategoriEkleScreenTypeKategoriEkle)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Derya Hoca" message:@"Kategori kaydedildi." delegate:self cancelButtonTitle:@"Tamam" otherButtonTitles: nil];
        alert.tag = 1002;
        [alert show];
    }
    else if(self.typeScreen == kKategoriEkleScreenTypeResimEkle)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Derya Hoca" message:@"Resim kaydedildi." delegate:self cancelButtonTitle:@"Tamam" otherButtonTitles: nil];
        alert.tag = 1002;
        [alert show];
    }
    
    
}


-(void)saveCategoryWithCategoryID:(int)catID
{
    Kategori *kt = [[Kategori alloc] init];
    
    if(self.typeScreen == kKategoriEkleScreenTypeResimEkle)
    {
        kt.typeKategori = kKategoriTypeResim;
    }
    else if(self.typeScreen == kKategoriEkleScreenTypeKategoriEkle)
    {
        kt.typeKategori = kKategoriTypeKategori;
    }
    
    
    kt.ID = catID;
    
    if(imageSelectedMain == nil)
    {
        kt.imagePlace = @"";
    }
    else
    {
        [kt saveCategoryImage:imageSelectedMain];
    }
    
    kt.parentID = -1;
    if(self.categoryParentID != 0)
    {
        kt.parentID = self.categoryParentID;
    }
    
    kt.name = self.tfYaziEkle.text;
    kt.puntoLabel = currentPunto;
    kt.fontName = fontNameCurrent;
    
    
    kt.yaziEnabled = yaziEnabled;
    kt.gorselEnabled = gorselEnabled;
    kt.sesEnabled = sesEnabled;
    
    
    
    /*
     kt.yaziEnabled = 0;
     kt.gorselEnabled = 0;
     kt.sesEnabled = 1;
     */
    
    UIColor *clrBG = self.viewImagePictureArea.backgroundColor;
    UIColor *clrYazi = self.lblPicture.textColor;
    
    
    kt.clBgMn = [NSString stringComponentFromColor:self.viewImagePictureArea.backgroundColor];
    kt.clBgYazi = [NSString stringComponentFromColor:self.lblPicture.textColor];
    
    //   kt.colorYaziComponent = @"asd";
    // kt.colorArkaplanComponent = @"asd";
    
    kt.cntPtMn = @"0,0";
    kt.cntPtImView = [NSString stringComponentFromCGPoint:self.imViewPicture.center];
    kt.cntPtLbl = [NSString stringComponentFromCGPoint:self.lblPicture.center];
    kt.scMn = 1;
    kt.scImView = 1;
    kt.scLbl = 1;
    kt.frLbl = [NSString stringComponentFromFrame:self.lblPicture.frame];
    
    
    NSDictionary *dct = [kt getDictionary];
    //NSLog(@"dct : %@ " , dct);
    
    [kt saveModel];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Derya Hoca" message:@"Kategori kaydedildi." delegate:self cancelButtonTitle:@"Tamam" otherButtonTitles: nil];
    alert.tag = 1002;
    [alert show];
}


// For listening
- (IBAction)btnRecordingPlayOnTap:(id)sender
{
   if(self.imViewPlay.highlighted == YES)
   {
       self.imViewPlay.highlighted = NO;
       
       // pause Sound
       
       [soundObject stopPlaying];
   }
    else
    {
        self.imViewPlay.highlighted = YES;
        
        BOOL isFemale = NO;
        if(typeSesTuruOnSelect == kKategoriEkleViewSesTuruFemale)
        {
            isFemale = YES;
        }
        
        // play sound
        
        if((outputFileName_Male == nil && isFemale == NO) || (outputFileName_Female == nil && isFemale == YES))
        {
            // play preselected Sound
            
            
            NSString *soundPath;
            if(self.selectedKategoriObject != nil)
            {
                soundPath = [self.selectedKategoriObject getSoundFullPath:kKategoriSesTuruTypeMale];
                if(isFemale == YES)
                {
                    soundPath = [self.selectedKategoriObject getSoundFullPath:kKategoriSesTuruTypeFemale];
                }
            }
            else if(self.selectedKategoriStudentObject != nil)
            {
                soundPath = [self.selectedKategoriStudentObject getSoundFullPath:kKategoriStudentSesTuruTypeMale];
                if(isFemale == YES)
                {
                    soundPath = [self.selectedKategoriStudentObject getSoundFullPath:kKategoriStudentSesTuruTypeFemale];
                }
            }
            else
            {
                // give error message that sound not found
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Derya Hoca" message:@"Ses bulunamadı" delegate:self cancelButtonTitle:@"Tamam" otherButtonTitles: nil];
                [alert show];
                
                self.imViewPlay.highlighted = NO;
                
                return;
            }
            
            if(soundPath != nil)
            {
                [soundObject playSound:soundPath success:^(NSString *soundPath, float currentTime, float duration, BOOL didFinished, BOOL didPaused) {
                    
                    //NSLog(@"play current Time : %f  , duration : %f" , currentTime , duration);
                    
                    NSString *strSeconds = [NSString stringWithFormat:@"%0.0f" , currentTime ];
                    
                    if(currentTime < 10)
                    {
                        strSeconds = [NSString stringWithFormat:@"0%0.0f" , currentTime ];
                    }
                    
                    NSString *currTimeStr = [NSString stringWithFormat:@"00:%@" , strSeconds];
                    
                    self.lblRecordingSeconds.text= currTimeStr;
                    
                    if(didFinished || didPaused)
                    {
                        self.imViewPlay.highlighted = NO;
                    }
                    
                    
                } failure:^(NSError *error, NSString *soundPath) {
                    
                }];
            }
            
            
        }
        else
        {
           // play from output
            
            NSString *outputName = outputFileName_Male;
            if(isFemale == YES)
            {
                outputName = outputFileName_Female;
            }
            
            [soundObject playSound:outputName success:^(NSString *soundPath, float currentTime, float duration, BOOL didFinished, BOOL didPaused) {
               
                 //NSLog(@"play current Time : %f  , duration : %f" , currentTime , duration);
                
                NSString *strSeconds = [NSString stringWithFormat:@"%0.0f" , currentTime ];
                
                if(currentTime < 10)
                {
                    strSeconds = [NSString stringWithFormat:@"0%0.0f" , currentTime ];
                }
                
                NSString *currTimeStr = [NSString stringWithFormat:@"00:%@" , strSeconds];
                
                self.lblRecordingSeconds.text= currTimeStr;
                
                
                if(didFinished || didPaused)
                {
                    self.imViewPlay.highlighted = NO;
                }
                
            } failure:^(NSError *error, NSString *soundPath) {
                
                
                
            }];
            
        }
    }
    
}

- (IBAction)sesRadioOnTap:(id)sender {
    
    if(sesEnabled == YES)
    {
        sesEnabled = NO;
    }
    else
    {
        sesEnabled = YES;
    }
    
    
    [self updateViewStudentArea];
}

- (IBAction)yaziRadioOnTap:(id)sender {
    
    if(yaziEnabled == YES)
    {
        yaziEnabled = NO;
    }
    else
    {
        yaziEnabled = YES;
    }
    
    [self updateViewStudentArea];
    
}

- (IBAction)gorselRadioOnTap:(id)sender {
    
    if(gorselEnabled == YES)
    {
        gorselEnabled = NO;
    }
    else
    {
        gorselEnabled = YES;
    }
    
    [self updateViewStudentArea];
    
}

- (IBAction)sesTuruMaleOnTap:(id)sender {
    
    typeSesTuruOnSelect = kKategoriEkleViewSesTuruMale;
    [self radioSesTuruOnSelect:typeSesTuruOnSelect];
}

- (IBAction)sesTuruFemaleOnTap:(id)sender {
    
    typeSesTuruOnSelect = kKategoriEkleViewSesTuruFemale;
    [self radioSesTuruOnSelect:typeSesTuruOnSelect];
}


// For recording
- (IBAction)btnRecordingStopOnTap:(id)sender {
    
    if(soundObject.isRecording == YES)
    {
        self.imViewRecord.highlighted = NO;
        
        [soundObject stopRecording];
    }
    else if(soundObject.isRecording == NO)
    {
        self.imViewRecord.highlighted = YES;
        
        // kayıt adresi
        
        NSString *dcPath = [NSString devicePathWithDocumentFolderName:@"Sounds"];
        if(![dcPath fileExistAtDevicePath])
        {
            [dcPath createFolder:@"Sounds"];
        }
        
        BOOL isFemaleSesTuru = NO;
        
        
        if(typeSesTuruOnSelect == kKategoriEkleViewSesTuruFemale)
        {
            isFemaleSesTuru = YES;
        }
        
        
        if(self.typeAreaScreen == kKategoriEkleScreenAreaArsiv)
        {
            Kategori *kt = [[Kategori alloc] init];
            int newID = [kt newIDForTable];
            kt = [[Kategori alloc ] initWithID:newID];
            
            outputFileName_Male = [kt getSoundFullPath:kKategoriSesTuruTypeMale];
            
            if(isFemaleSesTuru == YES)
            {
                 outputFileName_Female = [kt getSoundFullPath:kKategoriSesTuruTypeFemale];
            }
            
        }
        else if(self.typeAreaScreen == kKategoriEkleScreenAreaFromStudentPage)
        {
            KategoriStudent *st = [[KategoriStudent alloc] init];
            int newID = [st newIDForTable];
            st = [[KategoriStudent alloc] initWithID:newID];
            
           // st.kategoriID = self.kategoriIDCurrent;
            st.studentID = self.studentIDCurrent;
            
            outputFileName_Male = [st getSoundFullPath:kKategoriStudentSesTuruTypeMale];
            
            if(isFemaleSesTuru == YES)
            {
                 outputFileName_Female = [st getSoundFullPath:kKategoriStudentSesTuruTypeFemale];
            }
        }
        
        NSString *outputFileName;
        
        if(self.selectedKategoriObject != nil)
        {
            outputFileName = [self.selectedKategoriObject getSoundFullPath:kKategoriSesTuruTypeMale];
            if(isFemaleSesTuru == YES)
            {
                 outputFileName = [self.selectedKategoriObject getSoundFullPath:kKategoriSesTuruTypeFemale];
            }
        }
        if(self.selectedKategoriStudentObject != nil)
        {
            outputFileName = [self.selectedKategoriStudentObject getSoundFullPath:kKategoriStudentSesTuruTypeMale];
            
            if(isFemaleSesTuru ==  YES)
            {
                 outputFileName = [self.selectedKategoriStudentObject getSoundFullPath:kKategoriStudentSesTuruTypeFemale];
            }
        }
        
        NSString *outputFilePath ;
        if(outputFileName != nil)
        {
            outputFilePath = outputFileName;
        }
        else
        {
            if(isFemaleSesTuru == YES)
            {
                outputFilePath = outputFileName_Female;
            }
            else
            {
                outputFilePath = outputFileName_Male;
            }
        }
        
        
        // record the sound
        
        [soundObject recordSound:outputFilePath duration:30 success:^(NSString *outputPath, float currentTime, float duration, BOOL didFinished, BOOL didPaused) {
            
            //NSLog(@"current Time : %f , max Duration :%f" , currentTime , duration);
            
            NSString *strSeconds = [NSString stringWithFormat:@"%0.0f" , currentTime ];
            
            if(currentTime < 10)
            {
                strSeconds = [NSString stringWithFormat:@"0%0.0f" , currentTime ];
            }
            
            NSString *currTimeStr = [NSString stringWithFormat:@"00:%@" , strSeconds];

            self.lblRecordingSeconds.text= currTimeStr;
            
            
        } failure:^(NSError *error, NSString *outputPath) {
            
            //NSLog(@"erorr : %@" , error);
            
        }];

        
        
    }
    
    
    
}


#pragma mark SOUND





#pragma mark TextField 

-(IBAction)tfYaziEkleValueOnChange:(id)sender
{
    NSString *text = self.tfYaziEkle.text ;
    self.lblPicture.text = text;
    
    [self updateNewSizeForLabel];
    
   
    
    
    
}

-(void)updateNewSizeForLabel
{
   
    if(fontNameCurrent.length == 0)
    {
         fontNameCurrent = @"HelveticaNeue-Light";
    }
    
    CGPoint oldCenter = self.lblPicture.center;
    self.lblPicture.numberOfLines = 0;
    
   // //NSLog(@"current Punto  : %f" , currentPunto);
   // //NSLog(@"current Font : %@" , fontNameCurrent);
    self.lblPicture.font = [UIFont fontWithName:fontNameCurrent size:currentPunto];
    
    CGSize theSize = [self.tfYaziEkle.text sizeWithAttributes:
                      @{NSFontAttributeName:
                            [UIFont fontWithName:fontNameCurrent size:currentPunto] }];
    
    CGRect newRect = CGRectMake(oldCenter.x-theSize.width/2, oldCenter.y-theSize.height/2, theSize.width, theSize.height);
    
    self.lblPicture.frame = newRect;
    
    [self updatePictureViewAndLabelFrames];
    
   
    
}




- (IBAction)colorYaziRengiOnChange:(id)sender {
    
  //  //NSLog(@"yazi changed");
    
    float red = [self.tfRedColor.text floatValue];
    float blue = [self.tfBlueColor.text floatValue];
    float green = [self.tfGreenColor.text floatValue];
    
    UIColor *theColor = [UIColor colorWithR:red G:green B:blue A:1];
    self.lblPicture.textColor = theColor;
    
}

- (IBAction)colorArkaPlanOnChange:(id)sender {
    
    float red = [self.tfRedColorArkaPlan.text floatValue];
    float blue = [self.tfBlueColorArkaPlan.text floatValue];
    float green = [self.tfGreenColorArkaPlan.text floatValue];
    
    UIColor *theColor = [UIColor colorWithR:red G:green B:blue A:1];
    self.viewImagePictureArea.backgroundColor = theColor;
    
}

- (IBAction)silBtnOnTap:(id)sender
{
    
    NSString *message = @"Sembol silinecektir. Emin misiniz ?";
    
    if(self.typeScreen == kKategoriEkleScreenTypeResimEkle)
    {
        message = @"Sembol silinecektir. Emin misiniz ?";
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Derya Hoca" message:message delegate:self cancelButtonTitle:@"Hayır" otherButtonTitles:@"Evet", nil];
    alert.tag = 1003;
    [alert show];
    
}


#pragma mark Radio Buttons 

-(void)radioSesTuruOnSelect:(KategoriEkleViewSesTuru) typeSesTuru
{
    self.viewSesTuruRadioFemale.backgroundColor = [UIColor colorWithR:255 G:255 B:255 A:1];
    self.viewSesTuruRadioMale.backgroundColor = [UIColor colorWithR:255 G:255 B:255 A:1];
    
    for(id vv in self.viewSesTuruRadioFemale.subviews)
    {
        if([vv isKindOfClass:[UIImageView class]])
        {
            [(UIImageView *)vv removeFromSuperview];
        }
    }
    
    for(id vv in self.viewSesTuruRadioMale.subviews)
    {
        if([vv isKindOfClass:[UIImageView class]])
        {
            [(UIImageView *)vv removeFromSuperview];
        }
    }
    
    
    // 2, 134 ,148
    if(typeSesTuru == kKategoriEkleViewSesTuruFemale)
    {
          //self.viewSesTuruRadioFemale.backgroundColor = [UIColor colorWithR:2 G:134 B:148 A:1];
        
        UIImageView *imView = [[UIImageView alloc] init];
        imView.frame = CGRectMake(0, 0, self.viewSesTuruRadioMale.frame.size.width, self.viewSesTuruRadioMale.frame.size.height);
        UIImage *theImage = [UIImage imageNamed:@"tickIcon.png"];
        imView.image = theImage;
        [self.viewSesTuruRadioFemale addSubview:imView];
    }
    else if(typeSesTuru == kKategoriEkleViewSesTuruMale)
    {
        //self.viewSesTuruRadioMale.backgroundColor = [UIColor colorWithR:2 G:134 B:148 A:1];
        
        UIImageView *imView = [[UIImageView alloc] init];
        imView.frame = CGRectMake(0, 0, self.viewSesTuruRadioMale.frame.size.width, self.viewSesTuruRadioMale.frame.size.height);
        UIImage *theImage = [UIImage imageNamed:@"tickIcon.png"];
        imView.image = theImage;
        [self.viewSesTuruRadioMale addSubview:imView];
    }
    
    
    typeSesTuruOnSelect = typeSesTuru;
}


-(void)updateViewStudentArea
{
    self.viewYaziSelectionRadio.backgroundColor = [UIColor colorWithR:255 G:255 B:255 A:1];
    self.viewSesSelectionRadio.backgroundColor = [UIColor colorWithR:255 G:255 B:255 A:1];
    self.viewGorselSelectionRadio.backgroundColor = [UIColor colorWithR:255 G:255 B:255 A:1];
    
    self.imViewGorsel.alpha = 0;
    self.imViewSes.alpha = 0;
    self.imViewYazi.alpha = 0;
    
    
    if(gorselEnabled == YES)
    {
         // self.viewGorselSelectionRadio.backgroundColor = [UIColor colorWithR:2 G:134 B:148 A:1];
        self.imViewGorsel.alpha = 1;
         self.imViewPicture.alpha = 1;
    }
    else
    {
        self.imViewPicture.alpha = 0;
    }
    
    if(sesEnabled == YES)
    {
        // self.viewSesSelectionRadio.backgroundColor = [UIColor colorWithR:2 G:134 B:148 A:1];
        
        self.imViewSes.alpha = 1;
    }
    else
    {
        
    }
    
    if(yaziEnabled == YES)
    {
       //  self.viewYaziSelectionRadio.backgroundColor = [UIColor colorWithR:2 G:134 B:148 A:1];
        self.imViewYazi.alpha = 1;
        self.lblPicture.alpha = 1;
    }
    else
    {
        self.lblPicture.alpha = 0;
    }
    
    
}



#pragma mark Slider Value Change 

-(IBAction)puntoSliderValueChanged:(id)sender
{
    float value = self.sliderPunto.value;
    
    self.lblCurrentPunto.text = [NSString stringWithFormat:@"%0.0f px" , value];
    self.lblPicture.font = [UIFont fontWithName:self.lblPicture.font.fontName size:value];
    
    currentPunto = value;
    
    [self updateNewSizeForLabel];
}

- (IBAction)btnYaziTipiOnTap:(id)sender {
    
    if(imageSelectedMain != nil)
    {
        viewFontSelector.imViewImage.image = imageSelectedMain;
        
    }
    
    [self.view bringSubviewToFront:viewFontSelector];
    
    viewFontSelector.lblMainText.text = self.lblPicture.text;
    
    
    [viewFontSelector showFromPoint:self.view.center];
}


#pragma mark FontSelectorView Delegate 

-(void)fontSelectorTableWillOpen:(FontSelectorTable *)tableFontSelector
{
    UIImage *screenShot = [self.view screenShot];
    UIImage *blurScreen = [screenShot applyBlurWithRadius:10 tintColor:[UIColor clearColor] saturationDeltaFactor:0.9 maskImage:nil];
    
    blurImView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, blurScreen.size.width, blurScreen.size.height)];
    blurImView.image = blurScreen;
    blurImView.userInteractionEnabled = YES;
    [self.view addSubview:blurImView];
    
    UITapGestureRecognizer *recTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(blurImViewOnTap)];
    recTap.numberOfTapsRequired = 1;
    recTap.numberOfTouchesRequired = 1;
    [blurImView addGestureRecognizer:recTap];
    
    [self.view bringSubviewToFront:viewFontSelector];
}

-(void)fontSelectorTableDidClosed:(FontSelectorTable *)tableFontSelector
{
        fontNameCurrent= tableFontSelector.currentFontName;
    self.lblFontNameSelected.text = fontNameCurrent;
    
    self.lblPicture.font = [UIFont fontWithName:fontNameCurrent size:currentPunto];
    
      [blurImView removeFromSuperview];
    
      [self updateNewSizeForLabel];
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    ////NSLog(@"yaziRengi Btn : %@ ", NSStringFromCGRect(self.btnYaziRengi.frame));
}


- (IBAction)btnYaziRengiSecOnTap:(id)sender {
    
    viewColorChoose.typeScreen = kColorChooseViewTypeYaziRengi;
    
    float yOffset =  self.scrollForm.frame.origin.y - self.scrollForm.contentOffset.y;
    CGPoint ptCenter =CGPointMake(self.btnYaziRengi.center.x, yOffset + self.btnYaziRengi.center.y ) ;
    
    [viewColorChoose openFromPoint:ptCenter];
    
    
    
    
}

- (IBAction)btnArkaPlanResmiSecOnTap:(id)sender {
    
    viewColorChoose.typeScreen = kColorChooseViewTypeArkaPlanRengi;
    
    float yOffset =  self.scrollForm.frame.origin.y - self.scrollForm.contentOffset.y;
    CGPoint ptCenter =CGPointMake(self.btnArkaPlanRengi.center.x, yOffset + self.btnArkaPlanRengi.center.y ) ;
    
    [viewColorChoose openFromPoint:ptCenter];
}


#pragma mark ColorChoose View Delegate 

-(void)colorChooseViewWillOpen:(ColorChooseView *)colorChooseView
{
    UIImage *screenShot = [self.view screenShot];
    UIImage *blurScreen = [screenShot applyBlurWithRadius:10 tintColor:[UIColor clearColor] saturationDeltaFactor:0.9 maskImage:nil];
    
    blurImView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, blurScreen.size.width, blurScreen.size.height)];
    blurImView.image = blurScreen;
    blurImView.userInteractionEnabled = YES;
    [self.view addSubview:blurImView];
    
    UITapGestureRecognizer *recTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(blurImViewOnTap)];
    recTap.numberOfTapsRequired = 1;
    recTap.numberOfTouchesRequired = 1;
    [blurImView addGestureRecognizer:recTap];
    
    [self.view bringSubviewToFront:viewColorChoose];
}

-(void)colorChooseViewDidClosed:(ColorChooseView *)colorChooseView
{
    [blurImView removeFromSuperview];
}


-(void)colorChooseView:(ColorChooseView *)colorChooseView didChangedColorRed:(float)red green:(float)green blue:(float)blue
{
    ////NSLog(@"color Wheel : %f , %f , %f" , red , green , blue);
    
    
    
    if(colorChooseView.typeScreen == kColorChooseViewTypeArkaPlanRengi)
    {
        self.tfRedColorArkaPlan.text = [NSString stringWithFormat:@"%0.0f", red];
         self.tfGreenColorArkaPlan.text = [NSString stringWithFormat:@"%0.0f", green];
         self.tfBlueColorArkaPlan.text = [NSString stringWithFormat:@"%0.0f", blue];
        
         self.viewImagePictureArea.backgroundColor = [UIColor colorWithR:red G:green B:blue A:1];
    }
    else if(colorChooseView.typeScreen == kColorChooseViewTypeYaziRengi)
    {
        self.tfRedColor.text = [NSString stringWithFormat:@"%0.0f", red];
        self.tfGreenColor.text = [NSString stringWithFormat:@"%0.0f", green];
        self.tfBlueColor.text = [NSString stringWithFormat:@"%0.0f", blue];
        
        self.lblPicture.textColor = [UIColor colorWithR:red G:green B:blue A:1];
        
    }
    
    
}



-(void)blurImViewOnTap
{
    [viewColorChoose close];
    [viewFontSelector hide];
}


#pragma mark ADD IMAGE 

-(void)imageViewMainOnTap
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Derya Hoca" message:@"" delegate:self cancelButtonTitle:@"İptal" otherButtonTitles:@"Albümden seç",@"Resim Çek",@"Resmi Sil", nil];
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
        else if(buttonIndex == 3)
        {
            imageSelectedMain = nil;
            self.imViewPicture.image = nil;
            
        }
    }
    else if(alertView.tag == 1002)
    {
        [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
    else if(alertView.tag == 1003)
    {
        // sil
        [self.selectedKategoriObject removeModel];
        
        [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
            
        }];
        
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
    imageSelectedMain = info[@"UIImagePickerControllerOriginalImage"];
    
    self.imViewPicture.image = imageSelectedMain;
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}


/*
-(void)pinchOnImageView:(UIPinchGestureRecognizer *)recognizer
{
    //return;
    
    if(self.typeAreaScreen == kKategoriEkleScreenAreaArsiv)
    {
        return;
    }
    
    
    CGRect currFrame = recognizer.view.frame;
    
    
    if(currFrame.origin.x < 0  || currFrame.origin.y < 0 || currFrame.size.width > self.viewImagePictureArea.frame.size.width || currFrame.size.height > self.viewImagePictureArea.frame.size.height)
    {
        
        self.imViewPicture.alpha = 0.5;
    
    }
    else
    {
        self.imViewPicture.alpha = 1;
        
    
    }
    
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
   
    recognizer.scale = 1;
    
    ////NSLog(@"current Frame : %@" , NSStringFromCGRect(recognizer.view.frame));
    
    ////NSLog(@"image Scale : %f"  , imageScale);
    
 
}
*/


-(void)imageViewPictureOnPan:(UIPanGestureRecognizer *)recognizer
{
    if(self.panEnabled == NO)
    {
        return;
    }
    
    CGPoint translation = [recognizer translationInView:self.viewImagePictureArea];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.viewImagePictureArea];
    
    [self updatePictureViewAndLabelFrames];
}

-(void)lblPictureOnPan:(UIPanGestureRecognizer *)recognizer
{
    if(self.panEnabled == NO)
    {
        return;
    }
    
    [self.viewImagePictureArea bringSubviewToFront:self.lblPicture];
    
    CGPoint translation = [recognizer translationInView:self.viewImagePictureArea];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.viewImagePictureArea];
    
    [self updatePictureViewAndLabelFrames];
}

-(void)imageViewPictureOnPinch:(UIPinchGestureRecognizer *)recognizer
{
    if(self.pinchEnabled == NO)
    {
        return;
    }
    
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
    
    recognizer.scale = 1;
    
    //NSLog(@"new Frame : %@" , NSStringFromCGRect(recognizer.view.frame));
    
    [self updatePictureViewAndLabelFrames];
    
    
    
}

-(void)lblPictureOnPinch:(UIPinchGestureRecognizer *)recPinch
{
    if(self.pinchEnabled == NO)
    {
        return;
    }
    
    
    [self updatePictureViewAndLabelFrames];
    
}



-(void)updatePictureViewAndLabelFrames
{
    CGRect currFrameImView = self.imViewPicture.frame;
    
    if(currFrameImView.origin.x < 0)
    {
        currFrameImView.origin.x = 0;
       // self.imViewPicture.frame = currFrameImView;
    }
    
    if(currFrameImView.origin.y < 0)
    {
         currFrameImView.origin.y = 0;
    }
    
    
    if(currFrameImView.origin.y + currFrameImView.size.height > self.viewImagePictureArea.frame.size.height)
    {
        currFrameImView.size.height = self.viewImagePictureArea.frame.size.height - currFrameImView.origin.y;
    }
    
    
    if(currFrameImView.origin.x + currFrameImView.size.width > self.viewImagePictureArea.frame.size.width)
    {
         currFrameImView.size.width = self.viewImagePictureArea.frame.size.width - currFrameImView.origin.x;
    }
    
    
    self.imViewPicture.frame = currFrameImView;
    
    // label update
    
    CGRect currFrameLabel = self.lblPicture.frame;
    
    if(currFrameLabel.origin.x < 0)
    {
        currFrameLabel.origin.x = 0;
    }
    
    if(currFrameLabel.origin.y < 0)
    {
        currFrameLabel.origin.y = 0;
    }
    
    if(currFrameLabel.size.width + currFrameLabel.origin.x > self.viewImagePictureArea.frame.size.width)
    {
        currFrameLabel.size.width = self.viewImagePictureArea.frame.size.width-currFrameLabel.origin.x;
    }
    
    
    if(currFrameLabel.size.height + currFrameLabel.origin.y > self.viewImagePictureArea.frame.size.height)
    {
        currFrameLabel.size.height = self.viewImagePictureArea.frame.size.height-currFrameLabel.origin.y;
    }
    
    
    self.lblPicture.frame = currFrameLabel;
    
    
}



+(CGSize ) sizeOfViewPictureArea
{
    return CGSizeMake(350, 350);
}


+(CGSize) sizeOfImageViewPicture
{
    return CGSizeMake(262, 262);
}





@end

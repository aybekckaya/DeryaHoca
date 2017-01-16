//
//  ArsivVC.m
//  DeryaHoca
//
//  Created by aybek can kaya on 27/11/15.
//  Copyright © 2015 aybek can kaya. All rights reserved.
//

#import "ArsivVC.h"

@interface ArsivVC ()

@end

@implementation ArsivVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    currentSelectedParentCategoryID = -1;
   // kategoriIDsOnBottomBar = [[NSMutableArray alloc] init];
    //[kategoriIDsOnBottomBar addObject:@(-1)];
    
    [self guiUpdate];
}



-(void)viewWillDisappear:(BOOL)animated
{
    if(comeFromKategoriEkleInner == YES)
    {
        [barBottom setStackObjects:stackCurrentBarBottom];
    }
    else
    {
          [barBottom setStackObjects:stackOldBarBottom];
    }
    
    comeFromKategoriEkleInner = NO;
  
    
}

-(void)guiUpdate
{

    // bottom bar
    
    barBottom = [Story GetViewFromNibByName:@"BottomBar"];
    barBottom.tapEnabled = YES;
    CGRect currFrame = barBottom.frame ;
    currFrame.origin.y = self.view.frame.size.height - currFrame.size.height;
    barBottom.delegateBarBottom = self;
    barBottom.frame = currFrame;
    barBottom.typePage = kBottomBarPageTypeArsiv;
    
    [self.view addSubview:barBottom];
    
    
    
    
    // safe removal
    [barBottom popAllElementsInStack];
    
    
    UIImage *theImage = [UIImage imageNamed:@"anasayfaIcon.png"];
    UIImageView *imView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 72, 72)];
    imView.image = theImage;
    
   // [barBottom pushUIImageView:imView];
    
    BottomBarObject *object = [[BottomBarObject alloc] init];
    object.viewObject = imView;
    object.userInfo =@{USER_INFO_ID : @(-1)};
    
    [barBottom pushObject:object];
    
    
    BottomBarStackController *controller = [BottomBarStackController shared];
    stackOldBarBottom = controller.stack;
    
    
    if(self.typePage == kArsivVCPageTypeFromAyarlar)
    {
        self.btnHomepage.alpha = 0;
        self.imViewHomePage.alpha = 0;
    }
    else if(self.typePage == kArsivVCPageTypeDefault)
    {
        self.btnKapat.alpha = 0;
    }
    

}




-(void)viewDidDisappear:(BOOL)animated
{
   // [barBottom removeFromSuperview];
    
 
}



-(void)viewDidAppear:(BOOL)animated
{
    // get All Kategoriler
    
  //  NSArray *allKategori = [Kategori getAllItems];
    
    self.scrollCategory.datasourceScroll = self;
    self.scrollCategory.delegateScroll = self;
    
    [self loadCategoryScroll];
    
    BottomBarStackController *controller = [BottomBarStackController shared];
    [barBottom setStackObjects:controller.stack];
    
    // page control
    self.pageControl.numberOfPages = self.scrollCategory.maxPage;
    self.pageControl.currentPage = 0;
    
}


-(void)categoryScroll:(CategoryScroll *)categoryScroll currentPageDidChanged:(int)pageCurrent maxPages:(int)maxPages
{
    self.pageControl.currentPage = pageCurrent;
}


-(void)loadCategoryScroll
{
    
    self.btnKategoriEkle.enabled = NO;
    self.btnResimEkle.enabled = NO;
    self.lblKategoriEkle.alpha = 0.3;
    self.lblResimEkle.alpha = 0.3;
    
    // NSArray *allKategori = [Kategori getAllItems];
    
     //NSArray *tempKategoriObjects = [Kategori kategoriDctsArrByParentID:currentSelectedParentCategoryID];
    
    NSArray *tempKategoriObjects;
    
    if(self.typeFilter == kArsivVCFilterNone)
    {
        tempKategoriObjects = [Kategori kategoriDctsArrByParentID:currentSelectedParentCategoryID filter:kKategoriTypeNone];
    }
    else if(self.typeFilter == kArsivVCFilterKategori)
    {
         tempKategoriObjects = [Kategori kategoriDctsArrByParentID:currentSelectedParentCategoryID filter:kKategoriTypeKategori];
    }
    else if(self.typeFilter == kArsivVCFilterResim)
    {
         tempKategoriObjects = [Kategori kategoriDctsArrByParentID:currentSelectedParentCategoryID filter:kKategoriTypeResim];
    }
        
    
    kategoriIDsArrAddedToStudent = [[NSArray alloc] init];
    
    if(self.typePage == kArsivVCPageTypeFromAyarlar)
    {
        User *theUser = [User currentUser];
        kategoriIDsArrAddedToStudent = [KategoriStudent kategoriIDsArrByStudentID:theUser.ID];
    }
    
    //NSArray *kategoriArrCurrentlyAddedToStudent =
    
    
    kategoriObjectsArr = [[NSMutableArray alloc] init];
    
    for(NSDictionary *dct in tempKategoriObjects)
    {
        Kategori *kt = [[Kategori alloc] init];
        [kt setDictionary:dct];
        
        [kategoriObjectsArr addObject:kt];
    }
    
    [self.scrollCategory reloadScroll];
    
    
    // page control
    self.pageControl.numberOfPages = self.scrollCategory.maxPage;
    self.pageControl.currentPage = 0;
    
    
    self.scrollCategory.currentPage = 0;
    
    
    // new bottom BAR
    BottomBarStackController *controller = [BottomBarStackController shared];
    int stackCount = controller.stack.count;
    
    if(stackCount == 1)
    {
        // sadece kategori
        self.btnKategoriEkle.enabled = YES;
        //self.btnResimEkle.enabled = YES;
        self.lblKategoriEkle.alpha = 1;
        //self.lblResimEkle.alpha = 1;
    }
    else if(stackCount == 2)
    {
        // sadece resim
        
       // self.btnKategoriEkle.enabled = YES;
        self.btnResimEkle.enabled = YES;
       // self.lblKategoriEkle.alpha = 1;
        self.lblResimEkle.alpha = 1;
    }
    else
    {
        // hicbirsey
        
    }
    

}




#pragma mark Category Scroll Datasource

-(NSInteger) numberOfItemsInCategoryScroll:(CategoryScroll *)categoryScroll
{
    return kategoriObjectsArr.count;
}

-(UIView *)categoryScroll:(CategoryScroll *)categoryScroll viewAtIndex:(int)index
{
    KategoriView *viewKategori = [Story GetViewFromNibByName:@"KategoriView"];
    viewKategori.delegateKategoriView = self;
    
    Kategori *currentKt = kategoriObjectsArr[index];
    viewKategori.index = index;
    viewKategori.imViewKategori.image = [currentKt getCategoryImage];
    viewKategori.lblKategori.text = currentKt.name;
    
    if(self.typePage == kArsivVCPageTypeDefault)
    {
        [viewKategori.viewRemoveAdd removeFromSuperview];
    }
    
    
    if([kategoriIDsArrAddedToStudent containsObject:@(currentKt.ID)])
    {
        // did added
        viewKategori.stateRemoveAdd =kKategoriViewRemoveAddStateRemoveEnabled;
    }
    else
    {
        // not added yet
        viewKategori.stateRemoveAdd = kKategoriViewRemoveAddStateAddEnabled;
    }
    
    
    // set values of category spec
    
    NSString *fontName = currentKt.fontName;
    int punto = currentKt.puntoLabel;
    
    // label proportions
    CGSize sizeViewPicture = [KategoriEkleVC sizeOfViewPictureArea];
    float ratio = (float) (viewKategori.frame.size.width / sizeViewPicture.width);
   float puntoFL = (float)punto *ratio;
    
    viewKategori.lblKategori.font= [UIFont fontWithName:fontName size:puntoFL];
    UIColor *bgColor = [currentKt.clBgMn colorValueFromComponent];
    viewKategori.backgroundColor = bgColor;
    
    UIColor *yaziColor = [currentKt.clBgYazi colorValueFromComponent];
    viewKategori.lblKategori.textColor = yaziColor;
    
    
    viewKategori.typeScreen = kKategoriViewScreenTypeArsiv;
    
    //viewKategori.stateRemoveAdd = kKategoriViewRemoveAddStateAddEnabled;
    
    viewKategori.backgroundColor = [UIColor clearColor];
    
   // User *theUser = [User currentUser];
   // Settings *st = [[Settings alloc] initWithUserID:theUser.ID];
    
    if(currentKt.yaziEnabled == NO)
    {
        viewKategori.lblKategori.alpha = 0;
    }
    
    if(currentKt.gorselEnabled == NO)
    {
        viewKategori.imViewKategori.alpha = 0;
    }
    
    
    
    return viewKategori;
}

-(CGSize) categoryScroll:(CategoryScroll *)categoryScroll viewSizeAtIndex:(int)index
{
    return [KategoriView sizeCurrentView];
}



#pragma mark BottomBarDelegate

-(void)bottomBar:(BottomBar *)bottomBar didTappedItemAtIndex:(int)index userInfo:(NSDictionary *)userInfo
{
   
    
    if(index == 0)
    {
        // Homepage
        currentSelectedParentCategoryID = [userInfo[USER_INFO_ID] intValue];
        [self loadCategoryScroll];
    }
    else
    {
        // item
          currentSelectedParentCategoryID = [userInfo[USER_INFO_ID] intValue];
        [self loadCategoryScroll];
    }
}


#pragma mark Kategori View Delegate 

-(void)kategoriView:(KategoriView *)kategoriView didTappedAtIndex:(int)theIndex
{
    Kategori *ktSelected = kategoriObjectsArr[theIndex];
    
    if(ktSelected.typeKategori == kKategoriTypeKategori)
    {
        currentSelectedParentCategoryID = ktSelected.ID;
        
        //[barBottom pushText:ktSelected.name];
        
        BottomBarObject *object = [[BottomBarObject alloc]init];
        object.viewObject = ktSelected.name;
        object.userInfo = @{USER_INFO_ID : @(ktSelected.ID)};
        
        [barBottom pushObject:object];
        
        
        [self loadCategoryScroll];
    }
    
   
}


-(void)kategoriView:(KategoriView *)kategoriView didTappedDeleteAtIndex:(int)theIndex
{
    kategoriDctsWillRemove = [[NSMutableArray alloc] init];
    
     Kategori *selectedKategori = kategoriObjectsArr[theIndex];
    
    NSArray *arrDcts = [Kategori allChildrenDictionariesOfKategoriID:selectedKategori.ID];
    
    for(NSDictionary *dct in arrDcts)
    {
        [kategoriDctsWillRemove addObject:dct];
    }
    
    [kategoriDctsWillRemove addObject:[selectedKategori getDictionary]];
    
    NSString *message = [NSString stringWithFormat:@"%lu sembol silinecektir. Emin misiniz ?" , (unsigned long)kategoriDctsWillRemove.count];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Derya Hoca" message:message delegate:self cancelButtonTitle:@"Hayır" otherButtonTitles:@"Evet", nil];
    alert.tag = 1000;
    [alert show];
    
}



-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 1000)
    {
        if(buttonIndex == 1)
        {
            for(NSDictionary *dct in kategoriDctsWillRemove)
            {
                Kategori *kt = [[Kategori alloc] init];
                [kt setDictionary:dct];
                
                [kt removeModel];
            }
            
            currentSelectedParentCategoryID = -1;
            [self loadCategoryScroll];
        }
        else
        {
            kategoriDctsWillRemove = [[NSMutableArray alloc] init];
        }
    }
}

-(void)kategoriView:(KategoriView *)kategoriView didTappedSettingsAtIndex:(int)theIndex
{
    ////NSLog(@"setting");
    
    Kategori *selectedKategori = kategoriObjectsArr[theIndex];
    
    KategoriEkleVC *vc = [Story viewController:@"kategoriEkleVC"];
    vc.typeScreen = kKategoriEkleScreenTypeKategoriEkle;
    if(selectedKategori.typeKategori == kKategoriTypeResim)
    {
        vc.typeScreen = kKategoriEkleScreenTypeResimEkle;
    }
    
    vc.selectedKategoriObject = selectedKategori;
    vc.typeAreaScreen = kKategoriEkleScreenAreaKategoriSelected;
    vc.categoryParentID = selectedKategori.parentID;
    vc.stackBarBottom = barBottom.stackBarBottom;
    
    NavigationController *navCon = [[NavigationController alloc] initWithRootViewController:vc];
    navCon.navigationBarHidden = YES;
    
    [self presentViewController:navCon animated:YES completion:^{
        
    }];
    
}


-(void)kategoriView:(KategoriView *)kategoriView didChangedAddRemoveState:(KategoriViewRemoveAddState)stateNew
{
    
        int index = kategoriView.index;
        
        Kategori *kt = (Kategori *)kategoriObjectsArr[index];
        
        NSDictionary *dct = [kt getDictionary];
        User *theUser = [User currentUser];
        
    
    
    
        if(stateNew == kKategoriViewRemoveAddStateAddEnabled)
        {
            KategoriStudent *st = [KategoriStudent getItemByKategoriID:kt.ID studentID:theUser.ID];
           
            [st removeSounds];
            
            NSArray *arrAllChildrens = [KategoriStudent getAllChildKategoriStudentsByStudentID:theUser.ID parentID:st.ID];
            
            for(NSDictionary *dct in arrAllChildrens)
            {
                KategoriStudent *stChild = [[KategoriStudent alloc] init];
                [stChild setDictionary:dct];
                
                [stChild removeSounds];
                [stChild removeModel];
                
                
            }
            
            [st removeModel];
            
            //NSLog(@"will remove");
        }
        else if(stateNew == kKategoriViewRemoveAddStateRemoveEnabled)
        {
            //NSLog(@"will add");
            
            KategoriStudent *st = [KategoriStudent kategoriStudentObjectFromKategoriDct:dct studentID:theUser.ID];
            st.parentID = self.parentID;
            st.cntPtMn = [NSString stringComponentFromCGPoint:self.emptyCenter];
            
            UIImage *categoryImage = [kt getCategoryImage];
            [st saveCategoryImage:categoryImage];
            
            // save sounds (copy)
            
            NSString *male = [kt getSoundFullPath:kKategoriSesTuruTypeMale];
            NSString *female = [kt getSoundFullPath:kKategoriSesTuruTypeFemale];
            
            [st copySoundsMalePath:male femalePath:female];
            
            
           //NSLog(@"st : %@" , [st getDictionary]);
            [st saveModel];
            
            
            NSArray *childrenKategori = [Kategori allChildrenDictionariesOfKategoriID:kt.ID];
            
            for(NSDictionary *dct in childrenKategori)
            {
                Kategori *ktInner = [[Kategori alloc] init];
                [ktInner setDictionary:dct];
                
                KategoriStudent *stInner = [KategoriStudent kategoriStudentObjectFromKategoriDct:dct studentID:theUser.ID];
                stInner.parentID = st.ID;
                
                
                UIImage *categoryImageInner = [ktInner getCategoryImage];
                [stInner saveCategoryImage:categoryImageInner];
                
                NSString *male = [ktInner getSoundFullPath:kKategoriSesTuruTypeMale];
                NSString *female = [ktInner getSoundFullPath:kKategoriSesTuruTypeFemale];
                
                [stInner copySoundsMalePath:male femalePath:female];
                
                [stInner saveModel];
            }
            
        }

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

- (IBAction)btnKapatOnTap:(id)sender {
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)resimEkleOnTap:(id)sender {
    
    
    KategoriEkleVC *vc = [Story viewController:@"kategoriEkleVC"];
    vc.typeScreen = kKategoriEkleScreenTypeResimEkle;
     vc.categoryParentID = currentSelectedParentCategoryID;
      vc.stackBarBottom = barBottom.stackBarBottom;
    
    comeFromKategoriEkleInner = YES;
    stackCurrentBarBottom = barBottom.stackBarBottom;
    
    NavigationController *navCon = [[NavigationController alloc] initWithRootViewController:vc];
    navCon.navigationBarHidden = YES;
    
    
    [self presentViewController:navCon animated:YES completion:^{
        
    }];
}

- (IBAction)kategoriEkleOnTap:(id)sender {
    
   KategoriEkleVC *vc = [Story viewController:@"kategoriEkleVC"];
    vc.typeScreen = kKategoriEkleScreenTypeKategoriEkle;
    vc.categoryParentID = currentSelectedParentCategoryID;
    vc.stackBarBottom = barBottom.stackBarBottom;
    
    comeFromKategoriEkleInner = YES;
    stackCurrentBarBottom = barBottom.stackBarBottom;
    
    
    NavigationController *navCon = [[NavigationController alloc] initWithRootViewController:vc];
    navCon.navigationBarHidden = YES;
    
    
    [self presentViewController:navCon animated:YES completion:^{
        
    }];

    
}

- (IBAction)homepageOnTap:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end

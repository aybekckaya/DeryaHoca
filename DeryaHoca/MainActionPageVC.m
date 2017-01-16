//
//  MainActionPageVC.m
//  DeryaHoca
//
//  Created by aybek can kaya on 16/11/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import "MainActionPageVC.h"

@interface MainActionPageVC ()

@end

@implementation MainActionPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[KategoriStudent removeAllItems]; // TEST
    
   // self.scrollCategory.backgroundColor = [UIColor redColor];
    
    soundObject = [[Sound alloc] init];
    
    [self updateGUI];
    [self refreshGUIWithCurrentSettings];
    
    currentSelectedParentID = -1; // Default is all Category
    
    // Test space
   //[self bottomBarVisualTest];
    
    
    // Debug
    //NSArray *allItems = [KategoriStudent getAllItems];
   // //NSLog(@"all Items : %@" , allItems);
    
}


-(void)viewDidAppear:(BOOL)animated
{
    
    // Debug
    //NSArray *allItems = [KategoriStudent getAllItems];
    // //NSLog(@"all Items : %@" , allItems);
    
    ////NSLog(@"parent ID : %d" , currentSelectedParentID);
    [self loadCategoryScrollWithSelectedParentID:currentSelectedParentID];
    
    BottomBarStackController *controller = [BottomBarStackController shared];
    
    [barBottom setStackObjects:controller.stack];
    
    
    // Arsivden ekle alanı icin
    float scrollContentOffsetX = self.scrollCategory.contentOffset.x;
    int currPage = scrollContentOffsetX / self.scrollCategory.frame.size.width;
    
   // //NSLog(@"current Page New : %d" , currPage);
    
    self.scrollCategory.currentPage = currPage;
    
}





#pragma mark Visual Test 

-(void)bottomBarVisualTest
{
    UIImage *theImage = [UIImage imageNamed:@"anasayfaIcon.png"];
    UIImageView *imView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 72, 72)];
    imView.image = theImage;
    
  //  [barBottom pushUIImageView:imView];
    
   // [barBottom pushText:@"Aybek Can Kaya"];
    
    //[barBottom pushText:@"Selam "];
    
    //[barBottom pushText:@"Elmalar Armutlar"];
}


-(void)updateGUI
{
    self.scrollCategory.delegateScroll = self;
    self.scrollCategory.datasourceScroll = self;
    self.scrollCategory.typeScroll = kCategoryScrollTypeStudentPage;
    
    User *theUser = [User currentUser];
    //NSLog(@"%@" , [theUser getDictionary]);
    
    if(self.typePage == kMainActionPageTypeTeacher)
    {
        navbarTeacher = [Story GetViewFromNibByName:@"TeacherNavBar"];
        navbarTeacher.delegateNavbar = self;
        navbarTeacher.lblStudentName.text = theUser.name;
    
        [self.view addSubview:navbarTeacher];
        
       
    }
    else if(self.typePage == kMainActionPageTypeStudent)
    {
        navbarStudent = [Story GetViewFromNibByName:@"StudentNavBar"];
        navbarStudent.delegateNavBar = self;
        navbarStudent.datasourceNavBar = self;
        
        [self.view addSubview:navbarStudent];
        
        Settings *st = [[Settings alloc] initWithUserID:theUser.ID];
        if(st.cumleSeridiEnabled == NO)
        {
            navbarStudent.imViewCancel.alpha = 0;
            navbarStudent.imViewVoice.alpha = 0;
            navbarStudent.btnCancel.alpha = 0;
            navbarStudent.btnVoice.alpha = 0;
        }
        
    }
    
    
    
    
    
    
    // bottom bar
    
    barBottom = [Story GetViewFromNibByName:@"BottomBar"];
    CGRect currFrame = barBottom.frame ;
    currFrame.origin.y = self.view.frame.size.height - currFrame.size.height;
    barBottom.delegateBarBottom = self;
    barBottom.datasourceBottomBar = self;
    
 
    Settings *st = [[Settings alloc] initWithUserID:theUser.ID];
    CGRect frame = [st.frameStringBottomBar frameValueFromComponent];
    
    if(frame.size.height == 0 && frame.origin.y == 0)
    {
        // frame did not changed Yet
         barBottom.frame = currFrame;
    }
    else if(self.typePage == kMainActionPageTypeTeacher)
    {
         barBottom.frame = currFrame;
    }
    
    // student NavBar Frame
    
    frame = [st.frameStringStudentNavBar frameValueFromComponent];
    
    if(frame.size.width != 0 && self.typePage == kMainActionPageTypeStudent)
    {
        navbarStudent.frame = frame;
    }

    [navbarStudent updateApperiance];
    
    // update Scroll Frame and Page Control Frame
    
    CGRect frScroll = [st.frameStringCategoryScroll frameValueFromComponent];
    CGRect frPageControl = [st.frameStringPageControl frameValueFromComponent];
    
    
    if(self.typePage == kMainActionPageTypeStudent)
    {
        if(frScroll.origin.y != 0 && frScroll.size.height != 0)
        {
            self.scrollCategory.frame = frScroll;
        }
        
        if(frPageControl.origin.y != 0 && frPageControl.size.height != 0)
        {
            self.pageControl.frame = frPageControl;
        }

    }
    
    
    
    if(self.typePage == kMainActionPageTypeTeacher)
    {
        barBottom.tapEnabled = YES;
        barBottom.typePage = kBottomBarPageTypeTeacher;
        barBottom.plusSignEnabled = YES;
        barBottom.minusSignEnabled = YES;
        
        barBottom.panEnabled = NO;
    }
    else if(self.typePage == kMainActionPageTypeStudent)
    {
        barBottom.tapEnabled = YES;
        barBottom.typePage = kBottomBarPageTypeStudent;
        barBottom.plusSignEnabled = NO;
        barBottom.minusSignEnabled = NO;
        
        barBottom.btnMinus.alpha = 0;
        barBottom.btnPlus.alpha = 0;
        barBottom.imViewMinus.alpha = 0;
        barBottom.imViewPlus.alpha = 0;
        
        barBottom.stateLock = kBottomBarLockStateUnLocked;
        barBottom.panEnabled = YES;
        
    }
    
    [barBottom updateApperiance];
    
    [self.view addSubview:barBottom];
    
    // safe removal
    [barBottom popAllElementsInStack];
   
    // bottom Bar Init Object push
    UIImage *theImage = [UIImage imageNamed:@"anasayfaIcon.png"];
    UIImageView *imView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 72, 72)];
    imView.image = theImage;
    
    BottomBarObject *object = [[BottomBarObject alloc] init];
    object.viewObject = imView;
    object.userInfo =@{USER_INFO_ID : @(-1) , USER_INFO_SCROLL_CURRENT_PAGE :@(0) };
    
    [barBottom pushObject:object];

    
}


/*
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    return YES;
}

*/



-(void)refreshGUIWithCurrentSettings
{
    if(self.typePage == kMainActionPageTypeStudent)
    {
       
        
        User *theUser = [User currentUser];
        Settings *st = [[Settings alloc] initWithUserID:theUser.ID];
        
        if(st.cumleSeridiEnabled == NO)
        {
            navbarStudent.viewCumleSeridi.alpha = 0;
            
        }
        
        if(st.cumleSeridiSilmeTusuEnabled == NO)
        {
            navbarStudent.imViewCancel.alpha = 0;
            navbarStudent.btnCancel.alpha = 0;
        }
        
    }
}


#pragma mark CATEGORY SCROLL 

-(void)loadCategoryScrollWithSelectedParentID:(int)parentID
{
    User *theUser = [User currentUser];
    int userID = theUser.ID;
    
    
    //NSArray *allObjects = [KategoriStudent getAllItems];
    
    NSArray *tempKategoriObjects = [KategoriStudent getKategoriStudentDictionariesByStudentID:userID parentID:parentID];
    
    arrCategoryObjects = [[NSMutableArray alloc] init];
    
    for(NSDictionary *dct in tempKategoriObjects)
    {
        KategoriStudent *stKategori = [[KategoriStudent alloc] init];
        
        //NSLog(@"kategori frame rate : %f" , stKategori.scMn);
        
        [stKategori setDictionary:dct];
        
        [arrCategoryObjects addObject:stKategori];
    }
    
    // Resim Ekle / Kategori ekle availability
    
    navbarTeacher.lblKategoriEkle.alpha = 1;
    navbarTeacher.lblResimEkle.alpha = 1;
    navbarTeacher.btnKategoriEkle.enabled = YES;
    navbarTeacher.btnResimEkle.enabled = YES;
    
    if(arrCategoryObjects.count > 0)
    {
        KategoriStudent *stTemp = arrCategoryObjects[0];
        if(stTemp.typeKategori == kKategoriTypeKategoriStudent)
        {
            navbarTeacher.lblKategoriEkle.alpha = 1;
            navbarTeacher.lblResimEkle.alpha = 0.3;
            navbarTeacher.btnKategoriEkle.enabled = YES;
            navbarTeacher.btnResimEkle.enabled = NO;
        }
        else if(stTemp.typeKategori == kKategoriTypeResimStudent)
        {
            navbarTeacher.lblKategoriEkle.alpha = 0.3;
            navbarTeacher.lblResimEkle.alpha = 1;
            navbarTeacher.btnKategoriEkle.enabled = NO;
            navbarTeacher.btnResimEkle.enabled = YES;
        }
    }
    
    
    
    // load scroll
    [self.scrollCategory reloadScroll];
    
    int numPages = self.scrollCategory.maxPage;
    
    self.pageControl.numberOfPages = numPages;
    self.pageControl.currentPage = 0;
    
}


-(NSInteger) numberOfItemsInCategoryScroll:(CategoryScroll *)categoryScroll
{
    return arrCategoryObjects.count;
}

-(UIView *)categoryScroll:(CategoryScroll *)categoryScroll viewAtIndex:(int)index
{
    
    
    KategoriStudent *currCategory = arrCategoryObjects[index];
    
    KategoriView *view = [Story GetViewFromNibByName:@"KategoriView"];
    view.delegateKategoriView = self;
    view.imViewKategori.image = [currCategory getCategoryImage];
    view.lblKategori.text = currCategory.name;
    
    view.viewMainArea.backgroundColor = [currCategory.clBgMn colorValueFromComponent];
    view.lblKategori.textColor = [currCategory.clBgYazi colorValueFromComponent];
    
    CGSize currSize = [KategoriEkleVC sizeOfViewPictureArea];
    CGSize viewSizeInner = [KategoriView sizeCurrentView];
   
    float rate = (float) viewSizeInner.height / currSize.height;
    
   // view.transform = CGAffineTransformMakeScale(rate, rate);
    
    CGRect lblFrame = [currCategory.frLbl frameValueFromComponent];
    lblFrame.origin.x  = lblFrame.origin.x * rate;
    lblFrame.origin.y = lblFrame.origin.y * rate;
    lblFrame.size.height = lblFrame.size.height * rate;
    lblFrame.size.width = lblFrame.size.width * rate;
    
    view.lblKategori.frame = lblFrame;
    
    
    CGPoint centerImView = [currCategory.cntPtImView pointValueFromComponent];
    float scaleImView = currCategory.scImView;
    
    centerImView.x = centerImView.x*rate;
    centerImView.y = centerImView.y *rate;
    
    //scaleImView = scaleImView*rate;
    
    
    
    view.imViewKategori.center = centerImView;
    view.imViewKategori.transform = CGAffineTransformMakeScale(scaleImView, scaleImView);
    
    float fontSize = (float) currCategory.puntoLabel*rate;
    
    UIFont *font = [UIFont fontWithName:currCategory.fontName size:fontSize];
    view.lblKategori.font = font;
    
    view.index = index;
    
   
    
    if(currCategory.gorselEnabled == NO)
    {
        view.imViewKategori.alpha = 0;
    }
    
    
    if(currCategory.yaziEnabled == NO)
    {
        view.lblKategori.alpha =0;
    }
    
    
    //view.isSelectedItem = YES;
    
    if(self.typePage == kMainActionPageTypeTeacher)
    {
        view.panEnabled = YES;
        view.pinchEnabled = YES;
        view.panForStudentEnabled = NO;
        
        view.typeScreen = kKategoriViewScreenTypeTeacher;
    }
    else if(self.typePage == kMainActionPageTypeStudent)
    {
        view.panEnabled = NO;
        view.pinchEnabled = NO;
        view.panForStudentEnabled = YES;
        
        User *theUser = [User currentUser];
        Settings *stGeneral = [[Settings alloc] initWithUserID:theUser.ID];
        
        if(stGeneral.cumleSeridiEnabled == NO)
        {
            view.panForStudentEnabled = NO;
        }
        
        
        
        
        view.typeScreen = kKategoriViewScreenTypeStudent;
    }
    
    
  //  UIPanGestureRecognizer *recPan = view.panGesture;
   // [self.scrollCategory.panGestureRecognizer requireGestureRecognizerToFail:recPan];
    
    
   // NSLog(@"view frame : %@", NSStringFromCGRect(view.frame) );
    
    return view;
}



-(float)categoryScroll:(CategoryScroll *)categoryScroll viewScaleAtIndex:(int)index
{
    
    KategoriStudent *st = arrCategoryObjects[index];
    
    NSLog(@"frame rate : %f", st.scMn);
    
    return st.scMn;
}


-(CGPoint ) categoryScroll:(CategoryScroll *)categoryScroll viewCenterAtIndex:(int)index
{
    KategoriStudent *st = arrCategoryObjects[index];
    CGPoint pt = [st.cntPtMn pointValueFromComponent];
    
    return pt;
}

-(void)categoryScroll:(CategoryScroll *)categoryScroll currentPageDidChanged:(int)pageCurrent maxPages:(int)maxPages
{
    self.pageControl.numberOfPages = maxPages;
    self.pageControl.currentPage = pageCurrent;
    
  //  //NSLog(@"page Max : %d" , maxPages);
}




#pragma mark Kategori View Delegate

-(void)kategoriView:(KategoriView *)kategoriView didLongPressAtIndex:(int)theIndex
{
    /*
    CGAffineTransform leftWobble = CGAffineTransformRotate(CGAffineTransformIdentity, RADIANS(-2.0));
    CGAffineTransform rightWobble = CGAffineTransformRotate(CGAffineTransformIdentity, RADIANS(2.0));
    
    kategoriView.transform = leftWobble;  // starting point
    
    
    [UIView animateWithDuration:0.125 delay:0 options:(UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse) animations:^{
        kategoriView.transform = rightWobble;
    }completion:^(BOOL finished){
    }];
*/
    
}

-(void)kategoriView:(KategoriView *)kategoriView didTappedDeleteAtIndex:(int)theIndex
{
    KategoriStudent *st = arrCategoryObjects[theIndex];
    User *theUser = [User currentUser];
    NSArray *arrChildren = [KategoriStudent getAllChildKategoriStudentsByStudentID:theUser.ID parentID:st.ID];
    
    NSMutableArray *arrItems = [[NSMutableArray alloc] initWithArray:arrChildren];
    [arrItems addObject:[st getDictionary]];
    
    itemsReadyToDelete = [[NSArray alloc] initWithArray:arrItems];
    
    NSString *alertText = [NSString stringWithFormat:@"%lu sembol silinecektir. Emin misiniz ? " , arrChildren.count+1 ];
    UIAlertView *alert =  [[UIAlertView alloc] initWithTitle:@"Derya Hoca" message:alertText delegate:self cancelButtonTitle:@"Hayır" otherButtonTitles:@"Evet", nil];
    alert.tag = 1000;
    [alert show];
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 1000)
    {
        if(buttonIndex == 1)
        {
            for(NSDictionary *dct in itemsReadyToDelete)
            {
                KategoriStudent *st = [[KategoriStudent alloc] initWithID:[dct[@"ID"] intValue]];
                
                [st removeModel];
            }
            
            itemsReadyToDelete = [[NSArray alloc]init];
            
            [self loadCategoryScrollWithSelectedParentID:currentSelectedParentID];
        }
    }
    else if(alertView.tag == 2001)
    {
        if(buttonIndex == 1)
        {
            int currPage = self.scrollCategory.currentPage;
            NSMutableArray *arrItemsOnPage = [self.scrollCategory itemsAtPage:currPage];
            [self removeKategoriViewItems:arrItemsOnPage];
            
            // eger sonraki sayfalar var ise viewleri kaydır sola
            int nextPage = currPage + 1;
            int maxPages = self.scrollCategory.maxPage;
            
            float scrollWidth = self.scrollCategory.frame.size.width;
            
            for(int i = nextPage ; i < maxPages ; i++)
            {
                NSMutableArray *arr = [self.scrollCategory itemsAtPage:i];
                
                for(KategoriView *view in arr)
                {
                    int index = view.index ;
                    KategoriStudent *stObject = arrCategoryObjects[index];
                    
                    CGPoint currCenter = [stObject.cntPtMn pointValueFromComponent];
                    currCenter.x = currCenter.x - scrollWidth;
                    
                    stObject.cntPtMn = [NSString stringComponentFromCGPoint:currCenter];
                    [stObject saveModel];
                    
                    view.center = currCenter;
                }
                
            }
            
            
            // pagings
            
            
            if(maxPages > 1)
            {
                self.scrollCategory.currentPage = 0;
                int nextMaxPage = maxPages - 1;
                [self.scrollCategory setPageMax:nextMaxPage];
            }

        }
       
    }
}



-(void)kategoriView:(KategoriView *)kategoriView didTappedSettingsAtIndex:(int)theIndex
{
    KategoriStudent *st = arrCategoryObjects[theIndex];
    
    User *theUser = [User currentUser];
    
    KategoriEkleVC *vc = [Story viewController:@"kategoriEkleVC"];
    vc.panEnabled = YES;
    vc.pinchEnabled = YES;
    vc.studentIDCurrent = theUser.ID;
    vc.categoryParentID = currentSelectedParentID;
    vc.typeAreaScreen = kKategoriEkleScreenAreaKategoriSelectedAyarlar;
    vc.typeScreen = kKategoriEkleScreenTypeKategoriEkle;
    vc.selectedKategoriStudentObject = st;
    
    if(st.typeKategori == kKategoriTypeResimStudent)
    {
        vc.typeScreen = kKategoriEkleScreenTypeResimEkle;
    }
    
    BottomBarStackController *cnt = [BottomBarStackController shared];
    vc.stackBarBottom = cnt.stack;
    
    NavigationController *navCon = [[NavigationController alloc] initWithRootViewController:vc];
    navCon.navigationBarHidden = YES;
    
    [self presentViewController:navCon animated:YES completion:^{
        
    }];
    
}


-(void)kategoriView:(KategoriView *)kategoriView didEndMovedForStudentPageAtIndex:(int)viewIndex
{
    self.scrollCategory.scrollEnabled = YES;
    
    // calc transformed frame
    
    float rate = navbarStudent.rateHeight;
    
    CGRect currRect = viewCumleSeridiItem.frame;
    currRect.origin.y = navbarStudent.viewCumleSeridi.center.y - 36*rate;
    currRect.size.height = 72*rate;
    currRect.size.width = 72*rate;
    
   /// //NSLog(@"kategori View Frame : %@" ,NSStringFromCGRect(currRect));
    
    BOOL frameAvailable = [navbarStudent isFrameAvailableForCumleSeridi:currRect];
    
   /// frameAvailable = NO; // test
    
    if(viewCumleSeridiItem.frame.origin.y < navbarStudent.frame.size.height && navbarStudent.cumleSeridiStack.count < 10 && frameAvailable == YES)
    {
        // cümle seridine ekle
        // 81 - 881 arası view cumle seridi 
        
        float rate = navbarStudent.rateHeight;
        
        CGRect currRect = viewCumleSeridiItem.frame;
        currRect.origin.y = navbarStudent.viewCumleSeridi.center.y - 36*rate;
        currRect.size.height = 72*rate;
        currRect.size.width = 72*rate;
        
        //viewCumleSeridiItem.frame = currRect;
        
        CGRect imViewFrame = currRect;
        
        imViewFrame.origin.x = 0;
        imViewFrame.origin.y = 0;
        
         [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:0  animations:^{
            
            viewCumleSeridiItem.frame = currRect;
            
            for(id vv in viewCumleSeridiItem.subviews)
            {
                if([vv isKindOfClass:[UIImageView class]])
                {
                  //  UIImage *img = ((UIImageView *)vv).image;
                    
                    [(UIImageView *)vv setFrame:imViewFrame];
                }
            }
            
           // viewCumleSeridiItem.alpha = 0;
            
        } completion:^(BOOL finished) {
            
            
         
                
                CumleSeridiItem *snapItemTemp = (CumleSeridiItem *)[viewCumleSeridiItem snapshotViewAfterScreenUpdates:YES];
                CumleSeridiItem *snapItem = [[CumleSeridiItem alloc] init];
                [snapItem addSubview:snapItemTemp];
                
                snapItem.kategoriViewID = viewCumleSeridiItem.kategoriViewID;
                
                
                User *currentUser = [User currentUser];
                Settings *st = [[Settings alloc] initWithUserID:currentUser.ID];
                
                KategoriStudent *stKat = [[KategoriStudent alloc] initWithID:snapItem.kategoriViewID];
                
                NSString *soundPath = [stKat getSoundFullPath:kKategoriStudentSesTuruTypeMale];
                if(st.typeSesTuru == kSesTuruFemale)
                {
                    soundPath = [stKat getSoundFullPath:kKategoriStudentSesTuruTypeFemale];
                }
                
                snapItem.soundPath = soundPath;
                
                
                CGRect currRect = viewCumleSeridiItem.frame;
                currRect.origin.y = navbarStudent.viewCumleSeridi.center.y - 36*rate;
                currRect.size.height = 72*rate;
                currRect.size.width = 72*rate;
                
                snapItem.frame = currRect;
                
                
                
                [navbarStudent addToCumleSeridiStack:snapItem];
                
                [viewCumleSeridiItem removeFromSuperview];
                viewCumleSeridiItem = nil;

            
        }];
    
        
    }
    else
    {
        // geri dön
        
        CGRect currFrame = cumleSeridiItemBeginFrame;
        currFrame.origin.y += currFrame.size.height/2;
        cumleSeridiItemBeginFrame = currFrame;
        
        [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            viewCumleSeridiItem.frame = cumleSeridiItemBeginFrame;
            viewCumleSeridiItem.alpha = 0;
            
        } completion:^(BOOL finished) {
           
          [viewCumleSeridiItem removeFromSuperview];
           viewCumleSeridiItem = nil;
        }];
    }
}


-(void)kategoriView:(KategoriView *)kategoriView didMovedWithTranslationForStudentPage:(CGPoint)translation atIndex:(int)viewIndex
{
   
    
    
    if(viewCumleSeridiItem == nil)
    {
         KategoriStudent *st = arrCategoryObjects[viewIndex];
        
        
        UIImage *imgScreenShot = [kategoriView screenShot];
        
        
        UIImageView *imView = [[UIImageView alloc] init];
        imView.frame = CGRectMake(0, 0, kategoriView.frame.size.width, kategoriView.frame.size.height);
        imView.image = imgScreenShot;
        
        
        viewCumleSeridiItem = [[CumleSeridiItem alloc] init];
        viewCumleSeridiItem.frame = CGRectMake(kategoriView.frame.origin.x + self.scrollCategory.frame.origin.x, kategoriView.frame.origin.y + self.scrollCategory.frame.origin.y, kategoriView.frame.size.width, kategoriView.frame.size.height);
      
        CGRect currFrame = viewCumleSeridiItem.frame;
        currFrame.origin.x -= self.scrollCategory.currentPage*self.view.frame.size.width;
        viewCumleSeridiItem.frame = currFrame;
    
        
        
        [viewCumleSeridiItem addSubview:imView];
        
        viewCumleSeridiItem.kategoriViewID = st.ID;
        
       // viewCumleSeridiItem.backgroundColor = [UIColor redColor];
        
       
        
        
        [self.view addSubview:viewCumleSeridiItem];
        
       
        
        cumleSeridiItemBeginFrame = kategoriView.frame;
        
      //  //NSLog(@"kategori View Frame : %@" , NSStringFromCGRect(kategoriView.frame));
       // //NSLog(@"Cumle seridi Begin Frame : %@" , NSStringFromCGRect(cumleSeridiItemBeginFrame));
        
    }
    
     [self.view bringSubviewToFront:viewCumleSeridiItem];
    
    viewCumleSeridiItem.center = CGPointMake(viewCumleSeridiItem.center.x + translation.x, viewCumleSeridiItem.center.y + translation.y);
    
   // //NSLog(@"center Cumle : %@" , NSStringFromCGPoint(viewCumleSeridiItem.center));
    
    //NSLog(@" frame Cumle : %@" , NSStringFromCGRect(viewCumleSeridiItem.frame));
    
    
}


-(void)kategoriView:(KategoriView *)kategoriView didStartPanningAtIndex:(int)index
{
   // self.scrollCategory.scrollEnabled = NO;
}



-(void)kategoriView:(KategoriView *)kategoriView didChangedCenter:(CGPoint)centerNew scale:(float)scaleNew atIndex:(int)theIndex
{
    
    if(self.typePage == kMainActionPageTypeStudent)
    {
        // cümle seridine dogru sürükleme yapılmıs mı ,  (Gesture Ended)
        
        
    }
    else if(self.typePage == kMainActionPageTypeTeacher)
    {
        KategoriStudent *st = arrCategoryObjects[theIndex];
        
        st.scMn = scaleNew;
        NSLog(@"scale new : %f" , st.scMn);
        
        st.cntPtMn = [NSString stringComponentFromCGPoint:centerNew];
        
        [st saveModel];
        
      //  KategoriStudent *stKK = [[KategoriStudent alloc] initWithID:st.ID];
       // NSLog(@"sct : %@" , [stKK getDictionary]);

    }

    
}


-(void)kategoriView:(KategoriView *)kategoriView didMovedToFrame:(CGRect)frame atIndex:(int)theIndex
{
    
    self.scrollCategory.scrollEnabled = YES;
    
    //NSLog(@"frame : %@" , NSStringFromCGRect(frame));
    
   if(self.typePage == kMainActionPageTypeTeacher)
   {
       
   }
   else if(self.typePage == kMainActionPageTypeStudent)
   {
        
   }
    
}


-(void)kategoriView:(KategoriView *)kategoriView didTappedAtIndex:(int)theIndex
{
    if(isKategoriViewAnimating == YES)
    {
        return;
    }
    
    KategoriStudent *stKategori = arrCategoryObjects[theIndex];
    if(stKategori.sesEnabled == 0 || self.typePage == kMainActionPageTypeTeacher)
    {
        [self goToKategoriStudent:stKategori kategoriView:kategoriView];
        return;
    }
    
    // Effects , sounds
    
    isKategoriViewAnimating =  YES;
    [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0 options:(UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse) animations:^{
       
        kategoriView.transform = CGAffineTransformMakeScale(1.2, 1.2);
        
    } completion:^(BOOL finished) {
        
    }];
    
   // sound
    User *currentUser  = [User currentUser];
    Settings *st = [[Settings alloc] initWithUserID:currentUser.ID];
    
    NSString *soundPath ;
    if(st.typeSesTuru == kSesTuruFemale)
    {
        soundPath =[stKategori getSoundFullPath:kKategoriStudentSesTuruTypeFemale];
    }
    else if(st.typeSesTuru == kSesTuruMale)
    {
        soundPath = [stKategori getSoundFullPath:kKategoriStudentSesTuruTypeMale];
    }
    
    
    if([soundPath fileExistAtDevicePath])
    {
        __weak MainActionPageVC *weakSelf = self;
        
        [soundObject playSound:soundPath success:^(NSString *soundPath, float currentTime, float duration, BOOL didFinished, BOOL didPaused) {
           
            if(didFinished == YES)
            {
                [weakSelf goToKategoriStudent:stKategori kategoriView:kategoriView];
                
            }
            
        } failure:^(NSError *error, NSString *soundPath) {
            
        }];
    }
    else
    {
        [self goToKategoriStudent:stKategori kategoriView:kategoriView];
    }
    
}



-(void)goToKategoriStudent:(KategoriStudent *)ktSelected kategoriView:(KategoriView *)kategoriView
{
 
    [kategoriView.layer removeAllAnimations];
    
    isKategoriViewAnimating = NO;
    kategoriView.transform = CGAffineTransformMakeScale(ktSelected.scMn, ktSelected.scMn);
    
    //KategoriStudent *ktSelected =arrCategoryObjects[theIndex];
    
    if(ktSelected.typeKategori == kKategoriTypeKategori)
    {
        currentSelectedParentID = ktSelected.ID;
        ////NSLog(@"current Parent ID : %d" , currentSelectedParentID);
        
        UIImage *kategoriViewImage = [kategoriView screenShot];
        UIImageView *imView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50 , 50)];
        imView.image = kategoriViewImage;
        
        
        //[barBottom pushText:ktSelected.name];
        
        BottomBarObject *object = [[BottomBarObject alloc]init];
        //object.viewObject = ktSelected.name;
        object.viewObject = imView;
        object.userInfo = @{USER_INFO_ID : @(ktSelected.ID) , USER_INFO_SCROLL_CURRENT_PAGE : @(self.scrollCategory.currentPage)};
        
        [barBottom pushObject:object];
        
        
        [self loadCategoryScrollWithSelectedParentID:currentSelectedParentID];
        
        self.scrollCategory.currentPage = 0;
        
    }

}




#pragma mark Teacher NavBar delegate 



-(void)teacherNavBarHomepageOnTap:(TeacherNavBar *)navbar
{

    [User resetCurrentUser];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)teacherNavBarAyarlarOnTap:(TeacherNavBar *)navbar
{
    SettingsGeneralVC *vc = [Story viewController:@"settingsGeneralVC"];
    [self.navigationController pushViewController:vc animated:YES];
}


-(void) debugKategoriStudent
{
     NSArray *allItems = [KategoriStudent getAllItems];
    
    for(NSDictionary *dct in allItems)
    {
        //NSLog(@"center : %@" , dct[@"cntPtMn"]);
    }
}


-(void)teacherNavBarKategoriEkleOnTap:(TeacherNavBar *)navbar
{
    [self debugKategoriStudent];
    

    User *theUser = [User currentUser];
    
    KategoriEkleVC *vc = [Story viewController:@"kategoriEkleVC"];
    vc.panEnabled = YES;
    vc.pinchEnabled = YES;
    vc.studentIDCurrent = theUser.ID;
    vc.categoryParentID = currentSelectedParentID;
    vc.typeAreaScreen = kKategoriEkleScreenAreaFromStudentPage;
    vc.typeScreen = kKategoriEkleScreenTypeKategoriEkle;
    
    int currPage = self.scrollCategory.currentPage;
    CGPoint emptyCenter = [self.scrollCategory emptyCenterOnPage:currPage];
    
   // //NSLog(@"view Center : %@" , NSStringFromCGPoint(emptyCenter));
    
   // emptyCenter.x = emptyCenter.x + currPage*self.scrollCategory.frame.size.width;
    
    vc.viewCenter = emptyCenter;
    
    
    
    BottomBarStackController *cnt = [BottomBarStackController shared];
    vc.stackBarBottom = cnt.stack;
    
    NavigationController *navCon = [[NavigationController alloc] initWithRootViewController:vc];
    navCon.navigationBarHidden = YES;
    
    [self presentViewController:navCon animated:YES completion:^{
        
    }];
    
    
}


-(void)teacherNavBarResimEkleOnTap:(TeacherNavBar *)navbar
{
    User *theUser = [User currentUser];
    
    KategoriEkleVC *vc = [Story viewController:@"kategoriEkleVC"];
    vc.panEnabled = YES;
    vc.pinchEnabled = YES;
    vc.studentIDCurrent = theUser.ID;
    vc.categoryParentID = currentSelectedParentID;
    vc.typeAreaScreen = kKategoriEkleScreenAreaFromStudentPage;
    vc.typeScreen = kKategoriEkleScreenTypeResimEkle;
    
    BottomBarStackController *cnt = [BottomBarStackController shared];
    vc.stackBarBottom = cnt.stack;
    
    int currPage = self.scrollCategory.currentPage;
    CGPoint emptyCenter = [self.scrollCategory emptyCenterOnPage:currPage];
    
    // //NSLog(@"view Center : %@" , NSStringFromCGPoint(emptyCenter));
    
    // emptyCenter.x = emptyCenter.x + currPage*self.scrollCategory.frame.size.width;
    
    vc.viewCenter = emptyCenter;

    
    NavigationController *navCon = [[NavigationController alloc] initWithRootViewController:vc];
    navCon.navigationBarHidden = YES;
    
    [self presentViewController:navCon animated:YES completion:^{
        
    }];

    
}

-(void)teacherNavBarArsivdenSecOnTap:(TeacherNavBar *)navbar
{
    
    ArsivVC *vc = [Story viewController:@"arsivVC"];
    vc.typePage = kArsivVCPageTypeFromAyarlar;
    vc.typeFilter = kArsivVCFilterNone;
    
    if(arrCategoryObjects.count > 0)
    {
        KategoriStudent *st = arrCategoryObjects[0];
        
        if(st.typeKategori == kKategoriTypeKategoriStudent)
        {
            vc.typeFilter = kArsivVCFilterKategori;
        }
        else if(st.typeKategori == kKategoriTypeResimStudent)
        {
            vc.typeFilter = kArsivVCFilterResim;
        }
    }
    
    vc.parentID = currentSelectedParentID;
    
    CGPoint emptyCenter = [self.scrollCategory emptyCenterOnPage:self.scrollCategory.currentPage];
    vc.emptyCenter = emptyCenter;
    
    NavigationController *navCon = [[NavigationController alloc] initWithRootViewController:vc];
    navCon.navigationBarHidden = YES;
    
    [self presentViewController:navCon animated:YES completion:^{
        
    }];
}

#pragma mark StudentNavbar delegate 

-(void)studentNavBar:(StudentNavBar *)navBar didEndChangedFrame:(CGRect)newFrame
{
    User *theUser = [User currentUser];
    Settings *st = [[Settings alloc] initWithUserID:theUser.ID];
    
    st.frameStringStudentNavBar = [NSString stringComponentFromFrame:newFrame];
    st.frameStringPageControl = [NSString stringComponentFromFrame:self.pageControl.frame];
    st.frameStringCategoryScroll = [NSString stringComponentFromFrame:self.scrollCategory.frame];
    
    [st save];
    
}


-(void)studentNavBar:(StudentNavBar *)navBar didChangedFrame:(CGRect)newFrame dynamicYTranslation:(float)yTranslationDynamic
{
   // //NSLog(@"y trans : %f" , yTranslationDynamic);
    
    CGRect frameScroll = self.scrollCategory.frame;
    frameScroll.origin.y += yTranslationDynamic;
    frameScroll.size.height -= yTranslationDynamic;
    self.scrollCategory.frame = frameScroll;
    
}


-(void)studentNavBarDidTappedHamePage:(StudentNavBar *)navBar
{
    [User resetCurrentUser];
      [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)studentNavBarDidTappedCancel:(StudentNavBar *)navBar
{
    
}


-(void)studentNavBarDidTappedVoice:(StudentNavBar *)navBar
{
    [navBar readyToPlayCumleSeridi];
    
    NSMutableArray *arrStack = navBar.cumleSeridiStack;
    
   // //NSLog(@"stack : %@" , arrStack);
    
    NSMutableArray *soundStack = [[NSMutableArray alloc] init];
    
    for(CumleSeridiItem *theItem in arrStack)
    {
        [soundStack addObject:theItem.soundPath];
    }
    
    
    [soundObject playSoundStack:soundStack success:^(NSString *soundPath, int index, int maxIndex, float currentTime, float duration, BOOL didFinished, BOOL didPaused) {
        
    } failure:^(NSError *error, NSString *soundPath) {
        
    }];
    
    
}


-(CGRect)studentNavBarUpdatedFrame:(StudentNavBar *)navBar
{
    User *theUser = [User currentUser];
    Settings *st = [[Settings alloc] initWithUserID:theUser.ID];
    
    CGRect frame = [st.frameStringStudentNavBar frameValueFromComponent];
    
    
    return frame;
}

#pragma mark BottomBarDelegate

-(void)bottomBarDidTappedMinusSign:(BottomBar *)bottomBar
{
    pageWillDelete = self.scrollCategory.currentPage;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Derya Hoca" message:@"Sayfa silinecektir. Emin misiniz ?" delegate:self cancelButtonTitle:@"Hayır" otherButtonTitles:@"Evet", nil];
    alert.tag = 2001;
    [alert show];
    
 
    
    
}



-(void)removeKategoriViewItems:(NSMutableArray *)arrItems
{
    for(KategoriView *view in arrItems)
    {
        int index = view.index;
        KategoriStudent *stObject = arrCategoryObjects[index];
        [stObject removeModel];
        
        [view removeFromSuperview] ; // maybe animate this
    }

}


-(void)bottomBarDidTappedPlusSign:(BottomBar *)bottomBar
{
    int numMaxPage = self.scrollCategory.maxPage+1;
    [self.scrollCategory setPageMax:numMaxPage];
}


-(void)bottomBar:(BottomBar *)bottomBar lockStateDidChanged:(BottomBarLockState)lockState
{
    User *theUser = [User currentUser];
    Settings *st = [[Settings alloc] initWithUserID:theUser.ID];
    
    
        if(lockState == kBottomBarLockStateUnLocked)
        {
            navbarStudent.imViewAnasayfa.alpha = 0.7;
            navbarStudent.btnAnasayfa.alpha = 1;
            navbarStudent.btnAnasayfa.enabled = YES;
            
            navbarStudent.panEnabled = YES;
            
            navbarStudent.alpha = 1;
           
            
            
        }
        else if(lockState == kBottomBarLockStateLocked)
       {
           navbarStudent.imViewAnasayfa.alpha = 0;
           navbarStudent.btnAnasayfa.alpha = 0;
           
           navbarStudent.panEnabled = NO;
           
           if(st.cumleSeridiEnabled == NO)
           {
               navbarStudent.alpha = 0;
           }
           
           
       }
}


-(void)bottomBar:(BottomBar *)bottomBar didChangedFrame:(CGRect)newFrame yOriginTranslationFromMinFrame:(float)yTranslation yTranslationDynamic:(float)yTranslationDynamic
{
    ////NSLog(@"y Tr : %f" , yTranslationDynamic);
    
    CGRect currFrameScroll = self.scrollCategory.frame;
    currFrameScroll.origin.y += yTranslationDynamic;
    self.scrollCategory.frame = currFrameScroll;
    
    CGRect pageControlFrame = self.pageControl.frame;
    pageControlFrame.origin.y += yTranslationDynamic;
    self.pageControl.frame = pageControlFrame;
    
    
}

-(void)bottomBar:(BottomBar *)bottomBar didChangedFrameGestureEnded:(CGRect)newFrame
{
    // save to settings
    User *theUser = [User currentUser];
    Settings *st = [[Settings alloc] initWithUserID:theUser.ID];
    
    //NSLog(@"st : %@" , [st getDictionary]);
    
    NSString *frame = [NSString stringComponentFromFrame:newFrame];
    
    st.frameStringBottomBar = frame;
    
    NSString *frameScroll = [NSString stringComponentFromFrame:self.scrollCategory.frame];
    NSString *framePageControl = [NSString stringComponentFromFrame:self.pageControl.frame];
    
    st.frameStringCategoryScroll = frameScroll;
    st.frameStringPageControl = framePageControl;
    
    [st save];
    
}

-(CGRect)bottomBarUpdatedFrame:(BottomBar *)bottomBar
{
    User *theUser = [User currentUser];
    Settings *st = [[Settings alloc] initWithUserID:theUser.ID];
    
    CGRect fr = [st.frameStringBottomBar frameValueFromComponent];
    
    if(self.typePage == kMainActionPageTypeTeacher )
    {
        return CGRectZero;
    }
    
    
    return fr;
}




-(void)bottomBar:(BottomBar *)bottomBar didTappedItemAtIndex:(int)index userInfo:(NSDictionary *)userInfo
{
    
    if(index == 0)
    {
        // Homepage
        currentSelectedParentID = [userInfo[USER_INFO_ID] intValue];
        [self loadCategoryScrollWithSelectedParentID:currentSelectedParentID];
    }
    else
    {
        // item
        currentSelectedParentID = [userInfo[USER_INFO_ID] intValue];
        [self loadCategoryScrollWithSelectedParentID:currentSelectedParentID];
    }
    
    //NSLog(@"user INFO Bottom Bar : %@" , userInfo);
    
    int currentPage = [userInfo[USER_INFO_SCROLL_CURRENT_PAGE] intValue];
    self.scrollCategory.currentPage = currentPage;
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

@end

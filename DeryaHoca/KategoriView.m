//
//  KategoriView.m
//  DeryaHoca
//
//  Created by aybek can kaya on 03/12/15.
//  Copyright © 2015 aybek can kaya. All rights reserved.
//

#import "KategoriView.h"

@implementation KategoriView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)awakeFromNib
{
    UITapGestureRecognizer *recTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(kategoriViewOnTap)];
    recTap.numberOfTapsRequired = 1;
    recTap.delegate = self;
    recTap.numberOfTouchesRequired =1;
    
    [self addGestureRecognizer:recTap];
    
    
    self.viewMainArea.layer.cornerRadius = 10;
    self.viewMainArea.layer.masksToBounds = NO;
    
    self.viewMainArea.layer.shadowOffset = CGSizeMake(-1, 10);
    self.viewMainArea.layer.shadowRadius = 5;
    self.viewMainArea.layer.shadowOpacity = 0.5;
    
    self.viewMainArea.backgroundColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor clearColor];
    
    UILongPressGestureRecognizer *rec = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressed:)];
    [self addGestureRecognizer:rec];
    
    
    // editing gestures
    
    //self.imViewKategori.userInteractionEnabled = YES;
    //self.lblKategori.userInteractionEnabled = YES;
    
    UIPinchGestureRecognizer *recPinchSelf = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchOnView:)];
    recPinchSelf.delegate = self;
    
    [self addGestureRecognizer:recPinchSelf];
    /*
    UIPinchGestureRecognizer *recPinchImView = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchOnView:)];
    
    [self.imViewKategori addGestureRecognizer:recPinchImView];
    
     UIPinchGestureRecognizer *recPinchImLbl = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchOnView:)];
    
    [self.lblKategori addGestureRecognizer:recPinchImLbl];
    */
    
   // UIPanGestureRecognizer *recPanImView = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panOnView:)];
    
     // [self.imViewKategori addGestureRecognizer:recPanImView];
    
     studentPan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panOnView:)];
    
    studentPan.delegate = self;
    [self addGestureRecognizer:studentPan];
  
    
  //  UIPanGestureRecognizer *recPanLbl = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panOnView:)];
    //[self.lblKategori addGestureRecognizer:recPanLbl];
    
    minimumTransform = self.transform;
    
    
    
    
}

#pragma mark SETTERS 

-(void)setStateRemoveAdd:(KategoriViewRemoveAddState)stateRemoveAdd
{
    _stateRemoveAdd = stateRemoveAdd;
    
    UIView *viewVertical  , *viewHorizontal; // tags -> 1000 , 1001 respectively
    
    [self bringSubviewToFront:self.viewRemoveAdd];
    
    
    if(self.viewRemoveAdd.subviews.count == 0)
    {
        float strokeWidth = 4;
        float xPos , yPos , width , height;
        
        // add 2 views
        viewVertical = [[UIView alloc] init];
        viewVertical.tag = 1000;
        
        xPos = self.viewRemoveAdd.frame.size.width/2 - strokeWidth/2;
        yPos =  self.viewRemoveAdd.frame.size.height/2 - strokeWidth*2;
        width = strokeWidth;
        height = self.viewRemoveAdd.frame.size.height - strokeWidth*2;
        
        viewVertical.frame = CGRectMake(xPos, yPos, width, height);
        //NSLog(@"view vertical Frame : %@" , NSStringFromCGRect(viewVertical.frame));
        
        viewVertical.backgroundColor = [UIColor whiteColor];
        [self.viewRemoveAdd addSubview:viewVertical];
        
        
        viewHorizontal = [[UIView alloc] init];
        viewHorizontal.tag = 1001;
        
        xPos = self.viewRemoveAdd.frame.size.width/2 - strokeWidth/2;
        yPos =  self.viewRemoveAdd.frame.size.height/2 - strokeWidth*2;
        width = strokeWidth;
        height = self.viewRemoveAdd.frame.size.height - strokeWidth*2;
        
        viewHorizontal.frame = CGRectMake(xPos, yPos, width, height);
        
        viewHorizontal.backgroundColor = [UIColor whiteColor];
        
        float angle = 90;
        viewHorizontal.transform = CGAffineTransformMakeRotation(RADIANS(angle));
        
        [self.viewRemoveAdd addSubview:viewHorizontal];
        
        // basic State
        if(stateRemoveAdd == kKategoriViewRemoveAddStateAddEnabled)
        {
            self.viewRemoveAdd.backgroundColor = [UIColor colorWithR:46 G:204 B:113 A:1];
            
        }
        else if(stateRemoveAdd == kKategoriViewRemoveAddStateRemoveEnabled)
        {
            self.viewRemoveAdd.backgroundColor = [UIColor colorWithR:232 G:64 B:76 A:1];
            
            angle = 90;
            viewVertical.transform = CGAffineTransformMakeRotation(RADIANS(angle));

        }

        
    }
    else
    {
        // fetch views
        viewVertical = [self.viewRemoveAdd viewWithTag:1000];
        viewHorizontal = [self.viewRemoveAdd viewWithTag:1001];
        
        
        //  animation State
        
        
        if(stateRemoveAdd == kKategoriViewRemoveAddStateAddEnabled)
        {
            viewVertical.transform = CGAffineTransformMakeRotation(RADIANS(0));
        }
        else if(stateRemoveAdd == kKategoriViewRemoveAddStateRemoveEnabled)
        {
            viewVertical.transform = CGAffineTransformMakeRotation(RADIANS(90));
        }
        
    }
    
    
    if(stateRemoveAdd == kKategoriViewRemoveAddStateAddEnabled)
    {
        self.viewRemoveAdd.backgroundColor = [UIColor colorWithR:46 G:204 B:113 A:1];
        
    }
    else if(stateRemoveAdd == kKategoriViewRemoveAddStateRemoveEnabled)
    {
         self.viewRemoveAdd.backgroundColor = [UIColor colorWithR:232 G:64 B:76 A:1];
    }
    
    
   // delegate
    
    /*
    if([self.delegateKategoriView respondsToSelector:@selector(kategoriView:didChangedAddRemoveState:)])
    {
        [self.delegateKategoriView kategoriView:self didChangedAddRemoveState:stateRemoveAdd];
    }
     */
    
}

-(void)setTypeScreen:(KategoriViewScreenType)typeScreen
{
    _typeScreen = typeScreen;
    
    [self bringSubviewToFront:self.viewSettings];
    [self bringSubviewToFront:self.viewDeleteBtn];
    
    
    if(typeScreen == kKategoriViewScreenTypeArsiv)
    {
        self.viewSettings.alpha = 1;
        self.viewRemoveAdd.alpha = 1;
        self.viewDeleteBtn.alpha = 1;
        
        // set View
        
        CGRect currFrame = self.viewRemoveAdd.frame;
        currFrame.origin.x = self.viewMainArea.frame.size.width - self.viewRemoveAdd.frame.size.width/2;
        currFrame.origin.y = self.viewMainArea.frame.size.height - self.viewRemoveAdd.frame.size.height/2;
        
        self.viewRemoveAdd.frame = currFrame;
    
        
        self.viewRemoveAdd.layer.cornerRadius = self.viewRemoveAdd.frame.size.height /2;
        self.viewRemoveAdd.layer.masksToBounds = YES;
        
        // add gesture
        
        UITapGestureRecognizer *recTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeAddViewOnTap)];
        recTap.numberOfTapsRequired = 1;
        recTap.numberOfTouchesRequired = 1;
        [self.viewRemoveAdd addGestureRecognizer:recTap];
        
        
        
         currFrame = self.viewSettings.frame;
        //  currFrame.origin.x = -1*self.viewSettings.frame.size.width;
        currFrame.origin.x = 0;
        currFrame.origin.y = self.frame.size.height - self.viewSettings.frame.size.height;
        
        self.viewSettings.frame = currFrame;
        
        UITapGestureRecognizer *recTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(settingsOnTap)];
        recTap1.numberOfTapsRequired = 1;
        recTap1.numberOfTouchesRequired = 1;
        [self.viewSettings addGestureRecognizer:recTap1];
        
        self.imViewSettings.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *recTapImView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(settingsOnTap)];
        recTapImView.numberOfTapsRequired = 1;
        recTapImView.numberOfTouchesRequired = 1;
        [self.imViewSettings addGestureRecognizer:recTapImView];
        
        self.viewSettings.layer.cornerRadius = self.viewSettings.frame.size.height/2;
        self.viewSettings.layer.masksToBounds = YES;
        
        self.viewSettings.backgroundColor = [UIColor colorWithR:255 G:255 B:255 A:0.7];
        
        self.imViewSettings.transform = CGAffineTransformScale(self.imViewSettings.transform, 0.7, 0.7);
        
        CGRect currFrameDelete = self.viewDeleteBtn.frame;
        currFrameDelete.origin.x = self.viewMainArea.frame.size.width - self.viewDeleteBtn.frame.size.width/4;
        //currFrameDelete.origin.y = -1*self.viewDeleteBtn.frame.size.height;
        currFrameDelete.origin.y = 0;
        self.viewDeleteBtn.frame = currFrameDelete;
        
        
        
        UITapGestureRecognizer *recTapDelete = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteOnTap)];
        recTapDelete.numberOfTapsRequired = 1;
        recTapDelete.numberOfTouchesRequired = 1;
        [self.viewDeleteBtn addGestureRecognizer:recTapDelete];
        
        self.imViewCancel.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *recTapImViewDelete = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteOnTap)];
        recTapImViewDelete.numberOfTapsRequired = 1;
        recTapImViewDelete.numberOfTouchesRequired = 1;
        [self.imViewCancel addGestureRecognizer:recTapImViewDelete];
        
        self.viewDeleteBtn.layer.cornerRadius = self.viewDeleteBtn.frame.size.height/2;
        self.viewDeleteBtn.layer.masksToBounds = YES;
        
        
        self.viewDeleteBtn.backgroundColor = [UIColor colorWithR:232 G:64 B:76 A:0.8];
        
        
        
        
    }
    else if(typeScreen == kKategoriViewScreenTypeStudent)
    {
        self.viewSettings.alpha = 0;
          self.viewRemoveAdd.alpha = 0;
        self.viewDeleteBtn.alpha = 0;
    }
    else if(typeScreen == kKategoriViewScreenTypeTeacher)
    {
          self.viewRemoveAdd.alpha = 0;
        
        CGRect currFrame = self.viewSettings.frame;
      //  currFrame.origin.x = -1*self.viewSettings.frame.size.width;
        currFrame.origin.x = 0;
        currFrame.origin.y = self.frame.size.height - self.viewSettings.frame.size.height;
        
        self.viewSettings.frame = currFrame;
        
        UITapGestureRecognizer *recTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(settingsOnTap)];
        recTap.numberOfTapsRequired = 1;
        recTap.numberOfTouchesRequired = 1;
        [self.viewSettings addGestureRecognizer:recTap];
        
         self.imViewSettings.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *recTapImView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(settingsOnTap)];
        recTapImView.numberOfTapsRequired = 1;
        recTapImView.numberOfTouchesRequired = 1;
        [self.imViewSettings addGestureRecognizer:recTap];
        
        self.viewSettings.layer.cornerRadius = self.viewSettings.frame.size.height/2;
        self.viewSettings.layer.masksToBounds = YES;
        
        self.viewSettings.backgroundColor = [UIColor colorWithR:255 G:255 B:255 A:0.7];
        
        self.imViewSettings.transform = CGAffineTransformScale(self.imViewSettings.transform, 0.7, 0.7);
       
        CGRect currFrameDelete = self.viewDeleteBtn.frame;
        currFrameDelete.origin.x = self.viewMainArea.frame.size.width - self.viewDeleteBtn.frame.size.width/4;
        //currFrameDelete.origin.y = -1*self.viewDeleteBtn.frame.size.height;
          currFrameDelete.origin.y = 0;
        self.viewDeleteBtn.frame = currFrameDelete;
        
        
        
        UITapGestureRecognizer *recTapDelete = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteOnTap)];
        recTapDelete.numberOfTapsRequired = 1;
        recTapDelete.numberOfTouchesRequired = 1;
        [self.viewDeleteBtn addGestureRecognizer:recTapDelete];
        
        self.imViewCancel.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *recTapImViewDelete = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteOnTap)];
        recTapImViewDelete.numberOfTapsRequired = 1;
        recTapImViewDelete.numberOfTouchesRequired = 1;
        [self.imViewCancel addGestureRecognizer:recTapImViewDelete];
        
        self.viewDeleteBtn.layer.cornerRadius = self.viewDeleteBtn.frame.size.height/2;
        self.viewDeleteBtn.layer.masksToBounds = YES;
        
        
        self.viewDeleteBtn.backgroundColor = [UIColor colorWithR:232 G:64 B:76 A:0.8];

        
    }
}


-(void)removeAddViewOnTap
{
    if(self.stateRemoveAdd == kKategoriViewRemoveAddStateRemoveEnabled)
    {
        self.stateRemoveAdd = kKategoriViewRemoveAddStateAddEnabled;
    }
    else if(self.stateRemoveAdd == kKategoriViewRemoveAddStateAddEnabled)
    {
        self.stateRemoveAdd = kKategoriViewRemoveAddStateRemoveEnabled;
    }
    
    if([self.delegateKategoriView respondsToSelector:@selector(kategoriView:didChangedAddRemoveState:)])
    {
        [self.delegateKategoriView kategoriView:self didChangedAddRemoveState:self.stateRemoveAdd];
    }
    
    
}



-(void)deleteOnTap
{
    if([self.delegateKategoriView respondsToSelector:@selector(kategoriView:didTappedDeleteAtIndex:)])
    {
        [self.delegateKategoriView kategoriView:self didTappedDeleteAtIndex:self.index];
    }
}


-(void)settingsOnTap
{
    if([self.delegateKategoriView respondsToSelector:@selector(kategoriView:didTappedSettingsAtIndex:)])
    {
        [self.delegateKategoriView kategoriView:self didTappedSettingsAtIndex:self.index];
    }
}



-(void)longPressed:(UILongPressGestureRecognizer *)rec
{
    
    if(rec.state == UIGestureRecognizerStateBegan)
    {
        
       // //NSLog(@"long Press");
        if([self.delegateKategoriView respondsToSelector:@selector(kategoriView:didLongPressAtIndex:)])
        {
            [self.delegateKategoriView kategoriView:self didLongPressAtIndex:self.index];
        }
    }
    else if(rec.state == UIGestureRecognizerStateEnded)
    {
        
    }
    
}

/*
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   // //NSLog(@"tc began ");
}



-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  // //NSLog(@"touch End");
}
*/

-(void)kategoriViewOnTap
{
    
    if([self.delegateKategoriView respondsToSelector:@selector(kategoriView:didTappedAtIndex:)])
    {
        [self.delegateKategoriView kategoriView:self didTappedAtIndex:self.index];
    }


        
    
}




-(UIPanGestureRecognizer *)panGesture
{
    return studentPan;
}

#pragma mark EDIT 

-(void)pinchOnView:(UIPinchGestureRecognizer *)recognizer
{
    if(self.pinchEnabled == NO)
    {
        return;
    }
    
    [self.superview bringSubviewToFront:self];
    
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
    
  //  recognizerScaleInner = recognizer.scale;
   
    
   
      recognizer.scale = 1;
    
    if(recognizer.state == UIGestureRecognizerStateEnded)
    {
        //CGSize defaultSize = [KategoriView sizeCurrentView];
        CGSize defaultSize = [KategoriView sizeOuterView];
        float rate = [KategoriView viewScaleFromDefaultSize:defaultSize newSize:recognizer.view.frame.size];
        
        ////NSLog(@"rate : %f" , rate);
        
        
        if(rate < 1)
        {
            [self animateSelfFrameToMinimumTransform];
        }
        else
        {
            if([self.delegateKategoriView respondsToSelector:@selector(kategoriView:didChangedCenter:scale:atIndex:)])
            {
                [self.delegateKategoriView kategoriView:self didChangedCenter:self.center scale:rate atIndex:self.index];
            }
        }
        
        
    }

    
}




-(void)animateSelfFrameToMinimumTransform
{
    
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:0.5 options:0 animations:^{
       
        self.transform = minimumTransform;
        
    } completion:^(BOOL finished) {
        
        CGSize defaultSize = [KategoriView sizeCurrentView];
        float rate = [KategoriView viewScaleFromDefaultSize:defaultSize newSize:self.frame.size];
        
        
        if([self.delegateKategoriView respondsToSelector:@selector(kategoriView:didChangedCenter:scale:atIndex:)])
        {
           [self.delegateKategoriView kategoriView:self didChangedCenter:self.center scale:rate atIndex:self.index];
        }
        
    }];
    
    
   
}




-(void)panOnView:(UIPanGestureRecognizer *)recognizer
{
    if(self.panEnabled == NO && self.panForStudentEnabled == NO)
    {
        return;
    }
    
      [self.superview bringSubviewToFront:self];
    
    if(self.typeScreen == kKategoriViewScreenTypeStudent)
    {
        CGPoint translation = [recognizer translationInView:self.superview];
        
        //NSLog(@"translation : %@" , NSStringFromCGPoint(translation));
        
         if(recognizer.state == UIGestureRecognizerStateChanged)
         {
              //NSLog(@"changed Pan");
             
             if([self.delegateKategoriView respondsToSelector:@selector(kategoriView:didMovedWithTranslationForStudentPage:atIndex:)])
             {
                 [self.delegateKategoriView kategoriView:self didMovedWithTranslationForStudentPage:translation atIndex:self.index];
             }
         }
        else if(recognizer.state == UIGestureRecognizerStateEnded)
        {
             //NSLog(@"end Pan");
            
            if([self.delegateKategoriView respondsToSelector:@selector(kategoriView:didEndMovedForStudentPageAtIndex:)])
            {
                [self.delegateKategoriView kategoriView:self didEndMovedForStudentPageAtIndex:self.index];
            }
        }
        else if(recognizer.state == UIGestureRecognizerStateBegan)
        {
            //NSLog(@"start Pan");
            
            
            if([self.delegateKategoriView respondsToSelector:@selector(kategoriView:didStartPanningAtIndex:)])
            {
                [self.delegateKategoriView kategoriView:self didStartPanningAtIndex:self.index];
            }
        }
        
        
        
        [recognizer setTranslation:CGPointMake(0, 0) inView:self.superview];
    }
    else
    {
        CGPoint translation = [recognizer translationInView:self.superview];
        recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                             recognizer.view.center.y + translation.y);
        [recognizer setTranslation:CGPointMake(0, 0) inView:self.superview];
        
        
        if(recognizer.state == UIGestureRecognizerStateEnded)
        {
           CGSize defaultSize = [KategoriView sizeOuterView];
           // CGSize defaultSize = [KategoriView sizeCurrentView];
            float rate = [KategoriView viewScaleFromDefaultSize:defaultSize newSize:self.frame.size];
            
            ////NSLog(@"rate : %f" , rate);
            
            if([self.delegateKategoriView respondsToSelector:@selector(kategoriView:didChangedCenter:scale:atIndex:)])
            {
                [self.delegateKategoriView kategoriView:self didChangedCenter:self.center scale:rate atIndex:self.index];
            }
        }
        else if(recognizer.state == UIGestureRecognizerStateChanged)
        {
            if([self.delegateKategoriView respondsToSelector:@selector(kategoriView:didMovedToFrame:atIndex:)])
            {
                [self.delegateKategoriView kategoriView:self didMovedToFrame:self.frame atIndex:self.index];
            }
        }
        else if(recognizer.state == UIGestureRecognizerStateBegan)
        {
            if([self.delegateKategoriView respondsToSelector:@selector(kategoriView:didStartPanningAtIndex:)])
            {
                [self.delegateKategoriView kategoriView:self didStartPanningAtIndex:self.index];
            }
        }


        
        
    }
    
    
    
    
}

+(float)viewScaleFromDefaultSize:(CGSize)sizeDefault newSize:(CGSize)sizeNew
{
    float rate = (float)sizeNew.height / sizeDefault.height;
    
    return rate;
}


/*
+(CGRect)frameFromScale:(float)scale oldFrame:(CGRect)frameOld
{
    float newWidth = frameOld.size.width * scale;
    float newHeight = frameOld.size.height * scale;
    
    CGRect newRect = CGRectMake(frameOld.origin.x, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    
}
*/



+(CGSize)sizeMinimumOfView
{
    return CGSizeMake(144, 144);
}


+(CGSize) sizeCurrentView
{
     return CGSizeMake(144, 144);
}


+(CGSize) sizeOuterView
{
    return CGSizeMake(164, 164);
}

@end

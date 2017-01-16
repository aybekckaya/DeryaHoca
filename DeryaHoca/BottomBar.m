//
//  BottomBar.m
//  DeryaHoca
//
//  Created by aybek can kaya on 18/11/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import "BottomBar.h"

#define MARGIN_WIDTH 5

#define SCROLL_RIGHT_MARGIN 180



@implementation BottomBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib
{
    scrollItems = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width-SCROLL_RIGHT_MARGIN, self.frame.size.height)];
   // scrollItems.backgroundColor = [UIColor redColor];
    
    [self addSubview:scrollItems];
    
    //stack = [[NSMutableArray alloc] init];
    
    self.imViewLock.userInteractionEnabled = YES;
    
    
    TipTapGesture *rec = [[TipTapGesture alloc] initWithTarget:self action:@selector(lockViewTapped:)];
   
    [self.imViewLock addGestureRecognizer:rec];
    
    
    UIPanGestureRecognizer *recPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panOnView:)];
    [self addGestureRecognizer:recPan];
    
    minHeight = self.frame.size.height;
    maxHeight = self.frame.size.height *2;
    
   // scrollItems.backgroundColor = [UIColor colorWithR:255 G:0 B:0 A:0.7];
    
    
}


-(void)updateApperiance
{
    if([self.datasourceBottomBar respondsToSelector:@selector(bottomBarUpdatedFrame:)])
    {
        CGRect currFrame = [self.datasourceBottomBar bottomBarUpdatedFrame:self];
        
        if(currFrame.size.height != 0 && currFrame.origin.y != 0)
        {
            self.frame = currFrame;
            
            [self updateFramesOfIcons];
        }
        
    }

}


-(void)updateFramesOfIcons
{
    float currScaleIcons = (float) self.frame.size.height / minHeight;
    
    CGRect frame;
    
    self.imViewLock.transform = CGAffineTransformMakeScale(currScaleIcons, currScaleIcons);
    
    self.btnMinus.transform = CGAffineTransformMakeScale(currScaleIcons, currScaleIcons);
    self.btnPlus.transform = CGAffineTransformMakeScale(currScaleIcons, currScaleIcons);
 
    self.imViewMinus.transform =  CGAffineTransformMakeScale(currScaleIcons, currScaleIcons);

    self.imViewPlus.transform =  CGAffineTransformMakeScale(currScaleIcons, currScaleIcons);
    //scrollItems.transform =  CGAffineTransformMakeScale(1, currScaleIcons);

    
    
    frame = scrollItems.frame;
    frame.origin.y = 0;
    frame.size.height = self.frame.size.height;
    scrollItems.frame = frame;
    
    self.imViewLock.center = CGPointMake(self.imViewLock.center.x, scrollItems.frame.size.height/2);
    
    
    [self updateView];
    
}



#pragma mark TAP GESTURES

-(void)lockViewTapped:(TipTapGesture *)rec
{
    if(rec.state == UIGestureRecognizerStateEnded)
    {
        if(self.stateLock == kBottomBarLockStateUnLocked)
        {
            self.stateLock = kBottomBarLockStateLocked;
        }
        else if(self.stateLock == kBottomBarLockStateLocked)
        {
            self.stateLock = kBottomBarLockStateUnLocked;
        }
    }
    
    
}



#pragma mark Pan Gestures 

-(void)panOnView:(UIPanGestureRecognizer *)recognizer
{
    if(self.stateLock == kBottomBarLockStateUnLocked && self.panEnabled == YES)
    {
          CGPoint translation = [recognizer translationInView:self.superview];
       // //NSLog(@"trans : %@" , NSStringFromCGPoint(translation));
        
        CGRect currFrame = self.frame;
        currFrame.origin.y = currFrame.origin.y + translation.y;
        currFrame.size.height += (-1)* translation.y;
        
        float dynamicYTrans = 0;
        
        if(currFrame.size.height < maxHeight && currFrame.size.height > minHeight)
        {
            self.frame = currFrame;
            dynamicYTrans = translation.y;
            
        }
       
        if([self.delegateBarBottom respondsToSelector:@selector(bottomBar:didChangedFrame:yOriginTranslationFromMinFrame:yTranslationDynamic:)])
        {
            float trY = currFrame.size.height - minHeight;
            [self.delegateBarBottom bottomBar:self didChangedFrame:self.frame yOriginTranslationFromMinFrame:trY yTranslationDynamic:dynamicYTrans];
        }
        
        // update the Icons and stack Size
        [self updateFramesOfIcons];
        
        [recognizer setTranslation:CGPointMake(0, 0) inView:self.superview];
        
        
        if(recognizer.state == UIGestureRecognizerStateEnded)
        {
            if([self.delegateBarBottom respondsToSelector:@selector(bottomBar:didChangedFrameGestureEnded:)])
            {
                [self.delegateBarBottom bottomBar:self didChangedFrameGestureEnded:self.frame];
            }
            
        }
        
    }
}



#pragma mark SETTERS

-(void)setStateLock:(BottomBarLockState)stateLock
{
    _stateLock = stateLock;
    if(stateLock == kBottomBarLockStateLocked)
    {
        [self.imViewLock setHighlighted:YES];
    }
    else if(stateLock == kBottomBarLockStateUnLocked)
    {
          [self.imViewLock setHighlighted:NO];
    }
    
    if([self.delegateBarBottom respondsToSelector:@selector(bottomBar:lockStateDidChanged:)])
    {
        [self.delegateBarBottom bottomBar:self lockStateDidChanged:stateLock];
    }
    
}


-(void)setTypePage:(BottomBarPageType)typePage
{
    _typePage = typePage;
    
    
    if(typePage == kBottomBarPageTypeArsiv)
    {
        self.imViewMinus.alpha = 0;
        self.imViewPlus.alpha = 0;
        self.btnMinus.alpha = 0;
        self.btnPlus.alpha = 0;
        
        self.imViewLock.alpha = 0;
        
    }
    else if(typePage == kBottomBarPageTypeKategoriEkle)
    {
        self.imViewMinus.alpha = 0;
        self.imViewPlus.alpha = 0;
        self.btnMinus.alpha = 0;
        self.btnPlus.alpha = 0;
        
        self.imViewLock.alpha = 0;
    }
    else if(typePage == kBottomBarPageTypeStudent)
    {
        self.imViewMinus.alpha = 0;
        self.imViewPlus.alpha = 0;
        self.btnMinus.alpha = 0;
        self.btnPlus.alpha = 0;
        
         self.imViewLock.alpha = 1;
    }
    else if(typePage == kBottomBarPageTypeTeacher)
    {
        self.imViewMinus.alpha = 1;
        self.imViewPlus.alpha = 1;
        self.btnMinus.alpha = 1;
        self.btnPlus.alpha = 1;
        
         self.imViewLock.alpha = 0;
    }
}


-(void) setPlusSignEnabled:(BOOL)plusSignEnabled
{
    _plusSignEnabled = plusSignEnabled;
    
    if(plusSignEnabled == YES)
    {
        self.imViewPlus.alpha = 1;
        self.btnPlus.enabled = YES;
    }
    else
    {
        self.imViewPlus.alpha = 0.3;
        self.btnPlus.enabled = YES;
    }
    
    
}


-(void)setMinusSignEnabled:(BOOL)minusSignEnabled
{
    _minusSignEnabled = minusSignEnabled;
    
    if(minusSignEnabled == YES)
    {
        self.imViewMinus.alpha = 1;
        self.btnMinus.enabled = YES;
    }
    else
    {
        self.imViewMinus.alpha = 0.3;
        self.btnMinus.enabled = NO;

    }
}


#pragma mark Actions Teacher Page Type 

- (IBAction)plusSignDidTapped:(id)sender {
    
    if([self.delegateBarBottom respondsToSelector:@selector(bottomBarDidTappedPlusSign:)])
    {
        [self.delegateBarBottom bottomBarDidTappedPlusSign:self];
    }
    
}

- (IBAction)minusSignDidTapped:(id)sender {
    
    if([self.delegateBarBottom respondsToSelector:@selector(bottomBarDidTappedMinusSign:)])
    {
        [self.delegateBarBottom bottomBarDidTappedMinusSign:self];
    }
}


#pragma mark Actions Student Page Type





-(void)pushObject:(BottomBarObject *)objectBottomBar
{
    
    // add to stack
   
    BottomBarStackController *controller = [BottomBarStackController shared];
    
    // update last element in stack
    NSMutableArray *stackCurrent = controller.stack;
    
    if(stackCurrent.count > 0)
    {
        BottomBarObject *lastObject = [stackCurrent lastObject];
        
        int lastID = [lastObject.userInfo[USER_INFO_ID] intValue];
        int currentScrollPage = [objectBottomBar.userInfo[USER_INFO_SCROLL_CURRENT_PAGE] intValue];
        
        NSDictionary *userInfoUpdate = @{USER_INFO_ID:@(lastID) , USER_INFO_SCROLL_CURRENT_PAGE:@(currentScrollPage)};
        
       // //NSLog(@"updated Info : %@" , userInfoUpdate);
        
        lastObject.userInfo = userInfoUpdate;
    }
    
    if([objectBottomBar.viewObject isKindOfClass:[UIImageView class]])
    {
        [controller push:objectBottomBar];
        [self pushUIImageView:objectBottomBar.viewObject];
    }
    else if([objectBottomBar.viewObject isKindOfClass:[NSString class]])
    {
        objectBottomBar.viewObject = [self getTextLabel:objectBottomBar.viewObject];
        [controller push:objectBottomBar];
        
        [self updateView];
        
    }
    
    [self updateFramesOfIcons];
    
}


-(UILabel *)getTextLabel:(NSString *)text
{
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    
    CGSize size = [text sizeWithAttributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName]];
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, size.width + MARGIN_WIDTH, scrollItems.frame.size.height)];
    lbl.textAlignment = NSTextAlignmentCenter;
   // lbl.textColor = [UIColor colorWithR:0 G:172 B:193 A:1];
      lbl.textColor = [UIColor colorWithR:255  G:255 B:255 A:0.5];
    lbl.text = text;
    lbl.font = font;
    
   // [stack addObject:lbl];
   // [self updateView];
    
    return lbl;
    
}

-(void)pushUIImageView:(UIImageView *)imView
{
    //CGRect currFrame = imView.frame;
    
    //[stack addObject:imView];
    [self updateView];
}



-(void)popToIndex:(int)index
{
    BottomBarStackController *controller = [BottomBarStackController shared];
    [controller popToIndex:index];
    
    /*
    int numPops = stack.count - index -1;
    
    for(int i = 0 ; i< numPops ; i++)
    {
        [stack removeLastObject];
    }
    */
    
    [self updateView];
    
}


-(void)updateView
{
    //NSMutableArray *tempStack = [stack mutableCopy];
    
    for(id vv in scrollItems.subviews)
    {
        [vv removeFromSuperview];
    }
    
    BottomBarStackController *controller = [BottomBarStackController shared];
    
    
    int itemPos = 0;
    
    float currentXPos=0;
    for(BottomBarObject *itemObject in controller.stack)
    {
        
        id item = itemObject.viewObject;
        
        
        if([item isKindOfClass:[UIImageView class]])
        {
            [(UIImageView *)item setUserInteractionEnabled:YES];
            [(UIImageView *)item setTag:itemPos];
            
            UITapGestureRecognizer *rec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemDidTapped:)];
            rec.numberOfTapsRequired = 1;
            rec.numberOfTouchesRequired = 1;
            
            [(UIImageView *)item addGestureRecognizer:rec];
            
            UIImageView *imView = (UIImageView *)item;
            
            
            
           // [imView setFrame:CGRectMake(currentXPos+MARGIN_WIDTH, imView.frame.origin.y, imView.frame.size.width, imView.frame.size.height)];
            
            [imView setFrame:CGRectMake(currentXPos+MARGIN_WIDTH, imView.frame.origin.y, scrollItems.frame.size.height-imView.frame.origin.y*2, scrollItems.frame.size.height-imView.frame.origin.y*2)];
            
           // [imView setCenter:CGPointMake(imView.center.x, scrollItems.frame.size.height/2)];
            
            [scrollItems addSubview:imView ];
            
            currentXPos += imView.frame.size.width + MARGIN_WIDTH;
            
           // imView.backgroundColor = [UIColor greenColor];
           // //NSLog(@"imView Frame : %@" , NSStringFromCGRect(imView.frame) );

            
        }
        else if([item isKindOfClass:[UILabel class]])
        {
            UILabel *theLabel = (UILabel *)item;
            theLabel.userInteractionEnabled = YES;
            theLabel.tag = itemPos;
            
            UITapGestureRecognizer *rec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemDidTapped:)];
            rec.numberOfTapsRequired = 1;
            rec.numberOfTouchesRequired = 1;
            
            [(UILabel *)item addGestureRecognizer:rec];
            
            [theLabel setFrame:CGRectMake(currentXPos+MARGIN_WIDTH, theLabel.frame.origin.y, theLabel.frame.size.width , theLabel.frame.size.height)];
            
            [scrollItems addSubview:theLabel];
            
            currentXPos += theLabel.frame.size.width + MARGIN_WIDTH;
            
        }
        
        // add seperator view
        
        if(itemPos != controller.stack.count-1)
        {
            UILabel *lblSeperator = [[UILabel alloc] init];
            
            lblSeperator.frame = CGRectMake(currentXPos, 0, 30, scrollItems.frame.size.height);
            lblSeperator.text = @">";
            lblSeperator.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
            lblSeperator.textAlignment = NSTextAlignmentCenter;
            lblSeperator.textColor = [UIColor colorWithR:255 G:255 B:255 A:0.5];
            
            [scrollItems addSubview:lblSeperator];
            
            currentXPos += lblSeperator.frame.size.width;
            

        }
        
        
        itemPos ++ ;
    }
    
    
    scrollItems.contentSize = CGSizeMake(currentXPos+100, scrollItems.contentSize.height);
    
    
    
}


// readonly
-(NSMutableArray *)stackBarBottom
{
    BottomBarStackController *controller = [BottomBarStackController shared];
    return controller.stack;
}



-(void)setStackObjects:(NSMutableArray *)stackObjects
{
    BottomBarStackController *controller = [BottomBarStackController shared];
    [controller popAllElements];
    
    for(BottomBarObject *object in stackObjects)
    {
        [controller push:object];
    }
    
   // stack = stackObjects;
    [self updateView];
}




-(void)itemDidTapped:(UITapGestureRecognizer *)recTap
{
    if(self.tapEnabled == NO)
    {
        return;
    }
    
    
    UIView *theView = recTap.view;
    
    BottomBarStackController *controller = [BottomBarStackController shared];
    
    int itemIndex = theView.tag;
    BottomBarObject *barObject = [controller.stack objectAtIndex:itemIndex];

    [self popToIndex:itemIndex];
    
    //NSLog(@"item Tapped : %d" , theView.tag);
    
    if([self.delegateBarBottom respondsToSelector:@selector(bottomBar:didTappedItemAtIndex:userInfo:)])
    {
        [self.delegateBarBottom bottomBar:self didTappedItemAtIndex:itemIndex userInfo:barObject.userInfo];
    }
    
    // fire delegate
    /*
    if([self.delegateBarBottom respondsToSelector:@selector(bottomBar:didTappedItemAtIndex:)])
    {
        [self.delegateBarBottom bottomBar:self didTappedItemAtIndex:theView.tag];
    }
    */
    
}


-(void)popAllElementsInStack
{
    BottomBarStackController *controller = [BottomBarStackController shared];
    [controller popAllElements];
}




@end

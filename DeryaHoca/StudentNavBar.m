//
//  StudentNavBar.m
//  DeryaHoca
//
//  Created by aybek can kaya on 17/11/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import "StudentNavBar.h"

@implementation CumleSeridiItem



@end


@implementation StudentNavBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)awakeFromNib
{
    minHeight = self.frame.size.height;
    maxHeight = self.frame.size.height *1.5;
    
    UIPanGestureRecognizer *rec = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(viewDidPanned:)];
    [self addGestureRecognizer:rec];
}


-(void)updateApperiance
{
    if([self.datasourceNavBar respondsToSelector:@selector(studentNavBarUpdatedFrame:)])
    {
        CGRect frame = [self.datasourceNavBar studentNavBarUpdatedFrame:self];
        
        if(frame.size.width != 0)
        {
            self.frame = frame;
            [self updateViewAndIcons];
        }
    }
}


-(void)updateViewAndIcons
{
      
    self.viewCumleSeridi.center = CGPointMake(self.viewCumleSeridi.center.x, self.frame.size.height/2);
    
    self.imViewVoice.center = CGPointMake(self.imViewVoice.center.x, self.frame.size.height/2-2);
    self.imViewCancel.center = CGPointMake(self.imViewCancel.center.x, self.frame.size.height/2 );
    self.imViewAnasayfa.center = CGPointMake(self.imViewAnasayfa.center.x, self.frame.size.height /2);
    self.btnCancel.center = CGPointMake(self.btnCancel.center.x, self.frame.size.height/2 );
    self.btnVoice.center = CGPointMake(self.btnVoice.center.x, self.frame.size.height/2 - 2);
    self.btnAnasayfa.center = CGPointMake(self.btnAnasayfa.center.x, self.frame.size.height/2);
    
    float rate = self.rateHeight;
    for(CumleSeridiItem *item in stackCumleSeridi)
    {
        CGRect currFrame = item.frame;
        currFrame.size.width = 72*rate;
        currFrame.size.height = 72*rate;
        
        //currFrame.size.height = 12;
        //currFrame.size.width = 12;
        
        item.frame = currFrame;
        
        item.center = CGPointMake(item.center.x, self.frame.size.height/2);
        
       // //NSLog(@"center : %@" , NSStringFromCGPoint(item.center));
        
        for(id vv in item.subviews)
        {
                currFrame.origin.x = 0;
                currFrame.origin.y = 0;
            
                [(UIView *)vv setFrame:currFrame];
            
        }
        
    }
    
    
}




#pragma mark GESTURES

-(void)viewDidPanned:(UIPanGestureRecognizer *)recognizer
{
    
    if(!self.panEnabled)
    {
        return;
    }
    
    CGPoint translation = [recognizer translationInView:self.superview];
    // //NSLog(@"trans : %@" , NSStringFromCGPoint(translation));
    
    CGRect currFrame = self.frame;
    currFrame.origin.y = 0;
    currFrame.size.height += (1)* translation.y;
    
    float dynamicYTrans = 0;
    
    if(currFrame.size.height < maxHeight && currFrame.size.height > minHeight)
    {
        self.frame = currFrame;
        dynamicYTrans = translation.y;
        
        [self updateViewAndIcons];
        
    }

    
    if([self.delegateNavBar respondsToSelector:@selector(studentNavBar:didChangedFrame:dynamicYTranslation:)])
    {
        [self.delegateNavBar studentNavBar:self didChangedFrame:self.frame dynamicYTranslation:dynamicYTrans];
    }
    
       [recognizer setTranslation:CGPointMake(0, 0) inView:self.superview];
    
    if(recognizer.state == UIGestureRecognizerStateEnded)
    {
        if([self.delegateNavBar respondsToSelector:@selector(studentNavBar:didEndChangedFrame:)])
        {
            [self.delegateNavBar studentNavBar:self didEndChangedFrame:self.frame];
        }
    }
}


- (IBAction)cancelDidTapped:(id)sender {
    
    [self removeAllItemsFromCumleSeridi];
    
    if([self.delegateNavBar respondsToSelector:@selector(studentNavBarDidTappedCancel:)])
    {
        [self.delegateNavBar studentNavBarDidTappedCancel:self];
    }
}

- (IBAction)voiceDidTapped:(id)sender {
    
    if([self.delegateNavBar respondsToSelector:@selector(studentNavBarDidTappedVoice:)])
    {
        [self.delegateNavBar studentNavBarDidTappedVoice:self];
    }
}

- (IBAction)anasayfaDidTapped:(id)sender {
    
    if([self.delegateNavBar respondsToSelector:@selector(studentNavBarDidTappedHamePage:)])
    {
        [self.delegateNavBar studentNavBarDidTappedHamePage:self];
    }
    
}


-(BOOL) isFrameAvailableForCumleSeridi:(CGRect)frame
{
    NSMutableArray *stack = self.cumleSeridiStack;
    for(CumleSeridiItem *theItem in stack)
    {
        if(CGRectIntersectsRect(frame, theItem.frame))
        {
            return NO;
        }
    }
    
    
    return YES;
}


-(CGRect)nextPossibleEmptyAreaOnCumleSeridi
{
    
    if(self.cumleSeridiStack.count < 1)
    {
        return CGRectMake(94, 12, 72, 72);
    }
    else if(self.cumleSeridiStack.count > 10)
    {
        return CGRectZero;
    }

    // sort
    [self readyToPlayCumleSeridi];
    
    CumleSeridiItem *lastItem = [self.cumleSeridiStack lastObject];
    float maxXPos = lastItem.frame.size.width + lastItem.frame.origin.x;
    
    CGRect emptyRect = CGRectMake(maxXPos+6, 12, 72, 72);
  
    return emptyRect;
}

#pragma mark Stack Operations

-(void)addToCumleSeridiStack:(CumleSeridiItem *)cumleSeridiItem
{
    if(stackCumleSeridi == nil)
    {
        stackCumleSeridi = [[NSMutableArray alloc] init];
    }
    
    [stackCumleSeridi addObject:cumleSeridiItem];
    
    
    // add View
    
    UIPanGestureRecognizer *recPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(cumleSeridiItemOnMove:)];
    [cumleSeridiItem addGestureRecognizer:recPan];
    
    [self addSubview:cumleSeridiItem];
    
}

#pragma mark CumleSeridi Operations

-(void)removeItemFromCumleSeridi:(CumleSeridiItem *)cumleSeridiItem
{
    
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:0 animations:^{
        
        CGRect currFrame = cumleSeridiItem.frame;
        currFrame.origin.y = currFrame.size.height * (-1);
        cumleSeridiItem.frame = currFrame;
        
    } completion:^(BOOL finished) {

        int counter = 0;
        int removalIndex = -1;
        for(CumleSeridiItem *item in stackCumleSeridi)
        {
            if(item.kategoriViewID == cumleSeridiItem.kategoriViewID)
            {
                removalIndex = counter;
            }
            
            counter ++;
        }
        
        if(removalIndex != -1)
        {
            [stackCumleSeridi removeObjectAtIndex:removalIndex];
        }
        
        [cumleSeridiItem removeFromSuperview];

        
    }];
    
    
   
}


-(void)removeAllItemsFromCumleSeridi
{
    for(CumleSeridiItem *theItem in stackCumleSeridi)
    {
        [self removeItemFromCumleSeridi:theItem];
    }
    
}



-(void)readyToPlayCumleSeridi
{
    // sort array interms of x Position
    
    [stackCumleSeridi sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        
        CumleSeridiItem *item1 = (CumleSeridiItem *)obj1 ;
        CumleSeridiItem *item2 = (CumleSeridiItem *)obj2;
        
        return item1.frame.origin.x > item2.frame.origin.x;
        
    }];
    
    
    // Debug
    /*
    for(CumleSeridiItem *theItem in stackCumleSeridi)
    {
        //NSLog(@"%@" , [theItem getDictionary]);
    }
    */
    
    
}


#pragma mark Cumle Seridi View ACTIONS

-(void)cumleSeridiItemOnMove:(UIPanGestureRecognizer *)recognizer
{
    if(recognizer.state == UIGestureRecognizerStateBegan)
    {
        cumleSeridiBaseFrame = recognizer.view.frame;
        itemOnMove = recognizer.view;
    }
    else if(recognizer.state == UIGestureRecognizerStateChanged)
    {
          CGPoint translation = [recognizer translationInView:self];
        
      //  //NSLog(@"trans : %@" , NSStringFromCGPoint(translation));
        
        recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y + translation.y);
        
        CGRect currFrame = recognizer.view.frame;
        if(currFrame.origin.x < self.viewCumleSeridi.frame.origin.x)
        {
            currFrame.origin.x = self.viewCumleSeridi.frame.origin.x;
        }
        else if(currFrame.origin.x+currFrame.size.width > self.viewCumleSeridi.frame.origin.x + self.viewCumleSeridi.frame.size.width)
        {
            currFrame.origin.x = self.viewCumleSeridi.frame.origin.x + self.viewCumleSeridi.frame.size.width - currFrame.size.width;
        }
        
        recognizer.view.frame = currFrame;
        
        [recognizer setTranslation:CGPointMake(0, 0) inView:self];
    }
    else if(recognizer.state == UIGestureRecognizerStateEnded)
    {
        
        BOOL isAvailable = YES;
        
        NSMutableArray *arrStack = self.cumleSeridiStack;
        
        for(CumleSeridiItem *theItem in arrStack)
        {
            
            if([theItem isEqual:itemOnMove])
            {
               // //NSLog(@"trer");
            }
            else
            {
                if(CGRectIntersectsRect(theItem.frame, recognizer.view.frame) )
                {
                    isAvailable = NO;
                }
            }
            
           
        }
        
        if(isAvailable == NO)
        {
            // Not available
            
            [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:0 animations:^{
                
                recognizer.view.frame = cumleSeridiBaseFrame;
                
            } completion:^(BOOL finished) {
                
            }];
        }
        else
        {
           // available
            
            //CGRect currFrame = recognizer.view.frame ;
            CGPoint currCenter = recognizer.view.center;
            
            if(currCenter.y - recognizer.view.frame.size.height /2 < 0)
            {
                CumleSeridiItem *item = (CumleSeridiItem *)recognizer.view;
                [self removeItemFromCumleSeridi:item];
            }
            else if(currCenter.y != self.viewCumleSeridi.center.y)
            {
                [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:0 animations:^{
                    
                    recognizer.view.center = CGPointMake(recognizer.view.center.x, self.viewCumleSeridi.center.y);
                    
                } completion:^(BOOL finished) {
                    
                }];
                
                
            }

            
        }
        
        
    }
}




#pragma mark READONLY 

-(NSMutableArray *)cumleSeridiStack
{
    return stackCumleSeridi;
}


-(float)rateHeight
{
    float rate = (float) self.frame.size.height / minHeight;
    
    return rate;
}


@end

//
//  TipTapGesture.m
//  Hitball
//
//  Created by aybek can kaya on 12/09/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import "TipTapGesture.h"

@implementation TipTapGesture


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
  //  self.state = UIGestureRecognizerStateFailed; // TEST
    
    if(touchOneTime == 0)
    {
        touchOneTime = CACurrentMediaTime();
        self.state = UIGestureRecognizerStateFailed;
    }
    else
    {
        touchTwoTime = CACurrentMediaTime() ;
        self.state = UIGestureRecognizerStatePossible;
    }
    
    
    /**
    if ([touches count] != 1)
    {
        self.state = UIGestureRecognizerStateFailed;
        return;
    }
     */
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    if (self.state == UIGestureRecognizerStatePossible)
    {
        double diff = touchTwoTime - touchOneTime;
        
        //NSLog(@"diff : %f" ,  diff);
        if(diff < 1.7)
        {
            touchOneTime = 0;
            touchTwoTime = 0;
              self.state = UIGestureRecognizerStateRecognized;
        }
        else
        {
            touchOneTime = 0;
            touchTwoTime = 0;
            self.state = UIGestureRecognizerStateCancelled;
        }
        
      
    }
}


@end

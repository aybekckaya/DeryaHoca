//
//  ColorChooseView.m
//  DeryaHoca
//
//  Created by aybek can kaya on 29/11/15.
//  Copyright © 2015 aybek can kaya. All rights reserved.
//

#import "ColorChooseView.h"

@implementation ColorChooseView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)awakeFromNib
{
    CGRect bounds = [[UIScreen mainScreen] bounds];
    openFrame = CGRectMake((bounds.size.width - self.frame.size.width)/2, (bounds.size.height-self.frame.size.height)/2, self.frame.size.width, self.frame.size.height);
    
    self.frame = CGRectMake(0, 0, 1, 1);
    
    self.alpha = 0;
    
    // color Wheel
    
    /*
     _colorWheel = [[ISColorWheel alloc] initWithFrame:CGRectMake(size.width / 2 - wheelSize.width / 2,
     size.height * .1,
     wheelSize.width,
     wheelSize.height)];
     _colorWheel.delegate = self;
     _colorWheel.continuous = true;
     [self.view addSubview:_colorWheel];
     
     */
    
    colorWheel = [[ISColorWheel alloc] initWithFrame:CGRectMake(0, 0, self.viewColorWheelArea.frame.size.width, self.viewColorWheelArea.frame.size.height)];
    colorWheel.delegate = self;
    colorWheel.continuous = true;
    
    [self.viewColorWheelArea addSubview:colorWheel];
    
    
    self.sliderBrightness.maximumValue = 1.0;
    self.sliderBrightness.minimumValue = 0;
    self.sliderBrightness.value = 0.5;
    
    [self.sliderBrightness addTarget:self action:@selector(brightnessChanged) forControlEvents:UIControlEventValueChanged];
    
    [self brightnessChanged];
    
    
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = NO;
    
    self.layer.shadowOffset = CGSizeMake(-1, 10);
    self.layer.shadowRadius = 5;
    self.layer.shadowOpacity = 0.5;
    

    
}


#pragma mark Brightness 

-(void)brightnessChanged
{
    [colorWheel setBrightness:self.sliderBrightness.value];
}



#pragma mark Color Wheel Delegate 

-(void)colorWheelDidChangeColor:(ISColorWheel *)colorWheel
{
   // //NSLog(@"color wheel color : %@" , colorWheel.currentColor);
    
    self.sliderBrightness.tintColor = colorWheel.currentColor;
    
    WheelColor *color = colorWheel.colorOfWheel;
    
    if([self.delegateColorChoose respondsToSelector:@selector(colorChooseView:didChangedColorRed:green:blue:)])
    {
        [self.delegateColorChoose colorChooseView:self didChangedColorRed:color.redColor green:color.greenColor blue:color.blueColor];
    }
    
}




- (IBAction)btnTamamOnTap:(id)sender {
    
    [self close];
    
}

-(void)openFromPoint:(CGPoint)ptOpen
{
    if([self.delegateColorChoose respondsToSelector:@selector(colorChooseViewWillOpen:)])
    {
        [self.delegateColorChoose colorChooseViewWillOpen:self];
    }
    
    self.center = ptOpen;
    //CGRect bounds = [[UIScreen mainScreen] bounds];
    
    latestOpenedPoint = ptOpen;
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:0 animations:^{
       
        self.frame = openFrame;
        self.alpha = 1;
        
    } completion:^(BOOL finished) {
        
    }];
    
    
    
}


-(void)close
{
    CGPoint ptClose = latestOpenedPoint;
    CGRect newFrame = CGRectMake(ptClose.x, ptClose.y, 1, 1);
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:0 animations:^{
        
        
        self.alpha = 0;
        self.frame = newFrame;
        
    } completion:^(BOOL finished) {
        
    }];
    

    
    if([self.delegateColorChoose respondsToSelector:@selector(colorChooseViewDidClosed:)])
    {
        [self.delegateColorChoose colorChooseViewDidClosed:self];
    }
}

@end

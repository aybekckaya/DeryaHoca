//
//  ColorChooseView.h
//  DeryaHoca
//
//  Created by aybek can kaya on 29/11/15.
//  Copyright © 2015 aybek can kaya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISColorWheel.h"

@class ColorChooseView;
@protocol ColorChooseViewDelegate <NSObject>

-(void)colorChooseViewWillOpen:(ColorChooseView *)colorChooseView;
-(void)colorChooseViewDidClosed : (ColorChooseView *)colorChooseView;

-(void)colorChooseView:(ColorChooseView *)colorChooseView didChangedColorRed:(float) red green:(float) green blue:(float) blue;

@end

typedef enum ColorChooseViewType
{
    kColorChooseViewTypeYaziRengi,
    kColorChooseViewTypeArkaPlanRengi
    
}ColorChooseViewType;



@interface ColorChooseView : UIView<ISColorWheelDelegate>
{
    CGRect openFrame;
    CGPoint latestOpenedPoint;
    
    ISColorWheel *colorWheel;
}

@property(nonatomic ,weak) id<ColorChooseViewDelegate> delegateColorChoose;
@property(nonatomic) ColorChooseViewType typeScreen;

@property (weak, nonatomic) IBOutlet UIView *viewColorWheelArea;
@property (weak, nonatomic) IBOutlet UISlider *sliderBrightness;
@property (weak, nonatomic) IBOutlet UIButton *btnTamam;

- (IBAction)btnTamamOnTap:(id)sender;



-(void)openFromPoint:(CGPoint) ptOpen;

-(void)close;

@end

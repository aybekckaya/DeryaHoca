//
//  BottomBar.h
//  DeryaHoca
//
//  Created by aybek can kaya on 18/11/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+Convert.h" 
#import "BottomBarStackController.h"
#import "TipTapGesture.h"
#import "NSString+component.h"


#define RADIANS(degrees) ((degrees * M_PI) / 180.0)

typedef enum BottomBarLockState
{
    kBottomBarLockStateUnLocked,
    kBottomBarLockStateLocked
}BottomBarLockState;


@class BottomBar;
@protocol BottomBardelegate <NSObject>

-(void)bottomBar:(BottomBar *)bottomBar didTappedItemAtIndex:(int) index userInfo:(NSDictionary *)userInfo;

-(void)bottomBarDidTappedPlusSign:(BottomBar *)bottomBar;

-(void)bottomBarDidTappedMinusSign:(BottomBar *)bottomBar;

-(void)bottomBar:(BottomBar *) bottomBar lockStateDidChanged:(BottomBarLockState) lockState;

-(void)bottomBar:(BottomBar *)bottomBar didChangedFrame:(CGRect) newFrame yOriginTranslationFromMinFrame:(float) yTranslation yTranslationDynamic:(float) yTranslationDynamic;

-(void)bottomBar:(BottomBar *)bottomBar didChangedFrameGestureEnded:(CGRect)newFrame;

@end


@protocol BottomBarDatasource <NSObject>

-(CGRect) bottomBarUpdatedFrame:(BottomBar *)bottomBar ;

@end


typedef enum BottomBarPageType
{
    kBottomBarPageTypeTeacher,
    kBottomBarPageTypeArsiv,
    kBottomBarPageTypeStudent,
    kBottomBarPageTypeKategoriEkle
}BottomBarPageType;




@interface BottomBar : UIView
{
    UIScrollView *scrollItems;
    
    float minHeight;
    float maxHeight;
    
  //  float currScaleIcons;
    
}

@property(nonatomic ,weak) id<BottomBardelegate> delegateBarBottom;
@property(nonatomic ,weak) id<BottomBarDatasource> datasourceBottomBar;

@property(nonatomic) BOOL tapEnabled;
@property(nonatomic ,assign) BottomBarPageType typePage;
@property(nonatomic , assign) BottomBarLockState stateLock;

@property(nonatomic ,assign) BOOL plusSignEnabled;
@property(nonatomic ,assign) BOOL minusSignEnabled;

@property(nonatomic ) BOOL panEnabled;

@property (weak, nonatomic) IBOutlet UIImageView *imViewPlus;
@property (weak, nonatomic) IBOutlet UIImageView *imViewMinus;

@property (weak, nonatomic) IBOutlet UIButton *btnMinus;
@property (weak, nonatomic) IBOutlet UIButton *btnPlus;
@property (weak, nonatomic) IBOutlet UIImageView *imViewLock;


@property(nonatomic ,readonly) NSMutableArray *stackBarBottom;

-(void)updateApperiance;


-(void)setStackObjects:(NSMutableArray *)stackObjects;

//-(void)pushUIImageView:(UIImageView *)imView userInfo:(NSDictionary *)userInfo;

//-(void)pushText:(NSString *)text userInfo:(NSDictionary *)userInfo;

-(void)pushObject:(BottomBarObject *)objectBottomBar;

-(void)popToIndex:(int) index;

-(void)popAllElementsInStack;

- (IBAction)plusSignDidTapped:(id)sender;

- (IBAction)minusSignDidTapped:(id)sender;

@end

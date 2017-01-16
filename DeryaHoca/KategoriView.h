//
//  KategoriView.h
//  DeryaHoca
//
//  Created by aybek can kaya on 03/12/15.
//  Copyright © 2015 aybek can kaya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "UIColor+Convert.h"

#define RADIANS(degrees) ((degrees * M_PI) / 180.0)


typedef enum KategoriViewRemoveAddState
{
    kKategoriViewRemoveAddStateAddEnabled,
    kKategoriViewRemoveAddStateRemoveEnabled
}KategoriViewRemoveAddState;

@class KategoriView;
@protocol KategoriViewDelegate <NSObject>

-(void)kategoriView:(KategoriView *)kategoriView didTappedAtIndex:(int) theIndex;

-(void)kategoriView:(KategoriView *)kategoriView didLongPressAtIndex:(int)theIndex;

-(void)kategoriView:(KategoriView *)kategoriView didChangedCenter:(CGPoint) centerNew scale:(float) scaleNew atIndex:(int) theIndex ;

-(void)kategoriView:(KategoriView *)kategoriView didTappedSettingsAtIndex:(int)theIndex;


-(void)kategoriView:(KategoriView *)kategoriView didTappedDeleteAtIndex:(int) theIndex;


-(void)kategoriView:(KategoriView *)kategoriView didMovedToFrame:(CGRect) frame atIndex:(int) theIndex;

-(void)kategoriView:(KategoriView *)kategoriView didChangedAddRemoveState:(KategoriViewRemoveAddState) stateNew;


-(void)kategoriView:(KategoriView *)kategoriView didMovedWithTranslationForStudentPage:(CGPoint) translation atIndex:(int) viewIndex;

-(void)kategoriView:(KategoriView *)kategoriView didEndMovedForStudentPageAtIndex:(int) viewIndex;

-(void)kategoriView:(KategoriView *)kategoriView didStartPanningAtIndex:(int) index;


@end


typedef enum KategoriViewScreenType
{
    kKategoriViewScreenTypeTeacher,
    kKategoriViewScreenTypeArsiv,
    kKategoriViewScreenTypeStudent
}KategoriViewScreenType;




@interface KategoriView : UIView
{
    CGAffineTransform minimumTransform;
    
    UIPanGestureRecognizer *studentPan;
    //float recognizerScaleInner;
}

@property(nonatomic  ,weak) id<KategoriViewDelegate> delegateKategoriView;
@property(nonatomic) int index;

@property(nonatomic ,assign) KategoriViewScreenType typeScreen;
@property(nonatomic ,assign) KategoriViewRemoveAddState stateRemoveAdd;

@property (weak, nonatomic) IBOutlet UIImageView *imViewKategori;
@property (weak, nonatomic) IBOutlet UILabel *lblKategori;
@property (weak, nonatomic) IBOutlet UIView *viewSettings;
@property (weak, nonatomic) IBOutlet UIImageView *imViewSettings;
@property (weak, nonatomic) IBOutlet UIView *viewDeleteBtn;
@property (weak, nonatomic) IBOutlet UIImageView *imViewCancel;
@property (weak, nonatomic) IBOutlet UIView *viewMainArea;

@property (weak, nonatomic) IBOutlet UIView *viewRemoveAdd;

// gestures
@property(nonatomic) BOOL pinchEnabled;
@property(nonatomic) BOOL panEnabled;

@property(nonatomic) BOOL panForStudentEnabled;

@property(nonatomic ,readonly) UIPanGestureRecognizer *panGesture;


+(CGSize) sizeMinimumOfView;

+(CGSize) sizeOuterView;

+(float)viewScaleFromDefaultSize:(CGSize) sizeDefault newSize:(CGSize) sizeNew;

//+(CGRect)frameFromScale:(float) scale oldFrame:(CGRect) frameOld;

+(CGSize) sizeCurrentView;


@end

//
//  StudentNavBar.h
//  DeryaHoca
//
//  Created by aybek can kaya on 17/11/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "KategoriView.h"
#import "NSObject+KJSerializer.h"

@interface CumleSeridiItem : UIView

//@property(nonatomic , strong) UIImageView *imViewIcon;
@property(nonatomic) int kategoriViewID;
@property(nonatomic ,strong) NSString *soundPath;

@end


@class StudentNavBar;
@protocol StudentNavBarDelegate <NSObject>

-(void)studentNavBarDidTappedCancel:(StudentNavBar *)navBar;

-(void)studentNavBarDidTappedVoice:(StudentNavBar *)navBar;

-(void)studentNavBarDidTappedHamePage:(StudentNavBar *)navBar;

-(void)studentNavBar:(StudentNavBar *)navBar didChangedFrame:(CGRect) newFrame dynamicYTranslation:(float) yTranslationDynamic;

-(void)studentNavBar:(StudentNavBar *)navBar didEndChangedFrame:(CGRect)newFrame;

@end

@protocol StudentNavBarDatasource <NSObject>

-(CGRect) studentNavBarUpdatedFrame:(StudentNavBar *)navBar;

@end

@interface StudentNavBar : UIView
{
    float minHeight;
    float maxHeight;
    
    // Kategori View Items
    NSMutableArray *stackCumleSeridi;
    
    // dynamic
    CGRect cumleSeridiBaseFrame;
    CumleSeridiItem *itemOnMove;
    
}

@property(nonatomic ,weak) id<StudentNavBarDelegate> delegateNavBar;
@property(nonatomic ,weak) id<StudentNavBarDatasource> datasourceNavBar;

@property(nonatomic) BOOL panEnabled;



@property (weak, nonatomic) IBOutlet UIView *viewCumleSeridi;

@property (weak, nonatomic) IBOutlet UIImageView *imViewVoice;
@property (weak, nonatomic) IBOutlet UIImageView *imViewCancel;
@property (weak, nonatomic) IBOutlet UIImageView *imViewAnasayfa;

@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnVoice;
@property (weak, nonatomic) IBOutlet UIButton *btnAnasayfa;

#pragma mark READONLY
@property(nonatomic ,readonly) NSMutableArray *cumleSeridiStack;
@property(nonatomic ,readonly) float rateHeight;


-(void)updateApperiance;

- (IBAction)cancelDidTapped:(id)sender;

- (IBAction)voiceDidTapped:(id)sender;

- (IBAction)anasayfaDidTapped:(id)sender;


#pragma mark Stack Operations

-(BOOL)isFrameAvailableForCumleSeridi:(CGRect) frame;

-(void)addToCumleSeridiStack:(CumleSeridiItem *) cumleSeridiItem;

-(CGRect) nextPossibleEmptyAreaOnCumleSeridi;

#pragma mark CumleSeridi Operations

-(void)readyToPlayCumleSeridi;

-(void)removeItemFromCumleSeridi:(CumleSeridiItem *) cumleSeridiItem;


@end

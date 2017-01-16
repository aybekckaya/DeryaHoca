//
//  CategoryScroll.h
//  DeryaHoca
//
//  Created by aybek can kaya on 21/11/15.
//  Copyright © 2015 aybek can kaya. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CategoryScroll;
@protocol CategoryScrollDatasource <NSObject>

@required

-(NSInteger)numberOfItemsInCategoryScroll:(CategoryScroll *)categoryScroll;

-(UIView *)categoryScroll:(CategoryScroll *)categoryScroll viewAtIndex:(int) index;

-(CGPoint)categoryScroll:(CategoryScroll *)categoryScroll viewCenterAtIndex:(int) index;

-(float) categoryScroll:(CategoryScroll *)categoryScroll viewScaleAtIndex:(int) index;

//-(CGSize) categoryScrollMinimumSize:(CategoryScroll *)categoryScroll;

-(CGSize) categoryScroll:(CategoryScroll *)categoryScroll viewSizeAtIndex:(int) index;

@end

@protocol CategoryScrollDelegate <NSObject>

@optional
-(void)categoryScroll:(CategoryScroll *)categoryScroll currentPageDidChanged:(int) pageCurrent maxPages:(int) maxPages;

@end



// 144 , 144
// margin : 20 

typedef enum CategoryScrollPageType
{
        kCategoryScrollTypeDefault,
        kCategoryScrollTypeStudentPage
    
}CategoryScrollPageType;

@interface CategoryScroll : UIScrollView<UIScrollViewDelegate>
{
    NSMutableArray *arrViews;
    
    int pageMax;
}

@property(nonatomic) CategoryScrollPageType typeScroll;

@property(nonatomic , weak) id<CategoryScrollDatasource> datasourceScroll;
@property(nonatomic ,weak) id <CategoryScrollDelegate> delegateScroll;

@property(nonatomic ,assign) int currentPage;
@property(nonatomic ,readonly) int maxPage;

-(void)setPageMax:(int) maxPageNum;

-(void)reloadScroll;

/**
 @returns kategori View Items on given page
 */
-(NSMutableArray *)itemsAtPage:(int) page;

-(CGPoint) emptyCenterOnPage:(int) page;

@end

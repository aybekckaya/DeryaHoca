//
//  UserCell.h
//  DeryaHoca
//
//  Created by aybek can kaya on 16/11/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+Convert.h"

@class UserCell;
@protocol UserCellDelegate <NSObject>

-(void)userCellDidTappedDelete:(UserCell *)cell ;

-(void)userCellDidTappedChoose:(UserCell *)cell;

-(void)userCellProfileImageDidTapped:(UserCell *)cell;

@end

@interface UserCell : UITableViewCell
{
    
}

@property(nonatomic ,weak) id<UserCellDelegate> delegateCell;

@property(nonatomic) int userID;

@property (weak, nonatomic) IBOutlet UIImageView *imViewProfile;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;

- (IBAction)btnSecOnTap:(id)sender;

- (IBAction)btnSilOnTap:(id)sender;


@end

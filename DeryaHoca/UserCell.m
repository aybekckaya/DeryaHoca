//
//  UserCell.m
//  DeryaHoca
//
//  Created by aybek can kaya on 16/11/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import "UserCell.h"

@implementation UserCell

- (void)awakeFromNib {
    // Initialization code
    
    self.imViewProfile.layer.cornerRadius = self.imViewProfile.frame.size.height/2;
    self.imViewProfile.layer.masksToBounds = YES;
    
    self.imViewProfile.layer.borderWidth = 3;
    self.imViewProfile.layer.borderColor = [[UIColor colorWithR:226 G:226 B:226 A:1.0] CGColor];
    
    self.imViewProfile.userInteractionEnabled = YES;
    UITapGestureRecognizer *recTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(profileImageDidTapped)];
    recTap.numberOfTapsRequired = 1;
    recTap.numberOfTouchesRequired = 1;
    [self.imViewProfile addGestureRecognizer:recTap];
    
}


-(void)profileImageDidTapped
{
    if([self.delegateCell respondsToSelector:@selector(userCellProfileImageDidTapped:)])
    {
        [self.delegateCell userCellProfileImageDidTapped:self];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btnSecOnTap:(id)sender {
    
    if([self.delegateCell respondsToSelector:@selector(userCellDidTappedChoose:)])
    {
        [self.delegateCell userCellDidTappedChoose:self];
    }
    
}

- (IBAction)btnSilOnTap:(id)sender {
    
    if([self.delegateCell respondsToSelector:@selector(userCellDidTappedDelete:)])
    {
        [self.delegateCell userCellDidTappedDelete:self];
    }
    
}
@end

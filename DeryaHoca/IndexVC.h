//
//  IndexVC.h
//  DeryaHoca
//
//  Created by aybek can kaya on 14/11/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import "BaseVC.h"

#import "KullanicilarVC.h"
#import "ArsivVC.h"

#import "NSString+LabelSize.h"

//#import <AVFoundation/AVFoundation.h>



@interface IndexVC : BaseVC
{
    
}

@property (weak, nonatomic) IBOutlet UIView *viewKullaniciGirisi;
@property (weak, nonatomic) IBOutlet UIView *viewAyarlar;
@property (weak, nonatomic) IBOutlet UIView *viewArsiv;


- (IBAction)kullaniciGirisOnTap:(id)sender;

- (IBAction)ayarlarOnTap:(id)sender;
- (IBAction)arsivOnTap:(id)sender;

@end

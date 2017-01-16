//
//  IndexVC.m
//  DeryaHoca
//
//  Created by aybek can kaya on 14/11/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import "IndexVC.h"

@interface IndexVC ()

@end

@implementation IndexVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //NSLog(@"%@" , [NSString devicePath]);
    
    
    
    
   /*
    NSString *string = @"Elmalar Armutlar , meyveler";
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:string];
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"tr-TR"];
    utterance.rate = 0.2;
    
    AVSpeechSynthesizer *synthesizer = [[AVSpeechSynthesizer alloc] init];
    [synthesizer speakUtterance:utterance];
    */
    
    
    KategoriStudent *st = [[KategoriStudent alloc]init];
    
    
    //[NSString logAllUsableFonts];
    
    
    if(IS_TESTING_KATEGORI_EKLE == 1)
    {
        KategoriEkleVC *vc = [Story viewController:@"kategoriEkleVC"];
        vc.typeScreen = kKategoriEkleScreenTypeResimEkle;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}




/*

-(BOOL)shouldAutorotate
{
    return YES;
}

*/


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)kullaniciGirisOnTap:(id)sender {
    
    
    User *currentUser = [User currentUser];
    if(currentUser.ID == 0)
    {
        // no current User
        
        KullanicilarVC *vc = [Story viewController:@"kullanicilarVC"];
        vc.typeScreenKullanicilar = kKullanicilarScreenTypeStudent;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        MainActionPageVC *vc = [Story viewController:@"mainActionPageVC"];
        vc.typePage = kMainActionPageTypeStudent;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
   
    
}

- (IBAction)ayarlarOnTap:(id)sender {
    
    User *currentUser = [User currentUser];
    if(currentUser.ID == 0)
    {
        // no current User
        
        KullanicilarVC *vc = [Story viewController:@"kullanicilarVC"];
        vc.typeScreenKullanicilar = kKullanicilarScreenTypeTeacher;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        MainActionPageVC *vc = [Story viewController:@"mainActionPageVC"];
        vc.typePage = kMainActionPageTypeTeacher;
        [self.navigationController pushViewController:vc animated:YES];
    }

    
}

- (IBAction)arsivOnTap:(id)sender {
    
    [User resetCurrentUser];
    
    ArsivVC *vc = [Story viewController:@"arsivVC"];
    [self.navigationController pushViewController:vc animated:YES];
}
@end

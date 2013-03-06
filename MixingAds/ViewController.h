//
//  ViewController.h
//  MixingAds
//
//  Created by Luc Wollants on 29/12/12.
//  Copyright (c) 2012 apptite. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <iAd/iAd.h>
#import "GADBannerView.h"

@interface ViewController : UIViewController <ADBannerViewDelegate, GADBannerViewDelegate>{

    ADBannerView *iAdBannerView;
    GADBannerView *gAdBannerView;
}

//@property (strong, nonatomic) ADBannerView *iAdBannerView;
@property (strong, nonatomic) GADBannerView *gAdBannerView;

@end

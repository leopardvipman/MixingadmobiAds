//
//  ViewController.m
//  MixingAds
//
//  Created by Luc Wollants on 29/12/12.
//  Copyright (c) 2012 apptite. All rights reserved.
//

#import "ViewController.h"

#define ADMOB_ID @"a14fb773a49c5c9"

@interface ViewController ()

@end

@implementation ViewController


@synthesize gAdBannerView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Init iAd banner
    [self initiAdBanner];
    // Init Google Ad banner
    [self initgAdBanner];
  

}

-(void)loadView
{
    [super loadView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Init methods
//- (void)bannerViewDidLoadAd:(ADBannerView *)banner
//{
//	NSLog(@"%d",iAdBannerView.bannerLoaded);
//	iAdBannerView.hidden = NO;
//	NSLog(@"did load");
//}
-(void)initiAdBanner
{
    if (!iAdBannerView)
    {
        CGRect rect = CGRectMake(0, self.view.frame.size.height, 0, 0);
       // CGRect rect=CGRectMake(0, self.view.frame.size.height/2, 320, 44);
        iAdBannerView = [[ADBannerView alloc]initWithFrame:rect];
        iAdBannerView.delegate = self;
        
     //[self.view bringSubviewToFront:iAdBannerView];
     [self.view addSubview:iAdBannerView];
        iAdBannerView.hidden = YES;
        //iAdBannerView.alpha=0.0;
       
    }
}

-(void)initgAdBanner
{
    if (!self.gAdBannerView)
    {
        CGRect rect = CGRectMake(0, self.view.frame.size.height, GAD_SIZE_320x50.width, GAD_SIZE_320x50.height);
        self.gAdBannerView = [[GADBannerView alloc] initWithFrame:rect];
        self.gAdBannerView.adUnitID = ADMOB_ID;
        self.gAdBannerView.rootViewController = self;
        self.gAdBannerView.delegate = self;
        self.gAdBannerView.hidden = TRUE;
        [self.view addSubview:self.gAdBannerView];
    }
}

-(void)viewDidLayoutSubviews
{
    
    
    if (self.view.frame.size.height != self.gAdBannerView.frame.origin.y)
    {
        self.gAdBannerView.frame = CGRectMake(0, self.view.frame.size.height, self.gAdBannerView.frame.size.width, self.gAdBannerView.frame.size.height);
    }
    if (self.view.frame.size.height != iAdBannerView.frame.origin.y)
    { 
        iAdBannerView.frame = CGRectMake(0, self.view.frame.size.height, iAdBannerView.frame.size.width, iAdBannerView.frame.size.height);
    }
   
}

#pragma mark - Banner hide and show -

// Hide the banner by sliding down
-(void)hideBanner:(UIView*)banner
{
    if (banner && ![banner isHidden])
    {
        [UIView beginAnimations:@"hideBanner" context:nil];
        banner.frame = CGRectOffset(banner.frame, 0, banner.frame.size.height);
        [UIView commitAnimations];
        banner.hidden = TRUE;
    }
}

// Show the banner by sliding up
-(void)showBanner:(UIView*)banner
{
    if (banner && [banner isHidden])
    {
        [UIView beginAnimations:@"showBanner" context:nil];
        banner.frame = CGRectOffset(banner.frame, 0, -banner.frame.size.height);
        [UIView commitAnimations];
        banner.hidden = FALSE;
    }
}

#pragma mark - ADBanner delegate methods -

// Called before the add is shown, time to move the view
//- (void)bannerViewWillLoadAd:(ADBannerView *)banner
- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    NSLog(@"iAd load");
    [self hideBanner:self.gAdBannerView];
    [self showBanner:iAdBannerView];
//  [self hideBanner:iAdBannerView];
//  [self showBanner:self.gAdBannerView];
}

// Called when an error occured
- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"iAd error: %@", error);
    [self hideBanner:iAdBannerView];
    [self.gAdBannerView loadRequest:[GADRequest request]];
}

#pragma mark - GADBanner delegate methods -

// Called before ad is shown, good time to show the add
- (void)adViewDidReceiveAd:(GADBannerView *)view
{
    NSLog(@"Admob load");
    [self hideBanner:iAdBannerView];
    [self showBanner:self.gAdBannerView];
}

// An error occured
- (void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error
{
    NSLog(@"Admob error: %@", error);
    [self hideBanner:self.gAdBannerView];
}

@end

//
//  AboutViewController.h
//  PresentationLayer
//
//  Created by Ivan_deng on 2017/3/10.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    HUNTERPROFILE = 0,
    FRIEDS,
    GPSLOCATION,
    OFFICIALSITE,
    ABOUT,
}viewType;


@interface AboutViewController : UIViewController<UIGestureRecognizerDelegate>



@property(nonatomic,strong) UIView *mainView;
@property(nonatomic,strong) UIView *sliderView;
@property(nonatomic,strong) UIScrollView *basicScroll;


- (void)showSlideView;

- (void)hideSlideView;

@end

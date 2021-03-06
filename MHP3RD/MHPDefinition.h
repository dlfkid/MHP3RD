//
//  MHPDefinition.h
//  MHP3RD
//
//  Created by Ivan_deng on 2018/1/5.
//  Copyright © 2018年 Ivan_deng. All rights reserved.
//

#ifndef MHPDefinition_h
#define MHPDefinition_h

#import <Foundation/Foundation.h>
#import <UIkit/UIkit.h>

static const CGFloat MHPstatusbar = 20;
static const CGFloat MHPnavigationbar = 44;
static const CGFloat MHPstatusbarX = 44;
static const CGFloat MHPtabbar = 48;
static const CGFloat MHPtopEdgeInset = 64;
static const CGFloat MHPlabelHeight = 40;
static const CGFloat MHPlabelWidth = 60;
static const CGFloat MHPgap = 10;

inline static CGFloat MHPscreenHeight() {
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    return height;
}

inline static CGFloat MHPscreenWidth() {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    return width;
}

#endif /* MHPDefinition_h */

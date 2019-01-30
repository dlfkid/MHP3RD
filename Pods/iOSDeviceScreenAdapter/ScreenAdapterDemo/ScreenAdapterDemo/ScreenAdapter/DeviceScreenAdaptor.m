//
//  DeviceScreenAdaptor.m
//  ScreenAdapterDemo
//
//  Created by LeonDeng on 2019/1/25.
//  Copyright © 2019 LeonDeng. All rights reserved.
//

#import "DeviceScreenAdaptor.h"

#import <sys/utsname.h>

@interface DeviceScreenAdaptor()

// Remember to reload the getter. When coding, choose the screen type you are using as develop device, it helps the adaptor to adjust UI values when your app is running in other screen types;
@property (nonatomic, assign) DeviceScreenType developStrandardScreenType;

@end

@implementation DeviceScreenAdaptor

#pragma mark - Private

- (DeviceScreenType)developStrandardScreenType {
    // I am using iPhone7Pluse for coding, so I choosed 5.5 inch screen.
    return DeviceScreenType5_5;
}

- (BOOL)isLandscape {
    CGFloat screenWidth = [UIScreen mainScreen].nativeBounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].nativeBounds.size.height;
    
    return screenHeight < screenWidth;
}

- (DeviceScreenType)screenType {
    switch (self.deviceType) {
        case IPhone_1G:
        case IPhone_3G:
        case IPhone_3GS:
            return DeviceScreenTypeUnknown;
            
        case IPhone_4:
        case IPhone_4S:
            return DeviceScreenType3_5;
            
        case IPhone_5:
        case IPhone_5S:
        case IPhone_5C:
        case IPhone_SE:
            return DeviceScreenType4_0;
            
        case IPhone_6:
        case IPhone_6S:
        case IPhone_7:
        case IPhone_8:
            return DeviceScreenType4_7;
            
        case IPhone_6P:
        case IPhone_6S_P:
        case IPhone_7P:
        case IPhone_8P:
            return DeviceScreenType5_5;
            
        case IPhone_X:
        case IPhone_XS:
            return DeviceScreenType5_8;
            
        case IPhone_XSMax:
            return DeviceScreenType6_5;
            
        case IPhone_XR:
            return DeviceScreenType6_1;
            
        default:
            return DeviceScreenTypeUnknown;
    }
}

- (DeviceType)deviceType{
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine
                                            encoding:NSUTF8StringEncoding];
    //simulator
    if ([platform isEqualToString:@"i386"])          return Simulator;
    if ([platform isEqualToString:@"x86_64"])        return Simulator;
    
    //iPhone
    if ([platform isEqualToString:@"iPhone1,1"])     return IPhone_1G;
    if ([platform isEqualToString:@"iPhone1,2"])     return IPhone_3G;
    if ([platform isEqualToString:@"iPhone2,1"])     return IPhone_3GS;
    if ([platform isEqualToString:@"iPhone3,1"])     return IPhone_4;
    if ([platform isEqualToString:@"iPhone3,2"])     return IPhone_4;
    if ([platform isEqualToString:@"iPhone4,1"])     return IPhone_4S;
    if ([platform isEqualToString:@"iPhone5,1"])     return IPhone_5;
    if ([platform isEqualToString:@"iPhone5,2"])     return IPhone_5;
    if ([platform isEqualToString:@"iPhone5,3"])     return IPhone_5C;
    if ([platform isEqualToString:@"iPhone5,4"])     return IPhone_5C;
    if ([platform isEqualToString:@"iPhone6,1"])     return IPhone_5S;
    if ([platform isEqualToString:@"iPhone6,2"])     return IPhone_5S;
    if ([platform isEqualToString:@"iPhone7,1"])     return IPhone_6P;
    if ([platform isEqualToString:@"iPhone7,2"])     return IPhone_6;
    if ([platform isEqualToString:@"iPhone8,1"])     return IPhone_6S;
    if ([platform isEqualToString:@"iPhone8,2"])     return IPhone_6S_P;
    if ([platform isEqualToString:@"iPhone8,4"])     return IPhone_SE;
    if ([platform isEqualToString:@"iPhone9,1"])     return IPhone_7;
    if ([platform isEqualToString:@"iPhone9,3"])     return IPhone_7;
    if ([platform isEqualToString:@"iPhone9,2"])     return IPhone_7P;
    if ([platform isEqualToString:@"iPhone9,4"])     return IPhone_7P;
    if ([platform isEqualToString:@"iPhone10,1"])    return IPhone_8;
    if ([platform isEqualToString:@"iPhone10,4"])    return IPhone_8;
    if ([platform isEqualToString:@"iPhone10,2"])    return IPhone_8P;
    if ([platform isEqualToString:@"iPhone10,5"])    return IPhone_8P;
    if ([platform isEqualToString:@"iPhone10,3"])    return IPhone_X;
    if ([platform isEqualToString:@"iPhone10,6"])    return IPhone_X;
    if ([platform isEqualToString:@"iPhone11,2"])    return IPhone_XS;
    if ([platform isEqualToString:@"iPhone11,4"])    return IPhone_XSMax;
    if ([platform isEqualToString:@"iPhone11,6"])    return IPhone_XSMax;
    if ([platform isEqualToString:@"iPhone11,8"])    return IPhone_XR;
    return Unknown;
}

- (NSString *)deviceTypeString {
    switch (self.deviceType) {
        case IPhone_1G:
            return @"iPhone_1G";
            
        case IPhone_3G:
            return @"iPhone_3G";
            
        case IPhone_3GS:
            return @"iPhone_3GS";
            
        case IPhone_4:
            return @"iPhone_4";
            
        case IPhone_4S:
            return @"iPhone_4S";
            
        case IPhone_5:
            return @"iPhone_5";
            
        case IPhone_5S:
            return @"iPhone_5S";
            
        case IPhone_6:
            return @"iPhone_6";
            
        case IPhone_6P:
            return @"iPhone_6P";
            
        case IPhone_6S:
            return @"iPhone_6S";
            
        case IPhone_6S_P:
            return @"iPhone_6SP";
            
        case IPhone_7:
            return @"iPhone_7";
            
        case IPhone_7P:
            return @"iPhone_7P";
            
        case IPhone_8:
            return @"iPhone_8";
            
        case IPhone_8P:
            return @"iPhone_8P";
            
        case IPhone_X:
            return @"iPhone_X";
            
        case IPhone_5C:
            return @"iPhone_5C";
            
        case IPhone_SE:
            return @"iPhone_SE";
            
        case IPhone_XS:
            return @"iPhone_XS";
            
        case IPhone_XSMax:
            return @"iPhone_XSMax";
            
        case IPhone_XR:
            return @"iPhone_XR";
            
        case Unknown:
        default:
            return @"UnknownDevice";
    }
}

- (CGFloat)adaptedValue:(CGFloat)standardValue {
    CGFloat diagonalStandardWidthSquare = pow([self screenWidth:self.developStrandardScreenType], 2);
    CGFloat diagonalStandardHeightSquare = pow([self screenHeight:self.developStrandardScreenType], 2);
    CGFloat diagonalLengthStandard = sqrt(diagonalStandardWidthSquare + diagonalStandardHeightSquare);
    
    CGFloat diagonalActualWidthSquare = pow([self screenWidth:self.screenType], 2);
    CGFloat diagonalActualHeightSquare = pow([self screenHeight:self.screenType], 2);
    CGFloat diagonalLengthActual = sqrt(diagonalActualWidthSquare + diagonalActualHeightSquare);
    
    return standardValue * (diagonalLengthActual / diagonalLengthStandard);
}

- (CGFloat)screenWidth:(DeviceScreenType)type {
    CGFloat width;
    switch (type) {
        case DeviceScreenTypeUnknown: {
            width = [self screenWidth:self.developStrandardScreenType];
        }
            break;
            
        case DeviceScreenType3_5:
            width = 320;
            break;
            
        case DeviceScreenType4_0:
            width = 320;
            break;
            
        case DeviceScreenType4_7:
            width = 375;
            break;
            
        case DeviceScreenType5_5:
            width = 414;
            break;
            
        case DeviceScreenType5_8:
            width = 375;
            break;
            
        case DeviceScreenType6_5:
        case DeviceScreenType6_1:
            width = 414;
            break;
            
        default:
            width = 0;
            break;
    }
    return width;
}

- (CGFloat)screenHeight:(DeviceScreenType)type {
    CGFloat height;
    switch (type) {
        case DeviceScreenTypeUnknown: {
            height = [self screenHeight:self.developStrandardScreenType];
        }
            break;
            
        case DeviceScreenType3_5:
            height = 480;
            break;
            
        case DeviceScreenType4_0:
            height = 568;
            break;
            
        case DeviceScreenType4_7:
            height = 667;
            break;
            
        case DeviceScreenType5_5:
            height = 736;
            break;
            
        case DeviceScreenType5_8:
            height = 812;
            break;
            
        case DeviceScreenType6_5:
        case DeviceScreenType6_1:
            height = 896;
            break;
            
        default:
            height = 0;
            break;
    }
    return height;
}

- (CGFloat)statusBarMagin {
    switch (self.deviceType) {
        case IPhone_X:
        case IPhone_XS:
        case IPhone_XR:
        case IPhone_XSMax:
            return 44;
            break;
            
        default:
            return 20;
            break;
    }
}

- (CGFloat)bottomIndicatorMargin {
    switch (self.deviceType) {
        case IPhone_X:
        case IPhone_XS:
        case IPhone_XR:
        case IPhone_XSMax:
            return 34;
            break;
            
        default:
            return 0;
            break;
    }
}

#pragma mark - Public

+ (CGFloat)adaptedValue:(CGFloat)standardValue {
    DeviceScreenAdaptor *adaptor = [DeviceScreenAdaptor sharedAdaptor];
    return [adaptor adaptedValue:standardValue];
}

+ (DeviceScreenAdaptor *)sharedAdaptor {
    static DeviceScreenAdaptor *sharedAdaptor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedAdaptor = [[DeviceScreenAdaptor alloc] init];
    });
    return sharedAdaptor;
}

+ (BOOL)isLandscape {
    return [DeviceScreenAdaptor sharedAdaptor].isLandscape;
}

+ (DeviceScreenType)screenType {
    return [DeviceScreenAdaptor sharedAdaptor].screenType;
}


+ (DeviceType)deviceType {
    return [DeviceScreenAdaptor sharedAdaptor].deviceType;
}

+ (NSString *)deviceTypeString {
    return [DeviceScreenAdaptor sharedAdaptor].deviceTypeString;
}

+ (CGFloat)statusBarMargin {
    return [DeviceScreenAdaptor sharedAdaptor].statusBarMagin;
}

+ (CGFloat)bottomIndicatorMargin {
    return [DeviceScreenAdaptor sharedAdaptor].bottomIndicatorMargin;
}

/*+ (DeviceScreenType)currentScreenType {
    CGFloat side1 = [UIScreen mainScreen].nativeBounds.size.width;
    CGFloat side2 = [UIScreen mainScreen].nativeBounds.size.height;
    
    CGFloat screenWidth = side1 < side2 ? side1 : side2;
    CGFloat screenHeight = side1 < side2 ? side2 : side1;
    
    NSLog(@"ScreenNativeBounds Height: %f, Width: %f", screenHeight, screenWidth);
    
    DeviceScreenType deviceSize = DeviceScreenTypeUnknown;
    
    if (960 == screenHeight && 640 == screenWidth) {
        deviceSize = DeviceScreenType3_5;
    }
    else if (1136 == screenHeight && 640 == screenWidth) {
        deviceSize = DeviceScreenType4_0;
    }
    else if (1334 == screenHeight && 750 == screenWidth) {
        deviceSize = DeviceScreenType4_7;
    }
    else if (1920 == screenHeight && 1080 == screenWidth) {
        deviceSize = DeviceScreenType5_5;
    }
    else if (2436 == screenHeight && 1125 == screenWidth) {
        deviceSize = DeviceScreenType5_8;
    }
    else if (1792 == screenHeight && 828 == screenWidth) {
        deviceSize = DeviceScreenType6_1;
    }
    else if (2688 == screenHeight && 1242 == screenWidth) {
        deviceSize = DeviceScreenType6_5;
    }
    else if (2048 == screenHeight && 1536 == screenWidth) {
        deviceSize = DeviceScreenType9_7;
    }
    else if (2224 == screenHeight && 1668 == screenWidth) {
        deviceSize = DeviceScreenType10_5;
    }
    else if (2388 == screenHeight && 1668 == screenWidth) {
        deviceSize = DeviceScreenType11;
    }
    else if (2732 == screenHeight && 2048 == screenWidth) {
        deviceSize = DeviceScreenType12_9;
    }
    
    return deviceSize;
}
*/
@end

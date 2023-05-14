//
//  MHPLogger.h
//  MHP3RD
//
//  Created by LeonDeng on 2023/5/14.
//  Copyright © 2023 Ivan_deng. All rights reserved.
//

#ifndef MHPLogger_h
#define MHPLogger_h

#import <MHP3RD-Swift.h>
#import <Foundation/Foundation.h>
#import <UIkit/UIkit.h>

#define force_inline __inline__ __attribute__((always_inline))

typedef NS_ENUM(NSUInteger, MHPLogLevel) {
    MHPLogLevelVerbose,
    MHPLogLevelDebug,
    MHPLogLevelInfo,
    MHPLogLevelWarning,
    MHPLogLevelError,
};

force_inline void mhp_log(MHPLogLevel level, NSString *message) {
    switch (level) {
        case MHPLogLevelVerbose: {
            [SwiftyBeaverBridge.sharedBridge logVerbose:message];
        } break;

        case MHPLogLevelDebug: {
            [SwiftyBeaverBridge.sharedBridge logDebug:message];
        } break;

        case MHPLogLevelInfo: {
            [SwiftyBeaverBridge.sharedBridge logInfo:message];
        } break;

        case MHPLogLevelWarning: {
            [SwiftyBeaverBridge.sharedBridge logWarning:message];
        } break;

        case MHPLogLevelError: {
            [SwiftyBeaverBridge.sharedBridge logError:message];
        } break;
    }
}

#define MHPLogWithLevel(logLevel, format, ...) mhp_log(logLevel, [NSString stringWithFormat:(format), ##__VA_ARGS__])

#define MHPLog(format, ...) MHPLogWithLevel(MHPLogLevelDebug, format, ##__VA_ARGS__)

#endif /* MHPLogger_h */

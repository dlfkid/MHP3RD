//
//  SwiftyBeaverBridge.swift
//  MHP3RD
//
//  Created by LeonDeng on 2023/5/14.
//  Copyright © 2023 Ivan_deng. All rights reserved.
//

import SwiftyBeaver

@objc class SwiftyBeaverBridge: NSObject {
    @objc static let sharedBridge = SwiftyBeaverBridge()
    
    let log = SwiftyBeaver.self
    
    override init() {
        // add log destinations. at least one is needed!
        let console = ConsoleDestination()  // log to Xcode Console

        // use custom format and set console output to short time, log level & message
        console.format = "$DHH:mm:ss$d $L $M $X"
        // or use this for JSON output: console.format = "$J"

        // add the destinations to SwiftyBeaver
        log.addDestination(console)
    }
    
    @objc public func logVerbose(_ message: String) {
        self.log.verbose(message)
    }
    
    @objc public func logDebug(_ message: String) {
        self.log.debug(message)
    }
    
    @objc public func logInfo(_ message: String) {
        self.log.info(message)
    }
    
    @objc public func logWarning(_ message: String) {
        self.log.warning(message)
    }
    
    @objc public func logError(_ message: String) {
        self.log.error(message)
    }
}

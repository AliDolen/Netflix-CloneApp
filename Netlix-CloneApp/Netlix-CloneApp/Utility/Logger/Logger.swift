//
//  Logger.swift
//  Netlix-CloneApp
//
//  Created by ali dölen on 8.08.2022.
//

import Foundation

struct Logger {
    
    enum LogType: String {
        case pageInit = "INIT: ->"
        case deinitPage = "DEINIT: ->"
        case error = "Job failed: ->"
        case success = "Task done for: ->"
    }
    
    static func log(_ logType: LogType, _ message: String ) {
        print(logType.rawValue, message)
    }
    
}

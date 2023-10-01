//
//  DataTransferErrorLogger.swift
//  ga-starwars-swift
//
//  Created by Developer on 01/10/2023.
//

import Foundation
import CodeBureau
import URLDataTransfer

// MARK: - DataTransferErrorLogger Type

public struct DataTransferErrorLogger: DataTransferErrorLoggable {
    
    public func log(error: Error) {
        debugPrint(.linebreak, "------------")
        debugPrint(.error, error.localizedDescription)
    }
}

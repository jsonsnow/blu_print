//
//  WGPrintOperation.swift
//  WeAblum
//
//  Created by chen liang on 2019/5/14.
//  Copyright © 2019 WeAblum. All rights reserved.
//

import Foundation

protocol PrintStatusProtocol {
    func printFinsh()
    func printCancel()
}
class WGPrintOperation: Operation, PrintStatusProtocol {
    
    func printFinsh() {
        self.willChangeValue(forKey: "isFinished")
        self.wg_finished = true
        self.didChangeValue(forKey: "isFinished")
        
        self.willChangeValue(forKey: "isExecuting")
        self.wg_executing = false
        self.didChangeValue(forKey: "isExecuting")
    }
    
    func printCancel() {
        self.willChangeValue(forKey: "isFinished")
        self.wg_finished = true
        self.didChangeValue(forKey: "isFinished")
        
        self.willChangeValue(forKey: "isCancelled")
        self.wg_cancel = true
        self.didChangeValue(forKey: "isCancelled")
        
        self.willChangeValue(forKey: "isExecuting")
        self.wg_executing = false
        self.didChangeValue(forKey: "isExecuting")
    }
    
    func pause() -> Void {
        self.willChangeValue(forKey: "isExecuting")
        self.wg_executing = false
        self.didChangeValue(forKey: "isExecuting")
    }
    
    
    fileprivate var operationCallback: ((_ operation: PrintStatusProtocol) -> Void)?
    fileprivate var wg_finished: Bool = false
    fileprivate var wg_executing: Bool = false
    fileprivate var wg_cancel: Bool = false
    init(operation: @escaping (_ operation: PrintStatusProtocol) -> Void) {
        self.operationCallback = operation
        super.init()
    }
    
    override func start() {
        if self.isCancelled {
            return;
        }
        self.willChangeValue(forKey: "isExecuting")
        self.wg_executing = true
        self.didChangeValue(forKey: "isExecuting")
        self.operationCallback?(self)
    }
    
    override func main() {
        
    }
    
    override var isExecuting: Bool {
        return wg_executing
    }
    
    override var isFinished: Bool {
        return wg_finished
    }
    
    override var isCancelled: Bool {
        return wg_cancel
    }
    
    
}

//
//  HTHandlerFactory.swift
//  SwiftLession01
//
//  Created by wjx on 2022/6/30.
//

import UIKit

class HTHandlerFactory: NSObject {
    
    
    var  handlers = Dictionary<String, Any>()
    static var sharedInstance = HTHandlerFactory()
    
    /**
     * @abstract Register a handler for a given handler instance and specific protocol
     *
     * @param handler The handler instance to register
     *
     * @param protocol The protocol to confirm
     *
     */
    static func registerHandler(handler:Any,pro:Protocol){
        
        HTHandlerFactory.sharedInstance.handlers[NSStringFromProtocol(pro)] = handler
//        [[HTHandlerFactory sharedInstance].handlers setObject:handler forKey:NSStringFromProtocol(protocol)];
    }
    
    /**
     * @abstract Returns the handler for a given protocol
     *
     **/
    static func handlerForProtocol(pro:Protocol)->Any{
        let handler = HTHandlerFactory.sharedInstance.handlers[NSStringFromProtocol(pro)]
        return handler as Any;
    }
    
    /**
     * @abstract Returns the registered handlers.
     */
    static func handlerConfigs()->Dictionary<String,Any>{
        return HTHandlerFactory.sharedInstance.handlers
//        return Dictionary()
    }
    
}

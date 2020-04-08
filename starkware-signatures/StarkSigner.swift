//
//  StarkSigner.swift
//  starkware-signatures
//
//  Created by Miguel on 07/04/2020.
//  Copyright © 2020 Argent. All rights reserved.
//

import Foundation
import web3
import UIKit
import JavaScriptCore

private let context = JSContext()!

final class StarkSigner {
    struct Signature {
        let r: String
        let s: String
    }
    
    init() {
//        context.setObject(self.require,
//                          forKeyedSubscript: "require" as NSString)
        
        context.exceptionHandler = { context, exception in
            print(exception?.toString() ?? "")
        }
        
        guard let url = Bundle.main.url(forResource: "index.min", withExtension: "js"), let script = try? String(contentsOf: url) else {
            fatalError()
        }
        context.evaluateScript(script, withSourceURL: url)
    }
    
//    let require: @convention(block) (String) -> (JSValue?) = { path in
//        guard let resolved = Bundle.main.url(forResource: path, withExtension: nil)
//            else { print("Require: filename \(path) does not exist")
//                   return nil }
//
//        guard let fileContent = try? String(contentsOf: resolved)
//            else { return nil }
//
//        return context.evaluateScript(fileContent)
//    }

    func repl(_ string: String) -> String {
        return context.evaluateScript(string)?.toString() ?? ""
    }
    
    func sign(message: String, using key: String) -> Signature {
        let script = """
            sw_keyPair = starkwareCrypto.getKeyPair(sw_privateKey);
            sw_msgSignature = starkwareCrypto.sign(sw_keyPair, sw_unsignedMsg);
            signed_r = sw_msgSignature.r.toString(16);
            signed_s = sw_msgSignature.s.toString(16);
        """
        
        context.setObject(key, forKeyedSubscript: "sw_privateKey" as NSString)
        context.setObject(message, forKeyedSubscript: "sw_unsignedMsg" as NSString)

        context.evaluateScript(script)
        
        return Signature(r: context.objectForKeyedSubscript("signed_r")?.toString() ?? "",
                         s: context.objectForKeyedSubscript("signed_s")?.toString() ?? "")
    }
}

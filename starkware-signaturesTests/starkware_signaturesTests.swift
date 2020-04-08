//
//  starkware_signaturesTests.swift
//  starkware-signaturesTests
//
//  Created by Miguel on 07/04/2020.
//  Copyright © 2020 Argent. All rights reserved.
//

import XCTest
import Quick
import Nimble
@testable import starkware_signatures

// Replicates these tests:
// https://github.com/starkware-libs/starkex-resources/blob/master/crypto/starkware/crypto/signature/signature_test.js

class Tests: QuickSpec {
    override func spec() {
        describe("starkware integration") {
            let signer = StarkSigner()
            let key = "0x2dccce1da22003777062ee0870e9881b460a8b7eca276870f57c601f182136c"
            
            it("repl works") {
                let script = """
                    sw_keyPair = starkwareCrypto.getKeyPair('2dccce1da22003777062ee0870e9881b460a8b7eca276870f57c601f182136c');
                    starkwareCrypto.getPrivate(sw_keyPair)
                """
                
                expect(signer.repl(script)) == "02dccce1da22003777062ee0870e9881b460a8b7eca276870f57c601f182136c"
            }
            
            it("signs message of length 61") {
                let signed = signer.sign(message: "c465dd6b1bbffdb05442eb17f5ca38ad1aa78a6f56bf4415bdee219114a47", using: key.web3.noHexPrefix)
                expect(signed.r) == "5f496f6f210b5810b2711c74c15c05244dad43d18ecbbdbe6ed55584bc3b0a2"
                expect(signed.s) == "4e8657b153787f741a67c0666bad6426c3741b478c8eaa3155196fc571416f3"
            }
            
            it("signs message of length 61 zeroes") {
                let signed = signer.sign(message: "00c465dd6b1bbffdb05442eb17f5ca38ad1aa78a6f56bf4415bdee219114a47", using: key.web3.noHexPrefix)
                expect(signed.r) == "5f496f6f210b5810b2711c74c15c05244dad43d18ecbbdbe6ed55584bc3b0a2"
                expect(signed.s) == "4e8657b153787f741a67c0666bad6426c3741b478c8eaa3155196fc571416f3"
            }

            it("signs message of length 62") {
                let signed = signer.sign(message: "c465dd6b1bbffdb05442eb17f5ca38ad1aa78a6f56bf4415bdee219114a47a", using: key.web3.noHexPrefix)
                expect(signed.r) == "233b88c4578f0807b4a7480c8076eca5cfefa29980dd8e2af3c46a253490e9c"
                expect(signed.s) == "28b055e825bc507349edfb944740a35c6f22d377443c34742c04e0d82278cf1"
            }

            it("signs message of length 63") {
                let signed = signer.sign(message: "7465dd6b1bbffdb05442eb17f5ca38ad1aa78a6f56bf4415bdee219114a47a1", using: key.web3.noHexPrefix)
                expect(signed.r) == "b6bee8010f96a723f6de06b5fa06e820418712439c93850dd4e9bde43ddf"
                expect(signed.s) == "1a3d2bc954ed77e22986f507d68d18115fa543d1901f5b4620db98e2f6efd80"
            }
        }
    }
}

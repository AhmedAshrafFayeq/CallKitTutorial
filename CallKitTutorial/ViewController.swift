//
//  ViewController.swift
//  CallKitTutorial
//
//  Created by Ahmed Fayek on 6/24/21.
//

import UIKit
import CallKit

class ViewController: UIViewController,CXProviderDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
          
        //recieveACall()
        //sendACall()
//        connectACall()
        
        customizeCallKit()
        
    }
    
    func providerDidReset(_ provider: CXProvider) {
        
    }
    
    func provider(_ provider: CXProvider, perform action: CXAnswerCallAction) {
        action.fulfill()
    }

    func provider(_ provider: CXProvider, perform action: CXEndCallAction) {
        action.fulfill()
    }
    


    func recieveACall(){
        let provider = CXProvider(configuration:
                                    CXProviderConfiguration())
                provider.setDelegate(self, queue: nil)
                let update = CXCallUpdate()
                update.remoteHandle = CXHandle(type: .generic, value: "FAYEQ")
                provider.reportNewIncomingCall(with: UUID(), update: update, completion: { error in })
    }
    
    
    func sendACall(){
        let provider = CXProvider(configuration: CXProviderConfiguration())
                provider.setDelegate(self, queue: nil)
                let controller = CXCallController()
                let transaction = CXTransaction(action: CXStartCallAction(call: UUID(), handle: CXHandle(type: .generic, value: "FAYEQ")))
                controller.request(transaction, completion: { error in })
    }
    
    func connectACall(){
        let provider = CXProvider(configuration: CXProviderConfiguration())
                provider.setDelegate(self, queue: nil)
                let controller = CXCallController()
                let transaction = CXTransaction(action: CXStartCallAction(call: UUID(), handle: CXHandle(type: .generic, value: "FAYEQ")))
                controller.request(transaction, completion: { error in })

                DispatchQueue.main.asyncAfter(wallDeadline: DispatchWallTime.now() + 5) {
                    provider.reportOutgoingCall(with: controller.callObserver.calls[0].uuid, connectedAt: nil)
                }
    }
    
    func customizeCallKit(){
        let config = CXProviderConfiguration()
        config.iconTemplateImageData = UIImage(named: "fayeqImg")!.pngData()
                config.ringtoneSound = "ringtone.caf"
                config.includesCallsInRecents = false;
                config.supportsVideo = true;
                let provider = CXProvider(configuration: config)
                provider.setDelegate(self, queue: nil)
                let update = CXCallUpdate()
                update.remoteHandle = CXHandle(type: .generic, value: "FAYEQ")
                update.hasVideo = true
                provider.reportNewIncomingCall(with: UUID(), update: update, completion: { error in })
    }

}


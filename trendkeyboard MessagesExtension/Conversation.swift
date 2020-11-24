//
//  Conversation.swift
//  trendkeyboard MessagesExtension
//
//  Created by Kaya Jones on 11/15/20.
//

import UIKit
import Messages

class Conversation: MSConversation {
    override func insert(_ sticker: MSSticker, completionHandler: ((Error?) -> Void)? = nil) {
        super.insert(sticker, completionHandler: nil)
    }
}

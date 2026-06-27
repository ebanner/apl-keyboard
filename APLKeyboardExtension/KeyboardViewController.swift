//
//  KeyboardViewController.swift
//  APLKeyboardExtension
//
//  Created by Edward Banner on 6/27/26.
//

import UIKit
import KeyboardKit
import SwiftUI

class APLActionHandler: KeyboardAction.StandardActionHandler {

    private weak var inputController: KeyboardInputViewController?

    init(inputController: KeyboardInputViewController) {
        self.inputController = inputController
        super.init(
            controller: inputController,
            keyboardContext: inputController.state.keyboardContext,
            keyboardBehavior: inputController.services.keyboardBehavior,
            autocompleteContext: inputController.state.autocompleteContext,
            autocompleteService: inputController.services.autocompleteService,
            emojiContext: inputController.state.emojiContext,
            feedbackContext: inputController.state.feedbackContext,
            feedbackService: inputController.services.feedbackService,
            keyboardAppContext: inputController.state.keyboardAppContext,
            spacebarDragGestureHandler: inputController.services.spacebarDragGestureHandler
        )
    }

    override func handle(
        _ gesture: Keyboard.Gesture,
        on action: KeyboardAction
    ) {
        if case .character(let char) = action, char == "a" || char == "A" {
            if gesture == .release {
                let output = char == "A" ? "B" : "b"
                inputController?.textDocumentProxy.insertText(output)
            }
            return
        }
        super.handle(gesture, on: action)
    }
}

class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboardKit(for: KeyboardApp(name: "APLKeyboard"))
    }

    override func viewWillSetupKeyboardView() {
        setupKeyboardView { controller in
            KeyboardView(
                services: controller.services,
                buttonContent: { item, view in
                    if case .character(let char) = item.action, char == "a" || char == "A" {
                        AnyView(Text(char == "A" ? "B" : "b"))
                    } else {
                        AnyView(view)
                    }
                },
                buttonView: { item, view in
                    AnyView(view)
                }
            )
        }
        services.actionHandler = APLActionHandler(inputController: self)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        services.actionHandler = APLActionHandler(inputController: self)
    }
}

//
//  KeyboardViewController.swift
//  APLKeyboardExtension
//
//  Created by Edward Banner on 6/27/26.
//

import UIKit
import KeyboardKit

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
        if gesture == .release, case .character(let char) = action, char == "a" {
            inputController?.textDocumentProxy.insertText("b")
            return
        }
        super.handle(gesture, on: action)
    }
}

class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        services.actionHandler = APLActionHandler(inputController: self)
        setupKeyboardKit(for: KeyboardApp(name: "APLKeyboard"))
    }

    override func viewWillSetupKeyboardView() {
        setupKeyboardView { controller in
            KeyboardView(services: controller.services)
        }
    }
}

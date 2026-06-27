//
//  KeyboardViewController.swift
//  APLKeyboardExtension
//
//  Created by Edward Banner on 6/27/26.
//

import KeyboardKit

class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboardKit(for: KeyboardApp(name: "APLKeyboard"))
    }

    override func viewWillSetupKeyboardView() {
        setupKeyboardView { controller in
            KeyboardView(services: controller.services)
        }
    }
}

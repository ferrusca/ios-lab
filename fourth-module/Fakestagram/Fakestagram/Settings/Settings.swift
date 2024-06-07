//
//  This file is for educational purposes only. It may contain code snippets, examples, images, and explanations
//  intended to help understand concepts and improve programming skills.
//

import Foundation

struct Settings {
    static var user: User? {
        return nil
    }
    static var hideCaptions: Bool {
        get {
            UserDefaults.standard.bool(forKey: "hideCaption")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "hideCaption")
        }
    }
}

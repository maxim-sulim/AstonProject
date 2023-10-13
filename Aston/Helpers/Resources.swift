//
//  Resources.swift
//  Aston
//
//  Created by Максим Сулим on 09.10.2023.
//

import UIKit

enum Resources {
    enum Color {
        static let blackBackGround = UIColor(hexString: "#040C1E")
        static let poisonousGreen = UIColor(hexString: "#47C60B")
        static let blackGrayBackGround = UIColor(hexString: "#262A38")
        static let backOriginGround = UIColor(hexString: "191C2A")
        static let infoLightGray = UIColor(hexString: "#C4C9CE")
        static let infoWhite = UIColor(hexString: "#FFF")
    }
    
    enum TitleView {
        enum AuthView: String {
            case titleButton = "Sign In"
            case titleLabelLogin = "Login"
            case titleLabelPassword = "Password"
            case placeholderLogin = "Enter your login"
            case placeholderPassword = "Enter your password"
        }
        
        enum TabBarItemTitle: String {
            case chars = "Characters"
            case logout = "Logout"
        }
        
        enum CharsView {
            static let titleNameLabel = "Name"
            static let titleStatusLabel = "Status"
            static let noneDataChar = "None"
            static let nonDataImage = UIImage(named: "defImage")?.pngData()
        }
    }
    
    enum LayoutView {
        enum AuthView {
            static let heightMainContainer = 210
            static let widhtMainContainer = 250
            static let heightButtonSignIn = 40
            static let corRadiusMain: CGFloat = 20
            static let corRadiusTextField: CGFloat = 6
        }
        
        enum CharsView {
            static let heightTableRow: CGFloat = 135
            static let countRowNoneData = 0
            static let heightWidhtImageChar = 80
            
        }
    }
}

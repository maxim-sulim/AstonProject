//
//  Resources.swift
//  Aston
//
//  Created by Максим Сулим on 09.10.2023.
//

import UIKit

enum Resources {
    
    enum ServiceName: String {
        case serviceName = "AstonUser"
    }
    
    enum Color {
        static let blackBackGround = UIColor(hexString: "#040C1E")
        static let poisonousGreen = UIColor(hexString: "#47C60B")
        static let lightPoisonousGreen = UIColor(hexString: "#47C60B").withAlphaComponent(0.7)
        static let blackGrayBackGround = UIColor(hexString: "#262A38")
        static let grayButtonInoutBackGround = UIColor(hexString: "#262A38").withAlphaComponent(0.5)
        static let backOriginGround = UIColor(hexString: "191C2A")
        static let infoLightGray = UIColor(hexString: "#C4C9CE")
        static let infoWhite = UIColor(hexString: "#FFF")
    }
    
    enum TitleView {
        
        enum AuthView: String {
            case titleButtonDef = "Sign In"
            case titleButtonEnter = "Enter"
            case titleLabelLogin = "Login"
            case titleLabelPassword = "Password"
            case placeholderLogin = "Enter your login"
            case placeholderPassword = "Enter your password"
            case titleRegistration = "Registration"
            case titleAuthorization = "Authorization"
            
            enum AlertError {
                static let alertUserLife = (title: "Error", message: "This user exists")
                static let alertNotPassword = (title: "Error", message: "Invalid password")
                static let alertInvalidPassword = (title: "Invalid password", message: "Enter the correct password")
            }
        }
        
        enum TabBarItemTitle: String {
            case chars = "Characters"
            case logout = "General"
            case systemNameFitstItem = "person.2.circle.fill"
            case systemNameTwoItem = "gearshape.fill"
        }
        
        enum CharsView {
            static let titleNameLabel = "Name"
            static let titleStatusLabel = "Status"
            static let noneDataChar = "None"
            static let nonDataImage = UIImage(named: "defImage")?.pngData()
        }
        
        enum EpisodesView: String {
            case noneDataEpisode = "None data or episode"
            case titleLabelNumber = "Number Episode"
            case titleLabelName = "Name Episode"
            case titleLabelDate = "Date Episode"
        }
        
        enum LogoutView {
            static let title = "General"
            static let outButton = (title: "Exit", subtitle: "Authorization screen")
            static let editButton = (title: "Edit", subtitle: "Password")
            static let alertEditPassword = (title: "Edit passwort",
                                            message: "Enter a new password",
                                            placeholderTextField: "New password")
        }
    }
    
    enum LayoutView {
        enum AuthView {
            static let boundsMainContainer = (height: 210, widht: 250)
            static let heightButtonSignIn = 40
            static let corRadiusMain: CGFloat = 20
            static let corRadiusTextField: CGFloat = 6
        }
        
        enum CharsView {
            static let heightTableRow: CGFloat = 150
            static let countRowNoneData = 0
            static let boundsImageChar = (height: 90, widht: 90)
            static let corRadius: CGFloat = 10
            static let reserveRows = 5
            static let maxCountChars = 900
        }
        
        enum EpisodeView {
            static let heightCollectionRow: CGFloat = 70
            static let spaceCollectionRow: CGFloat = 20
            static let collectionLayoutInsets: CGFloat = 16
            static let spacingForSection: CGFloat = 20
        }
    }
}

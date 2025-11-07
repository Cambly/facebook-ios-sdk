// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

// Copyright (c) 2016-present, Facebook, Inc. All rights reserved.
//
// You are hereby granted a non-exclusive, worldwide, royalty-free license to use,
// copy, modify, and distribute this software in source code or binary form for use
// in connection with the web services and APIs provided by Facebook.
//
// As with any software that integrates with the Facebook platform, your use of
// this software is subject to the Facebook Developer Principles and Policies
// [http://developers.facebook.com/policy/]. This copyright notice shall be
// included in all copies or substantial portions of the software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import PackageDescription

let package = Package(
    name: "Facebook",
    platforms: [
        .iOS(.v9),
        .tvOS(.v10)
    ],
    products: [
        // MARK: - Core SDK (Swift)
        // The Core SDK library that provides modern Swift interface
        .library(
            name: "FacebookCore",
            targets: ["FacebookCore"]
        ),
        
        // MARK: - Core SDK (Objective-C)
        // Legacy Objective-C interface for backwards compatibility
        .library(
            name: "FBSDKCoreKit",
            targets: ["FBSDKCoreKit"]
        ),
        
        // MARK: - Login SDK (Swift)
        // Facebook Login SDK - Swift interface
        .library(
            name: "FacebookLogin",
            targets: ["FacebookLogin"]
        ),
        
        // MARK: - Login SDK (Objective-C)
        // Facebook Login SDK - Objective-C interface
        .library(
            name: "FBSDKLoginKit",
            targets: ["FBSDKLoginKit"]
        ),
        
        // MARK: - Share SDK (Swift)
        // Facebook Share SDK - Swift interface
        .library(
            name: "FacebookShare",
            targets: ["FacebookShare"]
        ),
        
        // MARK: - Share SDK (Objective-C)
        // Facebook Share SDK - Objective-C interface
        .library(
            name: "FBSDKShareKit",
            targets: ["FBSDKShareKit"]
        ),
        
        // MARK: - Gaming Services SDK (Swift)
        // Facebook Gaming Services SDK - Swift interface
        .library(
            name: "FacebookGamingServices",
            targets: ["FacebookGamingServices"]
        ),
        
        // MARK: - Gaming Services SDK (Objective-C)
        // Facebook Gaming Services SDK - Objective-C interface
        .library(
            name: "FBSDKGamingServicesKit",
            targets: ["FBSDKGamingServicesKit"]
        ),
        
        // MARK: - TVOS SDK
        // Facebook TVOS SDK
        .library(
            name: "FacebookTVOS",
            targets: ["FBSDKTVOSKit"]
        )
    ],
    targets: [
        // MARK: - FBSDKCoreKit_Basics
        // The kernel module for the Core Facebook SDK
        .target(
            name: "FBSDKCoreKit_Basics",
            path: "Sources/FBSDKCoreKit_Basics",
            publicHeadersPath: "include",
            cSettings: [
                .headerSearchPath("."),
                .define("FBSDK_SWIFT_PACKAGE")
            ],
            linkerSettings: [
                .linkedLibrary("z")
            ]
        ),
        
        // MARK: - LegacyCoreKit
        // The legacy Objective-C implementation that will be converted to Swift.
        // This will not contain interfaces for new features written in Swift.
        .target(
            name: "LegacyCoreKit",
            dependencies: ["FBSDKCoreKit_Basics"],
            path: "FBSDKCoreKit/FBSDKCoreKit",
            exclude: [
                "include",
                "Info.plist",
                "FBSDKCoreKit.modulemap",
                "PrivacyInfo.xcprivacy",
                "FacebookSDKStrings.bundle"
            ],
            sources: [
                ".",
                "AppEvents",
                "AppLink",
                "GraphAPI",
                "Internal"
            ],
            resources: [
                .copy("FacebookSDKStrings.bundle")
            ],
            cSettings: [
                .headerSearchPath("."),
                .headerSearchPath("AppEvents"),
                .headerSearchPath("AppEvents/Internal"),
                .headerSearchPath("AppEvents/Internal/AAM"),
                .headerSearchPath("AppEvents/Internal/AEM"),
                .headerSearchPath("AppEvents/Internal/Codeless"),
                .headerSearchPath("AppEvents/Internal/ViewHierarchy"),
                .headerSearchPath("AppEvents/Internal/ML"),
                .headerSearchPath("AppEvents/Internal/Integrity"),
                .headerSearchPath("AppEvents/Internal/EventDeactivation"),
                .headerSearchPath("AppEvents/Internal/SKAdNetwork"),
                .headerSearchPath("AppEvents/Internal/SuggestedEvents"),
                .headerSearchPath("AppLink"),
                .headerSearchPath("AppLink/Internal"),
                .headerSearchPath("GraphAPI"),
                .headerSearchPath("Internal"),
                .headerSearchPath("Internal/Base64"),
                .headerSearchPath("Internal/BridgeAPI"),
                .headerSearchPath("Internal/BridgeAPI/ProtocolVersions"),
                .headerSearchPath("Internal/Cryptography"),
                .headerSearchPath("Internal/Device"),
                .headerSearchPath("Internal/ErrorRecovery"),
                .headerSearchPath("Internal/FeatureManager"),
                .headerSearchPath("Internal/Instrument"),
                .headerSearchPath("Internal/Instrument/CrashReport"),
                .headerSearchPath("Internal/Instrument/ErrorReport"),
                .headerSearchPath("Internal/Monitoring"),
                .headerSearchPath("Internal/Network"),
                .headerSearchPath("Internal/ServerConfiguration"),
                .headerSearchPath("Internal/TokenCaching"),
                .headerSearchPath("Internal/UI"),
                .headerSearchPath("Internal/WebDialog"),
                .define("FBSDK_SWIFT_PACKAGE")
            ],
            linkerSettings: [
                .linkedFramework("Accelerate"),
                .linkedLibrary("c++"),
                .linkedLibrary("stdc++")
            ]
        ),
        
        // MARK: - FacebookCore
        // The main Core SDK module (Swift interface)
        .target(
            name: "FacebookCore",
            dependencies: ["LegacyCoreKit"],
            path: "Sources/FacebookCore",
            exclude: ["Exports.swift"],
            cSettings: [
                .headerSearchPath("../../FBSDKCoreKit/FBSDKCoreKit"),
                .headerSearchPath("../../FBSDKCoreKit/FBSDKCoreKit/Internal"),
                .define("FBSDK_SWIFT_PACKAGE")
            ],
            swiftSettings: [
                .define("FBSDK_SWIFT_PACKAGE")
            ]
        ),
        
        // MARK: - FBSDKCoreKit
        // The legacy Objective-C interface wrapper
        .target(
            name: "FBSDKCoreKit",
            dependencies: ["LegacyCoreKit"],
            path: "FBSDKCoreKit/FBSDKCoreKit",
            exclude: [
                "AppEvents",
                "AppLink",
                "GraphAPI",
                "Internal",
                "Info.plist",
                "FBSDKCoreKit.modulemap",
                "PrivacyInfo.xcprivacy",
                "FacebookSDKStrings.bundle"
            ],
            sources: [],
            publicHeadersPath: "include",
            cSettings: [
                .headerSearchPath("."),
                .headerSearchPath("Internal"),
                .define("FBSDK_SWIFT_PACKAGE")
            ]
        ),
        
        // MARK: - FBSDKLoginKit
        // The legacy Objective-C implementation for Login
        .target(
            name: "FBSDKLoginKit",
            dependencies: ["LegacyCoreKit"],
            path: "FBSDKLoginKit/FBSDKLoginKit",
            exclude: [
                "Swift",
                "Info.plist",
                "FBSDKLoginKit.modulemap",
                "PrivacyInfo.xcprivacy"
            ],
            sources: [".", "Internal"],
            publicHeadersPath: "include",
            cSettings: [
                .headerSearchPath("."),
                .headerSearchPath("Internal"),
                .headerSearchPath("../../FBSDKCoreKit/FBSDKCoreKit"),
                .headerSearchPath("../../FBSDKCoreKit/FBSDKCoreKit/Internal"),
                .define("FBSDK_SWIFT_PACKAGE")
            ]
        ),
        
        // MARK: - FacebookLogin
        // The main Login SDK module (Swift interface)
        .target(
            name: "FacebookLogin",
            dependencies: ["FacebookCore", "FBSDKLoginKit"],
            path: "FBSDKLoginKit/FBSDKLoginKit/Swift",
            exclude: ["Exports.swift"],
            cSettings: [
                .headerSearchPath("../../FBSDKCoreKit/FBSDKCoreKit"),
                .headerSearchPath("../../FBSDKCoreKit/FBSDKCoreKit/Internal"),
                .define("FBSDK_SWIFT_PACKAGE")
            ],
            swiftSettings: [
                .define("FBSDK_SWIFT_PACKAGE"),
                .define("TARGET_OS_TV", .when(platforms: [.tvOS]))
            ]
        ),
        
        // MARK: - FBSDKShareKit
        // The legacy Objective-C implementation for Share
        .target(
            name: "FBSDKShareKit",
            dependencies: ["FBSDKCoreKit"],
            path: "FBSDKShareKit/FBSDKShareKit",
            exclude: [
                "Swift",
                "include",
                "Info.plist",
                "FBSDKShareKit.modulemap"
            ],
            sources: [".", "Internal"],
            cSettings: [
                .headerSearchPath("."),
                .headerSearchPath("Internal"),
                .headerSearchPath("../../FBSDKCoreKit/FBSDKCoreKit"),
                .headerSearchPath("../../FBSDKCoreKit/FBSDKCoreKit/Internal"),
                .define("FBSDK_SWIFT_PACKAGE")
            ]
        ),
        
        // MARK: - FacebookShare
        // The main Share SDK module (Swift interface)
        .target(
            name: "FacebookShare",
            dependencies: ["FacebookCore", "FBSDKShareKit"],
            path: "FBSDKShareKit/FBSDKShareKit/Swift",
            exclude: ["Exports.swift"],
            cSettings: [
                .headerSearchPath("../../FBSDKCoreKit/FBSDKCoreKit"),
                .headerSearchPath("../../FBSDKCoreKit/FBSDKCoreKit/Internal"),
                .define("FBSDK_SWIFT_PACKAGE")
            ],
            swiftSettings: [
                .define("FBSDK_SWIFT_PACKAGE")
            ]
        ),
        
        // MARK: - FBSDKGamingServicesKit
        // The legacy Objective-C implementation for Gaming Services
        .target(
            name: "FBSDKGamingServicesKit",
            dependencies: ["FBSDKCoreKit"],
            path: "FBSDKGamingServicesKit/FBSDKGamingServicesKit",
            exclude: [
                "Swift",
                "include",
                "Info.plist",
                "FBSDKGamingServicesKit.modulemap"
            ],
            sources: [".", "Internal"],
            cSettings: [
                .headerSearchPath("."),
                .headerSearchPath("Internal"),
                .headerSearchPath("../../FBSDKCoreKit/FBSDKCoreKit"),
                .headerSearchPath("../../FBSDKCoreKit/FBSDKCoreKit/Internal"),
                .headerSearchPath("../../FBSDKShareKit/FBSDKShareKit"),
                .headerSearchPath("../../FBSDKShareKit/FBSDKShareKit/Internal"),
                .define("FBSDK_SWIFT_PACKAGE")
            ]
        ),
        
        // MARK: - FacebookGamingServices
        // The main Gaming Services SDK module (Swift interface)
        .target(
            name: "FacebookGamingServices",
            dependencies: ["FacebookCore", "FBSDKGamingServicesKit"],
            path: "FBSDKGamingServicesKit/FBSDKGamingServicesKit/Swift",
            cSettings: [
                .headerSearchPath("../../FBSDKCoreKit/FBSDKCoreKit"),
                .headerSearchPath("../../FBSDKCoreKit/FBSDKCoreKit/Internal"),
                .define("FBSDK_SWIFT_PACKAGE")
            ],
            swiftSettings: [
                .define("FBSDK_SWIFT_PACKAGE")
            ]
        ),
        
        // MARK: - FBSDKTVOSKit
        // The TVOS SDK module
        .target(
            name: "FBSDKTVOSKit",
            dependencies: ["FBSDKCoreKit", "FBSDKShareKit", "FBSDKLoginKit"],
            path: "FBSDKTVOSKit/FBSDKTVOSKit",
            exclude: [
                "Info.plist"
            ],
            cSettings: [
                .headerSearchPath("."),
                .headerSearchPath("../../FBSDKCoreKit/FBSDKCoreKit"),
                .headerSearchPath("../../FBSDKCoreKit/FBSDKCoreKit/Internal"),
                .define("FBSDK_SWIFT_PACKAGE", .when(platforms: [.tvOS]))
            ]
        )
    ],
    cxxLanguageStandard: .cxx11
)

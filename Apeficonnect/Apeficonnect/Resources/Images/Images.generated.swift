// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal static let addGoalBg = ImageAsset(name: "addGoalBg")
  internal static let advicesBg = ImageAsset(name: "advicesBg")
  internal static let aggressive = ImageAsset(name: "aggressive ")
  internal static let balanced = ImageAsset(name: "balanced")
  internal static let conservative = ImageAsset(name: "conservative")
  internal static let cost = ImageAsset(name: "cost")
  internal static let cup = ImageAsset(name: "cup")
  internal static let financeTrackerBg = ImageAsset(name: "financeTrackerBg")
  internal static let financeTrackerBottomBg = ImageAsset(name: "financeTrackerBottomBg")
  internal static let goalsBottomBg = ImageAsset(name: "goalsBottomBg")
  internal static let goalsTopBg = ImageAsset(name: "goalsTopBg")
  internal static let homeBg = ImageAsset(name: "homeBg")
  internal static let income = ImageAsset(name: "income")
  internal static let person = ImageAsset(name: "person")
  internal static let profilePlaceholder = ImageAsset(name: "profilePlaceholder")
  internal static let rate = ImageAsset(name: "rate")
  internal static let share = ImageAsset(name: "share")
  internal static let authLogo = ImageAsset(name: "authLogo")
  internal static let onboard1 = ImageAsset(name: "onboard1")
  internal static let onboard2 = ImageAsset(name: "onboard2")
  internal static let onboard3 = ImageAsset(name: "onboard3")
  internal static let logo = ImageAsset(name: "logo")
  internal static let preloaderBg = ImageAsset(name: "preloaderBg")
  internal static let preloaderLogo = ImageAsset(name: "preloaderLogo")
  internal static let preloaderTitle = ImageAsset(name: "preloaderTitle")
  internal static let advicesTab = ImageAsset(name: "advicesTab")
  internal static let goalsTab = ImageAsset(name: "goalsTab")
  internal static let plansTab = ImageAsset(name: "plansTab")
  internal static let startTab = ImageAsset(name: "startTab")
  internal static let trackerTab = ImageAsset(name: "trackerTab")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if os(iOS) || os(tvOS)
  @available(iOS 8.0, tvOS 9.0, *)
  internal func image(compatibleWith traitCollection: UITraitCollection) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  internal var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

internal extension ImageAsset.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
internal extension SwiftUI.Image {
  init(asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }

  init(asset: ImageAsset, label: Text) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type

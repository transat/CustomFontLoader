//
//  CustomFontLoader.swift
//
//
//  Created by Clément Girault on 26/4/2023.
//

import Combine
import SwiftUI

public class CustomFontLoader {
    
    public static func registerFonts(in subfolder: String? = nil) -> [String] {
        var fontNameMap: [String: String] = [:]
        
        guard let bundlePath = Bundle.main.resourceURL else {
            print("Failed to access the Resources folder.")
            return []
        }
        
        let subfolderURL = subfolder != nil ? bundlePath.appendingPathComponent(subfolder!) : bundlePath
        
        do {
            let fontFiles = try FileManager.default.contentsOfDirectory(at: subfolderURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            let fontFileExtensions = ["ttf", "otf"]
            
            for fontFile in fontFiles where fontFileExtensions.contains(fontFile.pathExtension) {
                if let fontDataProvider = CGDataProvider(url: fontFile as CFURL),
                   let newFont = CGFont(fontDataProvider) {
                    
                    var error: Unmanaged<CFError>?
                    if CTFontManagerRegisterGraphicsFont(newFont, &error) {
                        if let postScriptName = newFont.postScriptName as String? {
                            let filename = fontFile.lastPathComponent
                            fontNameMap[filename] = postScriptName
                        }
                    } else {
                        if let error = error?.takeRetainedValue() {
                            print("Failed to register font: \(error)")
                        } else {
                            print("Failed to register font.")
                        }
                    }
                } else {
                    print("Failed to load font from URL: \(fontFile)")
                }
            }
        } catch {
            print("Failed to find font files with error: \(error)")
        }
        
        FontNameMap.shared.setMap(fontNameMap)
        return fontNameMap.keys.sorted()
    }
}

public class FontNameMap: ObservableObject {
    public static let shared = FontNameMap()
    
    @Published public private(set) var map: [String: String] = [:]
    
    public func setMap(_ newMap: [String: String]) {
        map = newMap
    }
}

extension View {
    public func customFont(_ name: String, size: CGFloat) -> some View {
        guard let postScriptName = FontNameMap.shared.map[name] else {
            print("Failed to find the custom font named: \(name)")
            return self.font(.system(size: size))
        }
        
        return self.font(.custom(postScriptName, size: size))
    }
}

struct FontFilesKey: EnvironmentKey {
    static let defaultValue: [String] = []
}

extension EnvironmentValues {
    var fontFiles: [String] {
        get { self[FontFilesKey.self] }
        set { self[FontFilesKey.self] = newValue }
    }
}

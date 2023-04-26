# CustomFontLoader


A Swift package for easily loading and using custom fonts in SwiftUI applications.  


## Installation  

Add the CustomFontLoader package to your project using Swift Package Manager.  


## Usage  

1. Add your custom font files (TTF or OTF format) to your project's resources folder.
   
2. (Optional) If you want to organize your font files in a subfolder within the resources folder, create the subfolder and place the font files inside.
   
3. In your main App or Scene, call CustomFontLoader.registerFonts at startup:
   
   ```swift
   import CustomFontLoader
   @main
    struct YourApp: App {
        init() { CustomFontLoader.registerFonts(in: "OptionalSubfolderName") }
        var body: some Scene {
           WindowGroup { ContentView() }
        }
    }
    ```
    
4. In your SwiftUI views, use the customFont(_:size:) modifier to apply the custom font to a text element:
   
   ```swift
    import CustomFontLoader
    struct ContentView: View {
        var body: some View {
            Text("Hello, World!").customFont("YourFontFileName", size: 24)
        }
    }
    ```
    
    Replace "YourFontFileName" with the actual file name of the font you want to use, and adjust the font size as needed. The customFont(_:size:) modifier will automatically apply the correct font based on the provided file name.


## Example

The package includes a FontListView that demonstrates how to display a list of all registered fonts, allowing users to see the appearance of each font with a sample text. To use 
FontListView in your app, simply add it to your SwiftUI view hierarchy:

   ```swift 
   import CustomFontLoader
    struct ContentView: View {
        var body: some View {
            FontListView()
        }
    }
```
    

## License

This package is released under the MIT License. See LICENSE for details.}

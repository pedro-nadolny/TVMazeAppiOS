# TVMazeAppiOS
This is an iOS App based in the TVMaze API. Its experience try to follows Apple Humam Interface Guidelines and overall looks.

[Demo Video](https://imgur.com/YaFF1m7)

## Running
  That should be easy, you should be able to just open it and run it. The app do not use any third party dependency, so no need to download of fetch anything extra. It does contains local Swift Packages. In case you get error messages saying something like 'Missing package XYZ' do the following: 

1. Close XCode.
2. Open terminal in the same folder of `TVMaze.xcodeproj`
3. run `xcodebuild -resolvePackageDependencies`
4. Open XCode and try running Again!

## Changelog

01/01/2023
- List of shows with pagination
- Search bar for searching shows by name
- Show selection for more details
- Unit tests for `SeriesCatalogViewModel`
- Supports dark and light mode
- Implementation of [interface modules](https://swiftrocks.com/reducing-ios-build-times-by-using-interface-targets) for faster compiler times and healthier dependency graphs.
- Decorated View and ViewController to avoid multiple inheritance of UIView and UIViewcontroller, reducing the final app size.

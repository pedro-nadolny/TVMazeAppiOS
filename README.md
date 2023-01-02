# TVMazeAppiOS
This is an iOS App based in the TVMaze API. Its experience try to follows Apple Humam Interface Guidelines and overall looks.

## Running
  That should be easy. The app do not use any third party dependency, so no need to download of fetch anything extra. It does contains local Swift Packages. In case you get error messages saying some like 'Missing package XYZ' do the following: 

1. Close XCode.
2. Open terminal in the same folder of TVMaze.xcproj
3. run `xcodebuild -resolvePackageDependencies`
4. Open XCode and try running Again!

## Changelog

01/01/2023
- List of shows with pagination
- Search bar for searching shows by name
- Show selection for more details
- Unit tests for `SeriesCatalogViewModel`

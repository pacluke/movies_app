# Movies App
iOS application using [The Movie Database API](https://developers.themoviedb.org/3/)

| ![](https://github.com/pacluke/movies_app/blob/development/Movies/screenshots/screenshot01.png?raw=true)   | ![](https://github.com/pacluke/movies_app/blob/development/Movies/screenshots/screenshot02.png?raw=true)   |
|---|---|
|  ![](https://github.com/pacluke/movies_app/blob/development/Movies/screenshots/screenshot03.png?raw=true)  | ![](https://github.com/pacluke/movies_app/blob/development/Movies/screenshots/screenshot04.png?raw=true)   |

## MVC Architecture
It seemed more appropriate for the various views of the same data retrieved from The Movie Database API.

## Built with
* [Alamofire](https://github.com/Alamofire/Alamofire) - "Elegant HTTP Networking in Swift"
  * Used to help with api requests, handling the answer elegantly and helping to update the UI components.

* [Kingfisher](https://github.com/onevcat/Kingfisher) - "A lightweight, pure-Swift library for downloading and caching images from the web."
  * Library used to download movie images and keep cached. (100% Library in Swift).

* [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON) - "The better way to deal with JSON data in Swift."
  * It makes it easier to handle the JSON returned by the api requests. Swift is by default a JSON way of handling JSON, but it's complicated and rather "dirty," this library helps make the code cleaner and readable.

* [SwiftOverlays](https://github.com/peterprokop/SwiftOverlays) - "SwiftOverlays is a Swift GUI library for displaying various popups and notifications"
  * Used only to show loading popup while a request is completed.

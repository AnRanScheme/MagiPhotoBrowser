
<p align="center">
  <a href=#>
    <img src="https://github.com/AnRanScheme/MagiRefresh/blob/master/Assets/titleView.png" alt="" width=300 height=300>
  </a>

  <h3 align="center">MagiPhotoBrowser</h3> 
  
  <p align="center">
     PhotoBrowser is a highly customizable UI component, which is inherited from wechat.
    <br> 
    <br>
    <a href="https://github.com/AnRanScheme/MagiPhotoBrowser/issues/new">Commit Bug</a>
  .
    <a href="https://github.com/AnRanScheme/MagiPhotoBrowser/issues/new">Commit Question</a>  
  </p>
</p> 
<br>

****
[![CI Status](https://img.shields.io/travis/AnRanScheme/MagiPhotoBrowser.svg?style=flat)](https://travis-ci.org/AnRanScheme/MagiPhotoBrowser)
[![Version](https://img.shields.io/cocoapods/v/MagiPhotoBrowser.svg?style=flat)](https://cocoapods.org/pods/MagiPhotoBrowser)
[![License](https://img.shields.io/cocoapods/l/MagiPhotoBrowser.svg?style=flat)](https://cocoapods.org/pods/MagiPhotoBrowser)
[![Platform](https://img.shields.io/cocoapods/p/MagiPhotoBrowser.svg?style=flat)](https://cocoapods.org/pods/MagiPhotoBrowser)
[![Email](https://img.shields.io/badge/e--mail-andyscheme%40gmail.com-blue.svg)](mailto:andyscheme@gmail.com)
****


**With MagiPhotoBrowser, You can easily achieve these！**



-| Feature |Description
-------------|-------------|-------------
1| Default style | You can get system-like style by initializing the TabBar with MagiTabBarController directly.  </p> UITabBarController style: </p> ![System native style](Resources/SystemStyle.png) </p> MagiTabBarController default style: </p> ![Magi system-like style](Resources/CustomStyle.png)
2| Default style with "More" item | If the items are more than the maximum number of displays, there will be a "More" item. </p> UITabBarController with "More": </p> ![enter image description here](Resources/SystemMoreStyle.png) </p> EMagiTabBarController with "More": </p> ![enter image description here](Resources/CustomMoreStyle.png)
3| Mix UITabBarItem and MagiTabBarItem | You can set any item as you want, including UITabBarItem and MagiTabBarItem. </p> MagiTabBar and UITabBar mixed style: </p> ![enter image description here](Resources/MixtureStyle.png) </p> MagiTabBar and UITabBar mixed style with "More": </p> ![enter image description here](Resources/MixtureMoreStyle.png)
4| UIKit attributes | MagiTabBarController is compatible with UITabBarController, UITabBar and UITabBarItem's most API attributes. You can migrate to MagiTabBarController without any modification of the origin code.  </p> Compatible with UITabBarController's `selectedIndex`: </p> ![enter image description here](Resources/SelectIndexCode.png)
5| Any nesting with UINavigationController | Developing with`UITabBarController`, there are two common ways to handle layers: </p> First : </p> ├── UITabBarController </p> └──── UINavigationController </p> └────── UIViewController </p> └──────── SubviewControllers </p> Second : </p> ├── UINavigationController </p> └──── UITabBarController </p> └────── UIViewController </p> └──────── SubviewControllers </p> In the first case, need to set `hidesBottomBarWhenPushed = true` when pushing subViews. The second is not. </p> In MagiTabBarController, add Container views to UITabBar to be compatible with these two ways。
6| Customizable style | With MagiTabBarController, you can：</p> 1. Customize selected item's color and style: </p> ![enter image description here](Resources/CustomSelectStyleGif.gif) </p> 2. Add selecting animation:  </p> ![enter image description here](Resources/CustomSelectAnimateGif.gif) </p> 3. Customize item's background color: </p> ![enter image description here](Resources/CustomBackgroundGif.gif) </p> 4. Add highlight animation: </p> ![enter image description here](Resources/CustomHighlightGif.gif) </p> 5. Add animation to prompt users: </p> ![enter image description here](Resources/CustomImpliesGif.gif) </p> 6. And much more ... </p>
7| Customizable item's size </p> Customizable click event | You can easily customize item's size using MagiTabBarController. </p> **When the button's frame is larger than TabBar, through the use of HitTest to achieve making outer TabBar area click valid.** </p> In addition, MagiTabBarController can customize click event, and through a block to callback super-layer to handle. </p> With big item in the middle of TabBar: </p> ![enter image description here](Resources/CustomStyle2.png) </p> With a special hint style: </p> ![enter image description here](Resources/CustomStyle3.png) </p> Customize click event: </p> ![enter image description here](Resources/CustomHitGif.gif)
8| Default notification style |  You can get system-like notification style by initializing the TabBar with MagiTabBarController directly. </p> UITabBarController notification style: </p> ![enter image description here](Resources/SystemNotificationStyle.png) </p> MagiTabBarController system-like notification style: </p> ![enter image description here](Resources/CustomNotificationStyle.png)
9| Customizable notification style | With MagiTabBarController, you can：</p> 1. Customize notification animation: </p> ![enter image description here](Resources/CustomNofticationGif.gif) </p> ![enter image description here](Resources/CustomNofticationGif2.gif) </p> 2. Customize prompt style: </p> ![enter image description here](Resources/CustomNofticationGif3.gif) </p> 3. And much more ... </p>
10| Lottie | Through customizing ContentView, you are able to add Lottie's LAAnimationView to Item(s) </p> ![enter image description here](Resources/LottieGif.gif)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

* Xcode 8 or later
* iOS 8.0 or later
* ARC
* Swift 3 or later

## Installation

MagiPhotoBrowser is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MagiPhotoBrowser'
```
### Manually

``` ruby
git clone https://github.com/AnRanScheme/MagiPhotoBrowser.git
open MagiPhotoBrowser
```
## Author

AnRanScheme, 541437674@qq.com

## License

The MIT License (MIT)

Copyright (c) 2013-2016 eggswift. All rights reserved.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

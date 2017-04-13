![Logo](https://github.com/natmark/NATagTextView/blob/master/Logo.png?raw=true)
# NATagTextView
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

## About
Custom UITextView with **TAG** written in Swift.

<img src="https://github.com/natmark/NATagTextView/blob/master/screenshot.gif?raw=true" width="40%" height="40%"></img>

## Usage with Storyboard
Connect the UITextView to NATagTextView Class
![Storyboard setting](https://github.com/natmark/NATagTextView/blob/master/storyboard.png?raw=true)
```Swift
    @IBOutlet weak var tagTextView: NATagTextView!
```

### NATagTextViewDelegate
You can get tags when did update tag.
```Swift
    func tagTextView(_ view: NATagTextView, didUpdateTags tags: [String])
```

### Options

- `tagColor: UIColor = UIColor.blue`

To change tag string attributed color, just set **tagColor** parameter.

- `symbol: String = "#"`

To change symbol character, just set **symbol** parameter.

- `approvalOption: [NATagApprovalOption] = [.lowerCase , .upperCase , .number]`

To use approval regular expression option, just set **approvalOption** parameter.


## Instration
### [Carthage](https://github.com/Carthage/Carthage)
Add this to `Cartfile`
```
  github "natmark/NATagTextView" ~> 0.1
```

## Author

[natmark](https://github.com/natmark)

## License

NATagTextView is available under the MIT license. See the LICENSE file for more info.

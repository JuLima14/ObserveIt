# ObserveIt

Simple implementation of Observer pattern

## Code Example

First you need to import de project:
```Swift
import ObserveIt
```

then, you have to inherit the class from Observable and set the property to ```dynamic```, like this:		
```Swift
enum ExampleEnum: String {
    case property = "property"
}

class Example: Observable {
	@objc dynamic var property: String = "Hello, World!"
}
```
bind observer this will execute the callback everytime the property of Example object is updated: 
```Swift
//create the observable
var ex = Example()

//self is the object who listen the changes of the property
//key is the name of the property who is observed
//asyncCallback will avoid to listen other changes before you unblock() the property for this observer
ex.observe(with: self, key: ExampleEnum.property.rawValue, callback: { newValue in
	    guard let value = newValue.value as? String else { return }
            print(value)
})
	
//to trigger the api call modify the property
ex.property = "modify the value of the property observed"

//to stop listen
ex.ignore(with: self, key: ExampleEnum.property.rawValue) //this will remove the observer from the list that bind observer with the observable
```
bind observer this will execute the callback everytime the property of Example object is updated and the next() callback is executed:
```Swift

//create the observable
var ex = Example()

//self is the object who listen the changes of the property
//key is the name of the property who is observed
//asyncCallback will avoid to listen other changes before you unblock() the property for this observer
ex.observe(with: self, key: ExampleEnum.property.rawValue, asyncCallback: false, callback: { newValue  in
    guard let value = newValue.value as? String else { return }
    APIHelper.shared.getInfo(text: value, completionHandler: { (result) in
	print(result)
	newValue.unblock()//unlock the property to continue listen changes
    })
})

//to test this
ex.property = "modify the value of the property observed"

//this will remove the observer from the list that bind observer with the observable
ex.ignore(with: self, key: ExampleEnum.property.rawValue) 
```

## CocoaPods
```Swift
platform :ios, '10.0'

target 'AppName' do

  use_frameworks!
  
    pod 'ObserveIt'

end
```

## License

MIT License

Copyright (c) 2018 Julian Lima

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

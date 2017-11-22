# Illusion

Illusion lets you get diff between two objects with ease.

## Sample Use

Let's say we have a simple `User` model:

```swift
struct User {
    let username: String
    let firstName: String
    let lastName: String
    let dateOfBirth: Date
    let website: URL
}
```

We can make it "diffable" as follows:

```swift
extension User: Diffable {
    
    static var allKeyPaths: Set<PartialKeyPath<User>> {
        return [\User.username, \User.firstName, \User.lastName, \User.dateOfBirth, \User.website]
    }
}
```

Let's create two different users:

```swift
let user1 = User(username: "gokselkk", firstName: "Goksel", lastName: "Koksal", dateOfBirth: dob, website: url)
let user2 = User(username: "baketheegg", firstName: "Sila", lastName: "Koksal", dateOfBirth: dob, website: url)
```

Now we can get diff:

```swift
let diff = try User.diff(user1, user2)

for change in diff.changes {
  let keyPath = change.keyPath
  let value1 = user1[keyPath: keyPath]
  let value2 = user2[keyPath: keyPath]
  
  print("\(value1) is different from \(value2)")
}
```

Viola!

```
gokselkk is different from baketheegg.
Goksel is different from Sila.
```

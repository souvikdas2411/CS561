# CrackStation CS561 Week 5

A vanilla Crackstation which can crack any single-character password, which matches the regular expression [A-Za-z0-9] and is encrypted using the SHA-1 cryptographic hash function. 

## Sample test data

```bash
crackStation(digest: "Your SHA1 Digest")
```

| Input to crack station: the encrypted password | Crack station’s output: the plain-text password. |
| ---------------------------------------------- | ------------------------------------------------ |
| 86f7e437faa5a7fce15d1ddcb9eaeaea377667b8       | a       											|
| 902ba3cda1883801594b6e1b452790cc53948fda       | 7       											|

## How to use our CrackStation?
The function below sets up the CrackStation dictionary. It returns true if a dictionary is successfully generated and vice versa.
```swift
public func generateHash() async -> Bool
```

The function below returns the plain-text password else the function returns nil.
```swift
public func crackStation(digest: String) -> String?
```

## How to generate the SHA1 digest?

```bash
echo -n "your string" | sha1sum
```
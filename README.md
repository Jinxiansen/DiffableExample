# DiffableExample


```swift

func applyDataSource(words: [WordItem]) {
    
    var snapshot = dataSource.snapshot()
    snapshot.appendSections([.word])
    snapshot.appendItems(words, toSection: .word)
    
    dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    
}
```



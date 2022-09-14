import Foundation

public protocol LocalDataStoring: ObservableObject {
    func save()
    func addItem(_ text: String)
    func updateItem( _ item: ListItem)
    func clearAllItems()
}

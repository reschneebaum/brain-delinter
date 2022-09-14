import SwiftUI

public struct StyledListRow<Content: View>: View {
    // MARK: Properties
    
    var description: String
    let horizontal: Bool
    let content: () -> Content
    
    public var body: some View {
        containerView
            .padding(.bottom, Padding.small.rawValue)
            .padding(.top, Padding.xSmall.rawValue)
    }
    
    @ViewBuilder
    private var containerView: some View {
        if horizontal {
            HStack {
                stackContent
            }
        } else {
            VStack(alignment: .leading, spacing: Padding.xSmall.rawValue) {
                stackContent
            }
        }
    }
    
    @ViewBuilder
    private var stackContent: some View {
        content()
            .font(.Rounded.Medium.body)
        
        if horizontal {
            Spacer()
        }
        
        if !description.isEmpty {
            Text(description)
                .font(.Italic.footnote)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
    
    // MARK: Init
    
    public init(
        description: String,
        horizontalLayout: Bool? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.description = description
        self.content = content
        horizontal = horizontalLayout ?? false
    }
}

// MARK: - Extensions

// MARK: Convenience initializers

extension StyledListRow where Content == Text {
    public init(title: String, description: String?, value: String?) {
        if let value {
            self.init(title: title, value: value)
        } else if let description {
            self.init(title: title, description: description)
        } else {
            self.init(title: title)
        }
    }
    
    /// Displays a title and description laid out vertically.
    public init(title: String, description: String) {
        self.init(description: description) {
            Text(title)
        }
    }
    
    /// Displays a title and value laid out horizontally, separated by a `Spacer`.
    public init(title: String, value: String) {
        self.init(description: value, horizontalLayout: true) {
            Text(title)
        }
    }
    
    public init(title: String) {
        self.init(description: "") {
            Text(title)
        }
    }
}

struct StyledListRow_Previews: PreviewProvider {
    static var previews: some View {
        List {
            StyledListRow(description: "just a lil test row") {
                HStack {
                    Text("hello world")
                    Image(systemName: "bicycle")
                }
            }
            
            StyledListRow(title: "Title only")
            
            StyledListRow(title: "Item with value", value: "value amount")
            
            StyledListRow(title: "Item with description", description: "description, aligned vertically")
        }
    }
}


import SwiftUI

struct FlagImage: View {
    init(name: String) {
        self.name = name
    }

    private let name: String

    var body: some View {
        Image(name)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

struct FlagImage_Previews: PreviewProvider {
    static var previews: some View {
        FlagImage(name: "France")
    }
}

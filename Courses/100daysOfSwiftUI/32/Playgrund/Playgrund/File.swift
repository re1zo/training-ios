class NetworkManager {
    class var maximumActiveRequests: Int {
        return 4
    }

    func printDebugData() {
        print("Maximum network requests: \(Self.maximumActiveRequests).")
    }
}

class ThrottledNetworkManager: NetworkManager {
    override class var maximumActiveRequests: Int {
        return 1
    }
}

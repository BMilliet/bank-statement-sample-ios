extension Float {
    func toReal() -> String {
        return "R$ \(self)".replacingOccurrences(of: ".", with: ",")
    }
}

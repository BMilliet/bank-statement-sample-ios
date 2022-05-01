extension Date {
    func toBrDate() -> String {
        let format = DateFormatter()
        format.dateFormat = "EEEE - d MMMM"
        return format.string(from: self)
    }
    
    func toBrDateDetail() -> String {
        let format = DateFormatter()
        format.dateFormat = "EEEE - dd/MM/yyyy"
        return format.string(from: self)
    }
}

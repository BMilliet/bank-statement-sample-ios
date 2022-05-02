final class StatementDataSource {
    
    private func dayCreate(_ date: String) -> Date {
        let parseStrategy = Date.ParseStrategy(
            format: "\(day: .twoDigits)-\(month: .twoDigits)-\(year: .defaultDigits)",
            locale: Locale(identifier: "es"),
            timeZone: .current
        )
        
        let date = try? Date(date, strategy: parseStrategy)
        return date ?? Date.now
    }
    
    private lazy var sections = [
        day1,
        day2,
        day3,
        day4,
        day5
    ]
    
    private lazy var day1 = StatementDay(uuid: UUID(), total: "R$ 3.446,00", date: dayCreate("06-08-2021"), itens: [
        StatementItem(uuid: UUID(), person: person1, status: "Transferência recebida",
                      paymentType: .pay, paymentStatus: .income,
                      value: 30, time: "17:35", type: .cpf,
                      date: dayCreate("06-08-2021"), desc: "Descrição do item aqui!"),
        
        StatementItem(uuid: UUID(), person: person2, status: "Pagamento recebido",
                      paymentType: .pay, paymentStatus: .income,
                      value: 26, time: "13:17", type: .cpf, date: dayCreate("06-08-2021"), desc: "Descrição do item aqui!"),
        
        StatementItem(uuid: UUID(), person: person3, status: "Transferência estornada",
                      paymentType: .reversal, paymentStatus: .reverse,
                      value: 26, time: "13:17", type: .cpf, date: dayCreate("06-08-2021"), desc: "Descrição do item aqui!"),
        
        StatementItem(uuid: UUID(), person: person4, status: "Boleto pago",
                      paymentType: .ticket, paymentStatus: .outcome,
                      value: 26, time: "9:22", type: .cnpj, date: dayCreate("06-08-2021"), desc: "Descrição do item aqui!"),
    ])
    
    private lazy var day2 = StatementDay(uuid: UUID(), total: "R$ 3.110,08", date: dayCreate("02-08-2021"), itens: [
        StatementItem(uuid: UUID(), person: person5, status: "Depósito via boleto",
                      paymentType: .ticket, paymentStatus: .income,
                      value: 30, time: "9:22", type: .cpf, date: dayCreate("02-08-2021"), desc: "Descrição do item aqui!"),
        
        StatementItem(uuid: UUID(), person: person6, status: "Transferência enviada",
                      paymentType: .pay, paymentStatus: .outcome,
                      value: 26, time: "9:22", type: .cpf, date: dayCreate("02-08-2021"), desc: "Descrição do item aqui!"),
    ])
    
    private lazy var day3 = StatementDay(uuid: UUID(), total: "R$ 3.050,30", date: dayCreate("30-07-2021"), itens: [
        StatementItem(uuid: UUID(), person: person7, status: "Pagamento estornado",
                      paymentType: .reversal, paymentStatus: .reverse,
                      value: 26, time: "9:22", type: .cpf, date: dayCreate("30-07-2021"), desc: "Descrição do item aqui!"),
        
        StatementItem(uuid: UUID(), person: person8, status: "Transferência recebida",
                      paymentType: .pay, paymentStatus: .income,
                      value: 30, time: "9:22", type: .cpf, date: dayCreate("30-07-2021"), desc: "Descrição do item aqui!"),
        
        StatementItem(uuid: UUID(), person: person9, status: "Transferência enviada",
                      paymentType: .pay, paymentStatus: .outcome,
                      value: 26, time: "9:22", type: .cpf, date: dayCreate("30-07-2021"), desc: "Descrição do item aqui!"),
    ])
    
    private lazy var day4 = StatementDay(uuid: UUID(), total: "R$ 3.124,34", date: dayCreate("05-08-2021"), itens: [
        StatementItem(uuid: UUID(), person: person10, status: "Boleto pago",
                      paymentType: .ticket, paymentStatus: .outcome,
                      value: 26, time: "9:22", type: .cpf, date: dayCreate("05-08-2021"), desc: "Descrição do item aqui!"),
    ])
    
    private lazy var day5 = StatementDay(uuid: UUID(), total: "R$ 2.124,34", date: dayCreate("02-06-2021"), itens: [
        StatementItem(uuid: UUID(), person: person10, status: "Transferência agendada",
                      paymentType: .future, paymentStatus: .future,
                      value: 100, time: "9:22", type: .cpf, date: dayCreate("02-01-2021"), desc: "Descrição do item aqui!"),
    ])
    
    private lazy var person1 = Person(uuid: UUID(), name: "Lucas Costa", cpf: "457.131.063-26",
                                      bank: "Banco Itaú", agency: "2435", account: "43556-3")
    
    private lazy var person2 = Person(uuid: UUID(), name: "João da Silva", cpf: "511.120.443-52",
                                      bank: "Banco Bradesco", agency: "2435", account: "43556-3")
    
    private lazy var person3 = Person(uuid: UUID(), name: "Daniela Andrade", cpf: "427.110.133-22",
                                      bank: "Banco Itaú", agency: "2435", account: "43556-3")
    
    private lazy var person4 = Person(uuid: UUID(), name: "Aut Arquitetura", cpf: "402.299.322-50",
                                      bank: "Banco do Brasil", agency: "2435", account: "43556-3")
    
    private lazy var person5 = Person(uuid: UUID(), name: "Leonardo Silva ME", cpf: "500.120.223-86",
                                      bank: "Banco Itaú", agency: "2435", account: "43556-3")
    
    private lazy var person6 = Person(uuid: UUID(), name: "Stella Moraes", cpf: "427.160.163-56",
                                      bank: "Banco Bradesco", agency: "2435", account: "43556-3")
    
    private lazy var person7 = Person(uuid: UUID(), name: "Darlene Edwards", cpf: "390.190.513-16",
                                      bank: "Banco Nu-SA", agency: "2435", account: "43556-3")
    
    private lazy var person8 = Person(uuid: UUID(), name: "Guy Edwards", cpf: "420.200.522-99",
                                      bank: "Banco Cora", agency: "2435", account: "43556-3")
    
    private lazy var person9 = Person(uuid: UUID(), name: "Theresa Simmmons", cpf: "437.133.673-96",
                                      bank: "Banco Santander", agency: "2435", account: "43556-3")
    
    private lazy var person10 = Person(uuid: UUID(), name: "Judith Cooper", cpf: "417.129.231-23",
                                      bank: "Banco Cora", agency: "2435", account: "43556-3")
    
    private lazy var owner = Person(uuid: UUID(), name: "Lucas Vallim da Costa", cpf: "407.130.563-56",
                                    bank: "Banco Cora", agency: "6193", account: "12225-3")
}

extension StatementDataSource: StatementDataSourceProtocol {
    func getStatements() -> [StatementDay] {
        return sections
    }
    
    func getUser() -> Person {
        return owner
    }
}

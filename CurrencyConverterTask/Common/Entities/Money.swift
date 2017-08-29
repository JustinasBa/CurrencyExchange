import Foundation

class Money: NSObject {
    let amount: NSDecimalNumber
    let currency: String
    
    override var description: String {
        return "\(amount.stringValue) \(currency)"
    }
    
    var currencySymbol: String {
        if let symbol =  (Locale.current as NSLocale).displayName(forKey: NSLocale.Key.currencySymbol, value: currency) {
            return symbol
        }
        return currency
    }
    
    init(amount: NSDecimalNumber, currency: String) {
        self.amount = amount
        self.currency = currency
    }
    
    init(amountString: String, currency: String) {
        self.amount = NSDecimalNumber(string: amountString)
        self.currency = currency
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let money = object as? Money else {
            return false
        }
        
        return amount.compare(money.amount) == .orderedSame && currency == money.currency
    }
    
    func add(_ money: Money) -> Money {
        return Money(amount: amount.adding(money.amount), currency: money.currency)
    }
    
    func isZero() -> Bool {
        return amount.compare(NSDecimalNumber.zero) == ComparisonResult.orderedSame
    }
    
    func toCents() -> NSNumber {
        return amount.multiplying(byPowerOf10: 2)
    }
    
    func compare(_ money: Money) -> ComparisonResult {
        return amount.compare(money.amount)
    }
    
    func getAmountAsString() -> String {
        return String(describing: amount)
    }
}

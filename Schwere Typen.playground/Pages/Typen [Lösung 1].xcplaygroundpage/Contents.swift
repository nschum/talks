protocol AnyEquatable {
    func equals(rhs: AnyEquatable) -> Bool // Operatoren funktionieren nicht, weil mindestens auf einer Seite Self stünde!
}

protocol Account: AnyEquatable {
    var name: String {get}
    var passwort: String {get}
}

struct InternetAccount: Account, Equatable {
    var name: String
    var passwort: String

    func equals(rhs: AnyEquatable) -> Bool {
        guard let rhs = rhs as? InternetAccount else {return false}
        return self == rhs
    }
}

func ==(lhs: InternetAccount, rhs: InternetAccount) -> Bool {
    return lhs.name == rhs.name && lhs.passwort == rhs.passwort
}

struct TwitterAccount: Account, Equatable {
    var name: String
    var passwort: String

    func equals(rhs: AnyEquatable) -> Bool {
        guard let rhs = rhs as? TwitterAccount else {return false}
        return self == rhs
    }
}

func ==(lhs: TwitterAccount, rhs: TwitterAccount) -> Bool {
    return lhs.name == rhs.name && lhs.passwort == rhs.passwort
}

let internetAccount = InternetAccount(name: "John Appleseed", passwort: "123456")
let twitterAccount = TwitterAccount(name: "Johann Ebbelwoi", passwort: "123456")

let accounts: [Account] = [internetAccount, twitterAccount]

internetAccount.equals(twitterAccount)

internetAccount.equals(internetAccount)
twitterAccount.equals(twitterAccount)

protocol Account: Equatable {
    var name: String {get}
    var passwort: String {get}
}

struct InternetAccount: Account {
    var name: String
    var passwort: String
}

func ==(lhs: InternetAccount, rhs: InternetAccount) -> Bool {
    return lhs.name == rhs.name && lhs.passwort == rhs.passwort
}

struct TwitterAccount: Account {
    var name: String
    var passwort: String
}

func ==(lhs: TwitterAccount, rhs: TwitterAccount) -> Bool {
    return lhs.name == rhs.name && lhs.passwort == rhs.passwort
}

let internetAccount = InternetAccount(name: "John Appleseed", passwort: "123456")
let twitterAccount = TwitterAccount(name: "Jupp Ebbelwoi", passwort: "123456")

let accounts: [Account] = [internetAccount, twitterAccount]
// protocol 'Account' can only be used as a generic constraint because it has Self or associated type requirements

// warum?
// d.h. accounts[0] == accounts[1] // wäre legal
// d.h. internetAccount == twitterAccount // wäre legal

// aber natürlich geht das nicht
// internetAccount == twitterAccount // binary operator '==' cannot be applied to operands of type 'InternetAccount' and 'TwitterAccount'

// Equatable geht in Swift immer mit demselben Type, nicht mit Any wie in Objective-C!

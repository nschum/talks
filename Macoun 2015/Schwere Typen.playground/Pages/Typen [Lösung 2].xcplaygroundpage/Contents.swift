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

// Wrapper um beliebige Accounts
struct AnyAccount: Account {
    var name: String {return nameGetter()}
    private var nameGetter: () -> String

    var passwort: String {return passwortGetter()}
    private var passwortGetter: () -> String

    init<T: Account>(_ account: T) {
        nameGetter = {account.name}
        passwortGetter = {account.passwort}
    }
}

func ==(lhs: AnyAccount, rhs: AnyAccount) -> Bool {
    return lhs.name == rhs.name && lhs.passwort == rhs.passwort
}

let accounts: [AnyAccount] = [AnyAccount(internetAccount), AnyAccount(twitterAccount)]

AnyAccount(internetAccount) == AnyAccount(twitterAccount)

//  This file was automatically generated and should not be edited.

import Apollo

public final class ChangeBalanceMutation: GraphQLMutation {
  public static let operationString =
    "mutation ChangeBalance($senderID: String!, $reciverID: String!, $amount: Int!) {\n  changeBalance(senderId: $senderID, recieverId: $reciverID, amount: $amount)\n}"

  public var senderID: String
  public var reciverID: String
  public var amount: Int

  public init(senderID: String, reciverID: String, amount: Int) {
    self.senderID = senderID
    self.reciverID = reciverID
    self.amount = amount
  }

  public var variables: GraphQLMap? {
    return ["senderID": senderID, "reciverID": reciverID, "amount": amount]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("changeBalance", arguments: ["senderId": GraphQLVariable("senderID"), "recieverId": GraphQLVariable("reciverID"), "amount": GraphQLVariable("amount")], type: .nonNull(.scalar(Int.self))),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(changeBalance: Int) {
      self.init(snapshot: ["__typename": "Mutation", "changeBalance": changeBalance])
    }

    public var changeBalance: Int {
      get {
        return snapshot["changeBalance"]! as! Int
      }
      set {
        snapshot.updateValue(newValue, forKey: "changeBalance")
      }
    }
  }
}

public final class CreateUserMutation: GraphQLMutation {
  public static let operationString =
    "mutation CreateUser($name: String!) {\n  createUser(name: $name) {\n    __typename\n    id\n  }\n}"

  public var name: String

  public init(name: String) {
    self.name = name
  }

  public var variables: GraphQLMap? {
    return ["name": name]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("createUser", arguments: ["name": GraphQLVariable("name")], type: .nonNull(.object(CreateUser.selections))),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(createUser: CreateUser) {
      self.init(snapshot: ["__typename": "Mutation", "createUser": createUser.snapshot])
    }

    public var createUser: CreateUser {
      get {
        return CreateUser(snapshot: snapshot["createUser"]! as! Snapshot)
      }
      set {
        snapshot.updateValue(newValue.snapshot, forKey: "createUser")
      }
    }

    public struct CreateUser: GraphQLSelectionSet {
      public static let possibleTypes = ["User"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: String? = nil) {
        self.init(snapshot: ["__typename": "User", "id": id])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: String? {
        get {
          return snapshot["id"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }
    }
  }
}
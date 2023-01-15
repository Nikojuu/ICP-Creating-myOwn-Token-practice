import Principal "mo:base/Principal";

import HashMap "mo:base/HashMap";
import Text "mo:base/Text";
import Debug "mo:base/Debug";
import Nat "mo:base/Nat";

actor Token {

  var owner : Principal = Principal.fromText("5ewc4-vn6ac-2c4pv-ppn3w-anguc-mwu7m-mjgxu-d7jbo-yxqxz-shsyg-6ae");

  var totalSupply : Nat = 10000000000;
  var symbol : Text = "NIKO";

  var balances = HashMap.HashMap<Principal, Nat>(1, Principal.equal, Principal.hash);

  balances.put(owner, totalSupply);

  public query func balanceOf(who : Principal) : async Nat {

    let balance : Nat = switch (balances.get(who)) {
      case null 0;
      case (?result) result;
    };

    return balance;
  };

  public query func getSymbol() : async Text {
    return symbol;
  };

  public shared (msg) func payOut() : async Text {
    Debug.print(debug_show (msg.caller));
    if (balances.get(msg.caller) == null) {
      let amount = 10000;
      transfer(msg.caller, amount) return "success";
    } else {
      return "Already claimed Boy";
    };
  };
  public shared (msg) func transfer(to : Principal, amount : Nat) : async Text {
    let fromBalance = await balanceOf(msg.caller);
    if (fromBalance > amount) {
      let newFromBalance : Nat = fromBalance - amount;
      balances.put(msg.caller, newFromBalance);

      let toBalance = await balanceOf(to);
      let newToBalance = toBalance + amount;
      balances.put(to, newToBalance);

      return "Success";

    } else {
      return "Insuffient Funds";
    };

  };

};

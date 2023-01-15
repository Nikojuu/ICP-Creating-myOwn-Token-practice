import React, { useState } from "react";
import { Token } from "../../../declarations/token";
import { token } from "../../../declarations/token/index";


function Faucet() {

  const [isDisabled, setDisable] = useState(false)
  const [buttonText, setText] = useState("gimme gimme")

  async function handleClick(event) {
    setDisable(true)
    const result = await token.payOut()
    setText(result);
    // setDisable(false)
  }

  return (
    <div className="blue window">
      <h2>
        <span role="img" aria-label="tap emoji">
          🚰
        </span>
        Faucet
      </h2>
      <label>Get your free DAngela tokens here! Claim 10,000 DANG coins to your account.</label>
      <p className="trade-buttons">
        <button disabled={isDisabled} id="btn-payout" onClick={handleClick}>
          {buttonText}
        </button>
      </p>
    </div>
  );
}

export default Faucet;

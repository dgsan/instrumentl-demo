
import React from "react";
import { render } from "react-dom";
import Index from "../routes/index";

document.addEventListener("DOMContentLoaded", () => {
  render(<Index />, document.body.appendChild(document.createElement("div")));
});

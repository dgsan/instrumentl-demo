import React from "react";
import { BrowserRouter as Router, Route, Routes, Link } from "react-router-dom";
import Root from "../components/root";
import Elsewhere from "../components/elsewhere";
import TaxEntities from "../components/tax_entities";

// Styles reused and adapted shamelessly from tailblocks.
// See: https://tailblocks.cc/
export default () => (
  <Router>
    <header className="text-gray-400 bg-gray-900 body-font">
      <div className="container mx-auto flex flex-wrap p-5 flex-col md:flex-row items-center">
        <span className="flex title-font font-medium items-center text-white mb-4 md:mb-0">
          <span className="ml-0 text-xl">Instr-Demo</span>
        </span>
        <nav className="md:ml-auto flex flex-wrap items-center text-base justify-center">
         <Link to="/" className="mr-5 hover:text-white">Root</Link>
         <Link to="/elsewhere" className="mr-5 hover:text-white">Elsewhere</Link>
         <Link to="/tax_entities" className="mr-5 hover:text-white">Tax Entities</Link>
        </nav>
      </div>
    </header>
    <section className="text-gray-400 bg-gray-900 body-font">
      <div className="container mx-auto flex flex-col px-5 py-24 justify-center items-center">
        <div className="w-full md:w-2/3 flex flex-col mb-16 items-center text-center">
          <Routes>
            <Route exact path="/"  element={<Root />} />
            <Route path="/elsewhere" element={<Elsewhere />} />
            <Route path="/tax_entities" element={<TaxEntities />} />
          </Routes>
        </div>
      </div>
    </section>
  </Router>
);

import React, { Component } from "react";
import normalize from 'json-api-normalizer';

const structure = (result) => {
  const ids = result.data.map(topItem => topItem.id);
  const index = normalize(result);
  return {
    tax_entity_ids: ids,
    data: index
  }
};

const GrantList = (props) => {
  const { grants, data } = props;
  const listItems = grants.map(grant => (
    <div key={grant.id} className="p-2 sm:w-1/2 w-full">
      <div className="rounded flex p-4 h-full items-center">
        <span className="title-font font-medium text-white">
         <strong>${Number.parseFloat(data.grant[grant.id].attributes.amount).toFixed(0)}</strong>
         {` to ${data.taxEntity[data.grant[grant.id].relationships.to.data.id].attributes.name}`}
        </span>
      </div>
    </div>
  ));
  return (
    <div className="flex flex-wrap lg:w-4/5 sm:mx-auto sm:mb-2 -mx-2">
    {listItems}
    </div>
  );
};

const EntityList = (props) => {
  const { tax_entity_ids, data } = props;
  const listItems = tax_entity_ids.map(id => (
    <section key={id} className="text-gray-400 bg-gray-900 body-font">
      <div className="container px-5 py-12 pb-6 mx-auto">
        <div className="text-center mb-5">
          <h1 className="sm:text-3xl text-2xl font-medium text-center title-font text-white mb-4">
          {data.taxEntity[id].attributes.name}
          </h1>
          <p className="text-base leading-relaxed xl:w-2/4 lg:w-3/4 mx-auto">
            {`${data.taxEntity[id].attributes.address}
              ${data.taxEntity[id].attributes.city},
              ${data.taxEntity[id].attributes.state}
              ${data.taxEntity[id].attributes.postCode || ''}`}
          </p>
        </div>
      </div>
      <GrantList
        grants={data.taxEntity[id].relationships.granted.data}
        data={data}
      />
    </section>
  ));
  return <div>{listItems}</div>;
};

class TaxEntities extends Component {
  constructor(props) {
    super(props);
    this.state = {
      error: null,
      isLoaded: false,
      requested: []
    };
  }

  componentDidMount() {
    fetch("tax_entities", {
      headers: {
        'Content-Type': 'application/json'
      }
    }).then(res => res.json())
      .then(
        (result) => {
          this.setState({
            isLoaded: true,
            requested: structure(result)
          });
        },
        (error) => {
          this.setState({
            isLoaded: true,
            requested: [],
            error
          });
        }
      );
  }

  render() {
    const { error, isLoaded, requested } = this.state;
    if (error) {
      return <div>Error: {error.message}</div>;
    } else if (!isLoaded) {
      return <div>Loading...</div>;
    } else {
     return (
       <div className="">
         <EntityList {...requested} />
       </div>
     )
    }
  }
}

export default TaxEntities;

{
  connectors(limit: 15,
     filters: [{connectorType: {values: JENKINS, operator: EQUALS}}]
     ){
    nodes {
      id
      name
    }
  }
}

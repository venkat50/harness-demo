{
  connectors(limit: 15,
     filters: [{connectorType: {values: GIT, operator: EQUALS}}]
     ){
    nodes {
      id
      name
    }
    
 
  }
}

{
  pipelines(limit: 20, offset: 20) {
    nodes {
      id
      name
      description
      createdAt
    }
    pageInfo {
      total
    }
  }
}

{
  application(applicationId:\"VAR1\") {
    services(limit:10, offset:0) {
      pageInfo{
        total
      }
      nodes{
        name
      }
    }
  }
}

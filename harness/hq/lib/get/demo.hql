{
  applications(limit: 10){
    nodes{
      name
      environments(limit: 5){
        nodes{
          name
        }
      }
    }
  }
}

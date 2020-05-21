{
  workflows(limit: VAR1 ){
    nodes{
      id
      name
      workflowVariables{
        name
        type
        required
        allowedValues
        defaultValue
      }
    }
  }
}

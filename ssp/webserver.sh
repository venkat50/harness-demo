cat > $PROVISIONER_OUTPUT_PATH  <<_EOF_
{
  "data": [
    {
      "hostname": "example1.com",
      "servername": "om1a",
      "component": "db",
      "port": "8201",
      "envType": "Dev"
    },
    {
      "hostname": "example2.com",
      "servername": "om2a",
      "component": "webserver",
      "port": "8202",
      "envType": "QA"
    },
    {
      "hostname": "example3.com",
      "servername": "om3a",
      "component": "utility",
      "port": "8203",
      "envType": "UAT"
    }
  ]
} 
_EOF_

## Curl

#### POST application/x-www-form-urlencoded
```
curl -d "param1=value1&param2=value2" -X POST http://localhost:3000/data
curl -d "@data.txt" -X POST http://localhost:3000/data
```

#### POST JSON
```
curl -d '{"key1":"value1", "key2":"value2"}' -H "Content-Type: application/json" -X POST http://localhost:3000/data
curl -d "@data.json" -X POST http://localhost:3000/data
```

#### Download file
```
curl -o file.txt http://...
```

#### Make a preflight request to test CORS
```
curl -v -H "Access-Control-Request-Method: GET" -H "Origin: http://localhost:4200" -X OPTIONS http://localhost:8080/user
```

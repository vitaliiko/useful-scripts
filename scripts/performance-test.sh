#!/bin/bash

offset=1
limit=10000
endpoint="http://localhost:8080/api/test"

while [ $offset -le 50 ]
do
    echo $offset
    start_time=$(date +%s)

    echo Result:
    # curl -X POST -H "Content-Type: application/json" -d "{\"fromDate\": \"2024-05-14T15:05:32.464Z\", \"itemsPerPage\": $limit, \"pageNumber\": $offset, \"matchingResult\": \"NOT_MATCHED\"}" $endpoint
    curl -X POST -H "Content-Type: application/json" $endpoint -d @- <<BODY
    {
  "example": []
}
BODY


    end_time=$(date +%s)
    execution_time=$(($end_time-$start_time))
    echo "Execution time: $execution_time seconds"

    offset=$((offset+1))
done

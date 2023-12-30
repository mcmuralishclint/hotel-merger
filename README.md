<a name="_3x7bdkewk2u4"></a>Hotel Merger

## High Level Design
![High Level Diagram](https://github.com/mcmuralishclint/hotel-merger/blob/master/public/hld.jpg)

## API
1. Provide an ingest API to ingest the information from several sources (Use suppliers: [“*”] to ingest from all the suppliers)
```
curl --location 'http://localhost:3000/api/v1/hotels_ingestion/ingest' \
--header 'Content-Type: application/json' \
--data '{
    "suppliers": ["acme",”patagonia”,”paperflies”]
}'
```
- This API will procure the information from multiple APIs provided in the body of the API and save it in mongodb
- This API also cleans, merges and persists the merged data in an SQL DB

2. Provide an API to serve the merged data

Query using destination ID
```
curl --location 'http://localhost:3000/api/v1/hotels/search?search_type=destination_id&search_value=5432'
```

Query using hotel_id
```
curl --location 'http://localhost:3000/api/v1/hotels/search?search_type=id&search_value=iJhz'
```

* Based on the search_type, the API will dynamically decide how to query the data

## Database
![DB Diagram](https://github.com/mcmuralishclint/hotel-merger/blob/master/public/db.png)

## CI/CD
![CICD Approach](https://github.com/mcmuralishclint/hotel-merger/blob/master/public/cicd.png)



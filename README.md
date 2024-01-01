# Ascenda - Hotel Data Merge

# Solution Design

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
curl --location --request GET 'http://localhost:3000/api/v1/hotels/search?type=destination_id&value=5432&page=1&per_page=2'
```

Query using hotel_id
```
curl --location --request GET 'http://localhost:3000/api/v1/hotels/search?type=id&value=iJhz&page=1&per_page=2'
```

* Based on the search_type, the API will dynamically decide how to query the data

## Database
![DB Diagram](https://github.com/mcmuralishclint/hotel-merger/blob/master/public/db.png)

## CI/CD
![CICD Approach](https://github.com/mcmuralishclint/hotel-merger/blob/master/public/cicd.png)

* CI - (Unit test, coverage analysis, lint check) is made available through github actions ✓
* CD - Use a webhook trigger to sense a git push to deploy through AWS code pipeline to AWS Elastic Beanstalk
p.s: couldn't complete the elastic beanstalk setup hence pushed the final image to docker

# How to Setup
**Prerequisite:** [Install Docker and Docker Compose](https://docs.docker.com/compose/install/)

```
git clone git@github.com:mcmuralishclint/hotel-merger.git
cd hotel-merger
docker-compose up
```

Wait until both the images are pulled and until you see a log that says Listening on http://0.0.0.0:3000
Navigate to localhost:3000 on the browser to check if the application has spun up as expected

If there's an update to the application, please pull the latest image `docker pull mcmuralishclint/my-rails-app:latest` before running `docker-compose up`

**p.s. Access the application only through http://localhost:3000. DO NOT USE https or 127.0.0.1**

## Swagger Documentation
Access the API documentation and interact with endpoints using Swagger UI:
[Swagger URL](http://localhost:3000/api-docs/index.html)

# Improvements

## Performance
- Cache
  - Use caching to speed up the search API ✓
  - Use a cache eviction strategy such that when an ingestion action is performed, the stale data from the cache is evicted and replaced with the updated info
- Targeted Ingestion 
  - Ingest by all suppliers or ingest only an individual supplier ✓
  - Ingest only the information that's required i.e We have refined on a supplier level but further improvement can be done where we can ingest based on a hotel_id or destination_id
- Pagination
  - As the dataset grows, search performance will detoriate hence paginating the response will be helpful ✓
- Rate Limiting
  - Rate limiting can be done on the Search API so we can prevent excessive usage

## Security
- API Key
  - Use of api key to prevent unauthorized actors from triggering the ingestion API
- Input Validation
  - Validate input params to prevent any SQL injection

# Developer Guide
## Containerization
The application is packed using docker and pushed to dockerhub. The following commands can be used to build and push to dockerhub once you release a new change.

```
docker build --no-cache -t my-rails-app:latest .
docker tag my-rails-app:latest mcmuralishclint/my-rails-app
docker push mcmuralishclint/my-rails-app
```

Disclaimer: Necessary permissions are required to push to the repository in Dockerhub. Please reach out.

## Patterns

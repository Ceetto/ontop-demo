# Ontop demo app

This is a simple demo of ontop as part of a university project.

It runs a simple postgres database and inits it with some tables and data on video games. We then put an ontop
vkg on top of that, exposing the data as rdf via a sparql endpoint.

## How to run

### Install postgres driver for ontop

```shell
wget https://jdbc.postgresql.org/download/postgresql-42.7.3.jar -O ./ontop/jdbc/postgresql-42.7.3.jar
```

### Run app
Start app:
```shell
docker compose up -d
```
Stop app:
```shell
docker compose down
```

The database will be running on port `5432` with username and password: `postgres` and database name `games_db`

The ontop sparql endpoint will run on `localhost:8080/sparql` you will have a GUI to test queries on
`localhost:8080`.

### Pre-requisites for windows docker
To run docker apps on windows you first need to install wsl and docker desktop. See these links for more help.

https://learn.microsoft.com/en-us/windows/wsl/install

https://www.docker.com/products/docker-desktop/

## Example sparql queries
### All games with their titles and release dates
```sparql
prefix ex:   <http://example.org/games#> 
prefix rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#> 
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> 
prefix foaf: <http://xmlns.com/foaf/0.1/> 

SELECT ?game ?title ?date WHERE {
    ?game a ex:Game ;
          ex:title ?title ;
          ex:releaseDate ?date .
}
ORDER BY ?date
```

### Games released in 2023
```sparql
prefix ex:   <http://example.org/games#> 
prefix rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#> 
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> 
prefix foaf: <http://xmlns.com/foaf/0.1/> 

SELECT ?game ?title WHERE {
    ?game a ex:Game ;
          ex:title ?title ;
          ex:releaseDate ?date .
    FILTER(YEAR(?date) = 2023)
}
ORDER BY ?title
```

### All platforms and their parent companies
```sparql
prefix ex:   <http://example.org/games#> 
prefix rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#> 
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> 
prefix foaf: <http://xmlns.com/foaf/0.1/> 

SELECT ?platform ?name ?company WHERE {
    ?platform a ex:Platform ;
              foaf:name ?name ;
              ex:parentCompany ?company .
}
ORDER BY ?name
```

### Games available on Nintendo Switch
```sparql
prefix ex:   <http://example.org/games#> 
prefix rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#> 
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> 
prefix foaf: <http://xmlns.com/foaf/0.1/> 

SELECT ?game ?title WHERE {
    ?game a ex:Game ;
          ex:title ?title ;
          ex:onPlatform ?platform .
    ?platform foaf:name "Nintendo Switch" .
}
ORDER BY ?title
```

### All RPG games
```sparql
prefix ex:   <http://example.org/games#> 
prefix rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#> 
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> 
prefix foaf: <http://xmlns.com/foaf/0.1/> 

SELECT ?game ?title WHERE {
    ?game a ex:Game ;
          ex:title ?title ;
          ex:hasGenre ?genre .
    ?genre foaf:name "RPG" .
}
ORDER BY ?title
```

### Games that are both Action and Open World
```sparql
prefix ex:   <http://example.org/games#> 
prefix rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#> 
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> 
prefix foaf: <http://xmlns.com/foaf/0.1/> 

SELECT DISTINCT ?game ?title WHERE {
    ?game a ex:Game ;
          ex:title ?title ;
          ex:hasGenre ?g1, ?g2 .
    ?g1 foaf:name "Action" .
    ?g2 foaf:name "Open World" .
}
ORDER BY ?title
```

### Soulslike games
```sparql
prefix ex:   <http://example.org/games#> 
prefix rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#> 
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> 
prefix foaf: <http://xmlns.com/foaf/0.1/> 

SELECT ?game ?title WHERE {
    ?game a ex:Game ;
          ex:title ?title ;
          ex:hasGenre ?genre .
    ?genre foaf:name "Soulslike" .
}
ORDER BY ?title
```

### Count of games per platform
```sparql
prefix ex:   <http://example.org/games#> 
prefix rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#> 
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> 
prefix foaf: <http://xmlns.com/foaf/0.1/> 

SELECT ?platformName (COUNT(?game) AS ?count) WHERE {
    ?game ex:onPlatform ?platform .
    ?platform foaf:name ?platformName .
}
GROUP BY ?platformName
ORDER BY DESC(?count)
```

### Top 10 most common genres
```sparql
prefix ex:   <http://example.org/games#> 
prefix rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#> 
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> 
prefix foaf: <http://xmlns.com/foaf/0.1/> 

SELECT ?genreName (COUNT(?game) AS ?count) WHERE {
    ?game ex:hasGenre ?genre .
    ?genre foaf:name ?genreName .
}
GROUP BY ?genreName
ORDER BY DESC(?count)
LIMIT 10
```

### All games with their genres as a comma-separated list
```sparql
prefix ex:   <http://example.org/games#> 
prefix rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#> 
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> 
prefix foaf: <http://xmlns.com/foaf/0.1/> 

SELECT ?title (GROUP_CONCAT(?genreName; SEPARATOR=", ") AS ?genres) WHERE {
    ?game a ex:Game ;
          ex:title ?title ;
          ex:hasGenre ?genre .
    ?genre foaf:name ?genreName .
}
GROUP BY ?title
ORDER BY ?title
```

### Games released after 2020 on PlayStation 5
```sparql
prefix ex:   <http://example.org/games#> 
prefix rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#> 
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> 
prefix foaf: <http://xmlns.com/foaf/0.1/> 

SELECT ?game ?title WHERE {
    ?game a ex:Game ;
          ex:title ?title ;
          ex:releaseDate ?date ;
          ex:onPlatform ?platform .
    ?platform foaf:name "PlayStation 5" .
    FILTER(?date >= "2020-01-01"^^xsd:date)
}
ORDER BY ?date
```

### Platforms made by Sony
```sparql
prefix ex:   <http://example.org/games#> 
prefix rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#> 
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> 
prefix foaf: <http://xmlns.com/foaf/0.1/> 

SELECT ?platform ?name WHERE {
    ?platform a ex:Platform ;
              foaf:name ?name ;
              ex:parentCompany "Sony" .
}
```
package main

import (
	"flag"
	"log"
	"net/http"

	bolt "github.com/boltdb/bolt"
)

var (
	dbLocation = flag.String("db-location", "my.db", "Location of the database file")
	httpAddr   = flag.String("http-addr", "127.0.0.1:6000", "HTTP address to listen on")
)

func parseFlags() {
	flag.Parse()
	if *dbLocation == "" {
		log.Fatal("db-location is required")
	}
}

func main() {
	parseFlags()
	db, err := bolt.Open(*dbLocation, 0600, nil)
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	log.Printf("Listening on %s", *httpAddr)
	log.Fatal(http.ListenAndServe(*httpAddr, nil))
}

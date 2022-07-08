package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	_ "github.com/go-sql-driver/mysql"
	"net/http"
	"time"
)

const ServerPort = 9999

func main() {
	fmt.Printf("Starting server on port %d\n", ServerPort)
	http.HandleFunc("/", httpServer)
	http.ListenAndServe(fmt.Sprintf(":%d", ServerPort), nil)
}

type Metric struct {
	Host       string
	MetricName string
	Value      int
}

func httpServer(w http.ResponseWriter, r *http.Request) {
	switch r.Method {
	case "POST":
		var m Metric
		err := json.NewDecoder(r.Body).Decode(&m)
		if err != nil {
			http.Error(w, err.Error(), http.StatusBadRequest)
			fmt.Printf("Error: %v", err)
			return
		}

		writeMetricStdOut(m)
		//writeMetricDB(m)
		fmt.Fprintf(w, "%s 200 OK", time.Now().Format(time.RFC3339))
	default:
		fmt.Fprintf(w, "Sorry, only POST is supported.")
	}

}

func writeMetricStdOut(m Metric) {
	fmt.Println("Metric Received:")
	fmt.Printf("    Host: %s", m.Host)
	fmt.Printf("    Name: %s", m.MetricName)
	fmt.Printf("    Name: %d\n", m.Value)
}

func writeMetricDB(m Metric) {
	// Open up our database connection.
	// I've set up a database on my local machine using phpmyadmin.
	// The database is called testDb
	db, err := sql.Open("mysql", "root:testing@tcp(mysql:3306)/intake")
	err = db.Ping()
	if err != nil {
		panic(err.Error())
	}
	// if there is an error opening the connection, handle it
	if err != nil {
		panic(err.Error())
	}

	// defer the close till after the main function has finished
	// executing
	defer db.Close()

	// perform a db.Query insert
	query := fmt.Sprintf("INSERT INTO intake (host, metric_name, value) VALUES (?, ?, ?)")
	insertForm, err := db.Prepare(query)
	// if there is an error inserting, handle it
	if err != nil {
		panic(err.Error())
	}

	r, err := insertForm.Exec(m.Host, m.MetricName, m.Value)

	if err != nil {
		panic(err.Error())
	}

	fmt.Printf("result: %v", r)
}

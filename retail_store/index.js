const mysql = require("mysql2");
const fs = require("fs");

const connection = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "root",
});

connection.connect((err) => {
  if (err) {
    console.error("Error connecting:", err);
  } else {
    console.log("Connected to MySQL!");
  }

  const sql = fs.readFileSync("queries.sql", "utf8");

  connection.query(sql, (err, results) => {
    if (err) {
      console.log(err);
    } else {
      console.log("All queries executed successfully!");
      connection.end();
    }
  });
});

/**
 * File Description:
 * A simple website that downloads website favicons and stores them in a PostgreSQL db.
 * Provides an API endpoint to return the favicons.
 * API limits return to 10 favicons per page.
 */

const pg = require("knex")({
  client: "pg",
  connection: {
    host: "127.0.0.1",
    port: 5432,
    user: "postgres",
    password: "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
    database: "test",
  },
});

// pg.schema.dropTable('users')

pg.schema.hasTable("favicon").then(function (exists) {
  if (!exists) {
    return pg.schema.createTable("favicon", function (table) {
      table.increments();
      table.string("website_link");
      table.string("favicon_link");
    });
  }
});

// const getFavIcon = (website_link) => {
//   console.log("Fetching favicon for " + website_link);
//   fetch(`https://favicongrabber.com/api/grab/${website_link}?pretty=true`)
//     .then((response) => response.json())
//     .then((data) => {
//       const favIcon = data.icons[0]?.src;
//       pg("favicon")
//         .insert({
//           website_link: website_link,
//           favicon_link: favIcon,
//         })
//         .then(() => {
//           return true;
//         })
//         .catch((err) => {
//           console.error(err);
//           return false;
//         });
//     });
// };

const fs = require("fs");
const https = require("https");
const path = require("path");

const downloadFavIcon = async (website_link) => {
  console.log("Downloading favicon for " + website_link);

  let response = await fetch(
    `https://favicongrabber.com/api/grab/${website_link}?pretty=true`
  );
  let responseJson = await response.json();
  let favIconLink = responseJson.icons[0]?.src;

  https
    .get(favIconLink, (res) => {
      // Open file in local filesystem
      const fileName = path.basename(favIconLink);
      const file = fs.createWriteStream(`./public/${fileName}`);

      // Write data into local file
      res.pipe(file);

      // Close the file
      file.on("finish", () => {
        file.close();
        console.log(`File downloaded!`);

        pg("favicon")
          .insert({
            website_link: website_link,
            favicon_link: fileName,
          })
          .then(() => {
            console.log("Favicon inserted into db");
            return true;
          })
          .catch((err) => {
            console.error(err);
            return false;
          });
      });
    })
    .on("error", (err) => {
      console.log("Error: ", err.message);
    });
};

const express = require("express");
const server = express();

server.get("/favicon/:website_link", (req, res) => {
  pg("favicon")
    .select("favicon_link")
    .where("website_link", req.params.website_link)
    .then((data) => {
      if (data.length === 0) {
        res.setHeader("Content-Type", "application/json");
        const resultJson = { message: "Favicon not found" };
        res.send(JSON.stringify(resultJson));
      } else {
        res.send(data);
      }
      res.end();
    });
});

server.get("/favicon/view/:website_link", (req, res) => {
  pg("favicon")
    .select("favicon_link")
    .where("website_link", req.params.website_link)
    .then((data) => {
      if (data.length === 0) {
        res.setHeader("Content-Type", "application/json");
        const resultJson = { message: "Favicon not found" };
        res.send(JSON.stringify(resultJson));
      } else {
        res.send(
          `<img src="http://localhost:3000/public/${data[0].favicon_link}">`
        );
      }
      res.end();
    });
});

// Serve static files
server.use("/public", express.static("public"));

server.listen(3000, () => {
  console.log("Server is listening on http://localhost:3000/");
});

// downloadFavIcon("google.com");
// downloadFavIcon("github.com");
// downloadFavIcon("en.wikipedia.org");
// downloadFavIcon("youtube.com");

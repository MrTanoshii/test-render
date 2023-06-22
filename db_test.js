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

// -- Find customer favorite beverages
const custFavBev = pg
  .select("customer_beverage.id", "beverage.label", "customer.full_name")
  .from("customer_beverage")
  .innerJoin("customer", "customer_beverage.customer_id", "customer.id")
  .innerJoin("beverage", "customer_beverage.beverage_id", "beverage.id")
  .where("customer_beverage.is_favorite", true);

custFavBev.then((data) => {
  console.log(data);
});

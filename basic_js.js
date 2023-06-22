let isGood = false;

isGood ? console.log("Good") : console.log("Bad");

let isGooder = false;

isGood
  ? isGooder
    ? console.log("Gooder")
    : console.log("Good")
  : console.log("Bad");

const dog = {
  name: "Spot",
  age: 3,
  favorite: {
    toy: "ball",
  },
};

const cat = {
  name: "Fluffy",
  age: 5,
};

console.log(dog.name, dog.favorite?.toy);
// console.log(cat.name, cat.favorite.toy); // Throws an error
console.log(cat.name, cat.favorite?.toy); // Returns undefined

if (isGood && dog.name == "Spot" && dog.favorite?.toy == "ball") {
  console.log(dog.name + " is a good boi");
} else {
  console.log(dog.name + " is a bad boi");
}

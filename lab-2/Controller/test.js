var test = new Controller();
console.log(test.isGameComplete());
var array = test.getHand();
console.log(array);
console.log("add test");
console.log(test.addCardToSelection(array[1]));
console.log(test.addCardToSelection(array[0]));
console.log(test.addCardToSelection(array[2]));
console.log(test.addCardToSelection(array[0]));
console.log(test.addCardToSelection(array[3]));
console.log("remove test");
console.log(test.removeCardFromSelection(array[3]));
console.log(test.removeCardFromSelection(array[0]));
console.log(test.removeCardFromSelection(array[0]));
var array = test.currentSelection;

console.log(array);
test.clearSelection;
console.log("clear test");
var array = test.currentSelection;
console.log(array);
console.log("isSelectionSet test");
test.clearSelection();
var array = test.getHand();
console.log(array);
console.log(test.addCardToSelection(array[0]));
console.log(test.addCardToSelection(array[1]));
console.log(test.addCardToSelection(array[2]));
var result = test.isSelectionSet(array)
console.log(result);
test.clearSelection();
console.log("isSelectionSet(true) test");
var array = test.displaySet.getSet();
console.log(array);
console.log(test.addCardToSelection(array[0]));
console.log(test.addCardToSelection(array[1]));
console.log(test.addCardToSelection(array[2]));
var result = test.isSelectionSet(array)
console.log(result);
var test = new Controller();
console.log(test.isGameComplete());
var array = test.getHand();
console.log(array);
console.log("add test");
console.log(test.addCardToSelection(array[1]));
console.log(test.slectionCheck());
console.log(test.addCardToSelection(array[0]));
console.log(test.slectionCheck());
console.log(test.addCardToSelection(array[2]));
console.log(test.slectionCheck());
console.log(test.addCardToSelection(array[0]));
console.log(test.slectionCheck());
console.log(test.addCardToSelection(array[3]));
console.log(test.slectionCheck());
console.log("remove test");
console.log(test.removeCardFromSelection(array[3]));
console.log(test.slectionCheck());
console.log(test.removeCardFromSelection(array[0]));
console.log(test.slectionCheck());
console.log(test.removeCardFromSelection(array[0]));
console.log(test.slectionCheck());
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
console.log("swich mode test");
console.log("Defualt:");
test.setLevelDefault()
console.log(test.displaySet.deck);
console.log(test.displaySet.hand);
console.log("Rookie1:");
test.setLevelRookie1()
console.log(test.displaySet.deck);
console.log(test.displaySet.hand);
console.log("Rookie2:");
test.setLevelRookie2()
console.log(test.displaySet.deck);
console.log(test.displaySet.hand);

console.log(`
  く__,.ヘヽ.        /  ,ー､ 〉
           ＼ ', !-─‐-i  /  /´
           ／｀ｰ'       L/／｀ヽ､
         /   ／,   /|   ,   ,       ',
       ｲ   / /-‐/  ｉ  L_ ﾊ ヽ!   i
        ﾚ ﾍ 7ｲ｀ﾄ   ﾚ'ｧ-ﾄ､!ハ|   |
          !,/7 '0'     ´0iソ|    |
          |.从"    _     ,,,, / |./    |
          ﾚ'| i＞.､,,__  _,.イ /   .i   |
            ﾚ'| | / k_７_/ﾚ'ヽ,  ﾊ.  |
              | |/i 〈|/   i  ,.ﾍ |  i  |
             .|/ /  ｉ：    ﾍ!    ＼  |
              kヽ>､ﾊ    _,.ﾍ､    /､!
              !'〈//｀Ｔ´', ＼ ｀'7'ｰr'
              ﾚ'ヽL__|___i,___,ンﾚ|ノ
                  ﾄ-,/  |___./
                  'ｰ'    !_,.:
`);

function printCard(card){
    console.log(card.imageFile);
}    

function addImgTag(fileName, index){
    return `<img src="../../../View/CardImages/${fileName}" title="Card #${index}"/>`;
}

function addCardButton(fileName, index){
    return `<button id="card-${index}" onclick="window.prompt('Card #${index} Clicked!')">\n${addImgTag(fileName, index)}\n</button>`
}

function Test(){

    this.mainMenuEl = document.getElementById("main-menu");

    this.deckEl = document.getElementById("deck");
    
    this.handEl = document.getElementById("hand");
    
    this.displaySet = new DisplayCardSet();
    this.displaySet.initializeHand();

    this.cardSet = this.displaySet.deck;

    this.setUpEventListners = function (){
        /* 
            Source: How to add an object method as an event listener
            https://medium.com/@photokandy/til-you-can-pass-an-object-instead-of-a-function-to-addeventlistener-7838a3c4ec62
        */
        const buttons = this.mainMenuEl.getElementsByTagName("button");
        buttons[0].addEventListener("click", () => this.displayCard());
        buttons[1].addEventListener("click", () => this.displayDeck());
        buttons[2].addEventListener("click", () => this.newDeck());
        buttons[3].addEventListener("click", () => this.displayHand());
        buttons[4].addEventListener("click", () => this.dealNewHand());
    }
       
    this.displayCard = function (){
        const card = new Card(1, "oval", "solid", "green");
        
        printCard(card);

        let buttons = this.mainMenuEl.getElementsByTagName("button");
        buttons[0].innerHTML += addImgTag(card.imageFile, card.index);
    }
    
    this.displayDeck = function (){
        const buttons = this.mainMenuEl.getElementsByTagName("button");
    
        buttons[1].innerHTML = this.deckEl.hidden ? "Hide Deck" : "Display Deck";
        this.deckEl.hidden = !this.deckEl.hidden;
    }

    this.displayHand = function(){
        const buttons = this.mainMenuEl.getElementsByTagName("button");
    
        buttons[3].innerHTML = this.handEl.hidden ? "Hide Hand" : "Display Hand";
        this.handEl.hidden = !this.handEl.hidden;
    }
    
    this.newDeck = function (){
        this.deckEl.innerHTML = ""; // clear cards from html
        this.cardSet.initializeNormalDeck();
        this.loadDeck();
    }
    
    this.loadDeck = function (){
        this.deckEl.innerHTML = "<p>Cards in Deck:<p>\n";
        this.cardSet.deck.forEach((card, index) => {
            this.deckEl.innerHTML += addCardButton(card.imageFile, index);
        });
    }

    this.loadHand = function(){
        this.handEl.innerHTML = "<p>Cards in Hand:<p>\n";
        this.displaySet.hand.forEach((card, index) => {
            this.handEl.innerHTML += addCardButton(card.imageFile, index);
        });
    }

    this.dealNewHand = function(){
        if(!this.cardSet.isEmpty()){
            this.displaySet.dealFullHand([0,1,2,3,4,5,6,7,8,9,10,11]);
            this.loadDeck();
            this.loadHand();
        }else{
            window.prompt("No More Cards to Deal")
        }
    }
}

const test = new Test();
test.setUpEventListners();

test.loadDeck();
test.loadHand();
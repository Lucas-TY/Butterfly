function Test(){

    this.buttons_div = document.getElementById("buttons");


    this.players_div=document.getElementById("players")

    this.playerset=new PlayerSet()

    this.setUpEventListners = function (){
        /* 
            Source: How to add an object method as an event listener
            https://medium.com/@photokandy/til-you-can-pass-an-object-instead-of-a-function-to-addeventlistener-7838a3c4ec62
        */
        const buttons = this.buttons_div.getElementsByTagName("button");
        buttons[0].addEventListener("click", () => this.addUser());
        buttons[1].addEventListener("click", () => this.addComputer());
        buttons[2].addEventListener("click", () => this.addScore());
        buttons[3].addEventListener("click", () => this.remove_user());
        buttons[4].addEventListener("click", () => this.resetOne());
        buttons[5].addEventListener("click", () => this.resetAll());
    }
    this.addUser= function(){
        input_text=this.buttons_div.getElementsByTagName("input")[0].value
        ret=this.playerset.addPlayer(input_text)
        if(ret==null)
        {
            console.log("fail!")
        }
        else
        {
            this.refresh()
        }
        console.log(input_text)
    }
    this.addComputer= function(){
        input_text=this.buttons_div.getElementsByTagName("input")[0].value
        ret=this.playerset.addComputerPlayer(input_text,0.1)
        if(ret==null)
        {
            console.log("fail!")
        }
        else
        {
            this.refresh()
        }
        console.log(input_text)
    }
    this.addScore=function()
    {
        input_text=this.buttons_div.getElementsByTagName("input")[0].value
        if(!this.playerset.playerExist(input_text))
            return 0
        else
        {
            this.playerset.addScore(input_text,1);
            this.refresh();
        }
    }
    this.remove_user=function()
    {
        input_text=this.buttons_div.getElementsByTagName("input")[0].value
        this.playerset.deletePlayer(input_text)
        this.refresh()
    }
    this.resetOne=function()
    {
        input_text=this.buttons_div.getElementsByTagName("input")[0].value
        this.playerset.playersSearch(input_text).scoreChangeTo(0)
        this.refresh()
    }
    this.resetAll=function()
    {
        this.playerset.resetAllScores()
        this.refresh()
    }
    this.refresh=function(){
        this.players_div.innerHTML = ""

        for(var element of this.playerset.playersList)
        {
            var add = document.createElement("p")
            if (element.isHuman==false)
            {
                add.textContent =element.playerScore+"      " +element.playerName+":computer\t"
            }
            else
            {
                add.textContent =element.playerScore+"      "+ element.playerName+"        \t"
            }
            this.players_div.appendChild(add)
        }
        var add = document.createElement("p")
        add.textContent="highest score:"+this.playerset.playersHighestScore()
        this.players_div.appendChild(add)   
    }



}
const test = new Test();
test.setUpEventListners();

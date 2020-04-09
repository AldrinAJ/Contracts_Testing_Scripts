contract SimpleSuicide {

    int var1 = 12;
int var2 = var1 % 122;



    function sudicideAnyone() public {
        if(var1 < var2){
            selfdestruct(msg.sender);

        }
    }

}
contract SimpleSuicide {

    int var1 = 17;
int var2 = var1 * 172;
int var3 = var1 + var2;



    function sudicideAnyone() public {
        if(var1 == var3){
            selfdestruct(msg.sender);

        }
    }

}
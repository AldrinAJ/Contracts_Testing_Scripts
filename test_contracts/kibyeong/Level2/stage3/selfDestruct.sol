contract SimpleSuicide {

    int var1 = 9;
int var2 = var1 * 92;
int var3 = var1 + var2;
int var4 = var2 * var3;



    function sudicideAnyone() public {
        if(var1 > var4){
            selfdestruct(msg.sender);

        }
    }

}
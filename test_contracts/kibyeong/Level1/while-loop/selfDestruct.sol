contract SimpleSuicide {

    int i;



    function sudicideAnyone() public {
        while(i < 9)
{
            if(i > 9){
                selfdestruct(msg.sender);
            }
            i++;
        }
    }

}
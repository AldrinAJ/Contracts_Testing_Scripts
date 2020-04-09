contract SimpleSuicide {

    int i;



    function sudicideAnyone() public {
        for(i=0; i<6; i++){
            if(i > 6){
                selfdestruct(msg.sender);
            }

        }
    }

}
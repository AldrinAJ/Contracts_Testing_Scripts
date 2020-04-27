contract SimpleSuicide {

    uint random = 15;
    uint compareNumber;

    constructor() public {
    compareNumber = 15;
}

    function sudicideAnyone() public {
        if (random != compareNumber){
            {
                selfdestruct(msg.sender);
            }

        }
    }

}
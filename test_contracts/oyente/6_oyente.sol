// contract AnswerCreator {
//     function getSeed (bytes32 seed) public returns (bytes32) {
//         return seed;
//     }
// }

contract SimpleSuicide {
    function sudicideAnyone() public
    {
        selfdestruct(msg.sender);
    }
}


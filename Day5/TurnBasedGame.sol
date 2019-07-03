// Turn Based Game
pragma solidity ^0.5.4.0;

contract TurnBasedGame {
    
    //0 - PLAYING, TIED - 1, WON - 2
    enum GameState {PLAYING, TIED, WON}
    
    // game variables
    struct Game {
        address player1;
        address player2;
        uint256 score1;
        uint256 score2;
        GameState state;
    }
    
    Game game;
    
    // Mapping of key vs games
    mapping (uint256 => Game) games;
    
    event NewGame(address player1, address player2, uint256 score);
    
    constructor(uint256 uid, address _player2, uint256 _baseScore) public {
        newGame(uid, _player2, _baseScore);
    }
    
    modifier callerMustBeAPlayer(uint256 uid) {
        require(games[uid].player1 == msg.sender || games[uid].player2 == msg.sender, "Caller must be a player");
        _;
    }
    
    function newGame(uint256 uid, address _player2, uint256 _baseScore) public {
        require(games[uid].player1 == address(0) && games[uid].player2 == address(0), "Game must not exist already!");
        games[uid] = Game(msg.sender, _player2, _baseScore, _baseScore, GameState.PLAYING);
        emit NewGame(msg.sender, _player2, _baseScore);
    }
    
    function updateScore(uint256 uid, uint256 _score1, uint256 _score2) public callerMustBeAPlayer(uid) {
        games[uid].score1 = _score1;
        games[uid].score2 = _score2;
    }
    
    function tieGame(uint256 uid) public callerMustBeAPlayer(uid) { //game - tied
        games[uid].state = GameState.TIED;
    }
    
    
    function wonGame(uint256 uid) public callerMustBeAPlayer(uid) { // game - over
        games[uid].state = GameState.WON;
    }
    
    function getInfo(uint256 uid) public view returns(address, address, uint256, uint256, GameState){
        return(games[uid].player1, games[uid].player2, games[uid].score1, games[uid].score2, games[uid].state);
    }
    
    
}

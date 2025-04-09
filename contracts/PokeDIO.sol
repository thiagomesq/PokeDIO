// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.28;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract PokeDIO is ERC721 {
    struct Pokemon {
        string nome;
        uint level;
        string img;
    }

    Pokemon[] public pokemons;
    address public gameOwner;

    constructor() ERC721("PokeDIO", "PKD") {
        gameOwner = msg.sender;
    }

    modifier onlyOwnerOf(uint _pokemonId) {
        require(ownerOf(_pokemonId) == msg.sender, "Apenas o dono pode batalhar com esse Pokemon");
        _;
    }

    function battle(uint _attackingPokemon, uint _defendingPokemon) public onlyOwnerOf(_attackingPokemon) {
        require(_attackingPokemon != _defendingPokemon, "Um Pokemon nao pode batalhar contra ele mesmo");
        Pokemon storage attackingPokemon = pokemons[_attackingPokemon];
        Pokemon storage defendingPokemon = pokemons[_defendingPokemon];

        if (attackingPokemon.level >= defendingPokemon.level) {
            attackingPokemon.level += 2;
            defendingPokemon.level += 1;
        } else {
            attackingPokemon.level += 1;
            defendingPokemon.level += 2;
        }
        
    }

    function createNewPokemon(string memory _name, address _to, string memory _img) public {
        require(msg.sender == gameOwner, "Apenas o dono do jogo pode criar novos Pokemons");
        uint newId = pokemons.length;
        pokemons.push(Pokemon(_name, 1, _img));
        _safeMint(_to, newId);
    }
}
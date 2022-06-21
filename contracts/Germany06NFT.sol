//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

/// @title Germany06NFT
/// @author Lucacez
/// @notice Collection of nft based on the world cup germany 2006.

contract Germany06NFT is ERC721 {

    using Counters for Counters.Counter;
    using Strings for uint256;

    /* --------------------------------- Properties -------------------------------- */

    address payable s_owner;
    uint256 public constant s_mintPrice = 0.02 ether;
    address payable s_mainWallet;

    uint256 public constant s_total_jugadores = 184;
    Counters.Counter public s_contador_jugadores;
    uint256 public constant s_totalArqueros = 24;
    Counters.Counter public s_contadorArqueros;
    uint256 public constant s_totalDefensas = 60;
    Counters.Counter public s_contadorDefensas;
    uint256 public constant s_totalMediocentros = 59;
    Counters.Counter public s_contadorMediocentros;
    uint256 public constant s_totalDelanteros = 41;
    Counters.Counter public s_contadorDelanteros;

    string public baseTokenURIG = "ipfs://bafybeignqad4tcmnpf2b6bnhgqyysunbd64gt4yj7sqithmhe2isoszdqm/";
    string public baseTokenURID = "ipfs://bafybeidg6tyc7vvvx64o5en6pc2d2eqagpexqyx6znsf2ejc5mevukv2gy/";
    string public baseTokenURIM = "ipfs://bafybeicmtyhdamd4535gtypd7oof3e5ykab7mwo5w6vxrzyownp3o2uvrq/";
    string public baseTokenURIF = "ipfs://bafybeiexjqfboojsitnhwhy7bro7qhm3lty5zfg72paawwds5hskrh7z6y/";


    mapping (uint256 => mapping (string => uint256)) public s_jugador;

    /* --------------------------------- Events -------------------------------- */

    event MintArquero(address indexed direccion, uint256 player);
    event MintDefensa(address indexed direccion, uint256 player);
    event MintMediocentro(address indexed direccion, uint256 player);
    event MintDelantero(address indexed direccion, uint256 player);

    error MintRevert(string messege);

    
    /* --------------------------------- Constructor -------------------------------- */

    constructor() ERC721("Germany06NFT", "06") {
        s_owner = payable(msg.sender);
        s_contador_jugadores.increment();
        s_contadorArqueros.increment();
        s_contadorDefensas.increment();
        s_contadorMediocentros.increment();
        s_contadorDelanteros.increment();
    }


    /* --------------------------------- Functions -------------------------------- */

    function _baseURIG() internal view virtual returns (string memory) {
        return baseTokenURIG;
    }

    function _baseURID() internal view virtual returns (string memory) {
        return baseTokenURID;
    }

    function _baseURIM() internal view virtual returns (string memory) {
        return baseTokenURIM;
    }

    function _baseURIF() internal view virtual returns (string memory) {
        return baseTokenURIF;
    }
    
    /// @notice Mint a complete team, 5 players.
    function mintTeam() public payable {

        uint256 contadorArqueros = s_contadorArqueros.current();
        uint256 contadorDefensas = s_contadorDefensas.current();
        uint256 contadorMediocentros = s_contadorMediocentros.current();
        uint256 contadorDelanteros = s_contadorDelanteros.current();  

        uint256 contador_jugadores = s_contador_jugadores.current();

        if(balanceOf(msg.sender) > 5){
            revert MintRevert("Ya tiene todo el equipo");
        }
        if(s_total_jugadores < contador_jugadores){
            revert MintRevert("Todos los jugadores ya han sido fichados");
        }
        if(s_totalArqueros < contadorArqueros){
            revert MintRevert("Todos los arqueros ya han sido fichados");
        }
        if(s_totalDefensas < contadorDefensas){
            revert MintRevert("Todos los defensas ya han sido fichados");
        }
        if(s_totalMediocentros < contadorMediocentros){
            revert MintRevert("Todos los mediocentros ya han sido fichados");
        }
        if(s_totalDelanteros < contadorDelanteros){
            revert MintRevert("Todos los delanteros ya han sido fichados");
        }
        if(msg.value < s_mintPrice * 5){
            revert MintRevert("Los fondos no son suficientes");
        }
        
        s_owner.transfer(msg.value);

        s_jugador[contador_jugadores]["Goalkeeper"] = contadorArqueros; 
        _safeMint(msg.sender, contador_jugadores);

        emit MintArquero(msg.sender, contador_jugadores);

        s_contador_jugadores.increment();
        s_contadorArqueros.increment();
        contador_jugadores = s_contador_jugadores.current();

        
        s_jugador[contador_jugadores]["Defender"] = contadorDefensas;
        _safeMint(msg.sender, contador_jugadores);

        emit MintDefensa(msg.sender, contador_jugadores);

        s_contador_jugadores.increment();
        s_contadorDefensas.increment();
        contador_jugadores = s_contador_jugadores.current();
        contadorDefensas = s_contadorDefensas.current();


        s_jugador[contador_jugadores]["Defender"] = contadorDefensas;
        _safeMint(msg.sender, contador_jugadores);

        emit MintDefensa(msg.sender, contador_jugadores);

        s_contador_jugadores.increment();
        s_contadorDefensas.increment();
        contador_jugadores = s_contador_jugadores.current();


        s_jugador[contador_jugadores]["Midfielder"] = contadorMediocentros;
        _safeMint(msg.sender, contador_jugadores);

        emit MintMediocentro(msg.sender, contador_jugadores);

        s_contador_jugadores.increment();
        s_contadorMediocentros.increment();
        contador_jugadores = s_contador_jugadores.current();


        s_jugador[contador_jugadores]["Forward"] = contadorDelanteros;
        _safeMint(msg.sender, contador_jugadores);

        emit MintDelantero(msg.sender, contador_jugadores);

        s_contador_jugadores.increment();
        s_contadorDelanteros.increment();

    }


    /// @notice Mint a Goalkeeper.
    function mintArquero() public payable {

        uint256 contador_jugadores = s_contador_jugadores.current();
        uint256 contadorArqueros = s_contadorArqueros.current();

        if(balanceOf(msg.sender) >= 10){
            revert MintRevert("Ya tienes el equipo completo");
        }
        if(s_total_jugadores < contador_jugadores){
            revert MintRevert("Todos los jugadores ya han sido fichados");
        }
        if(s_totalArqueros < contadorArqueros){
            revert MintRevert("Todos los arqueros ya han sido fichados");
        }
        if(msg.value < s_mintPrice){
            revert MintRevert("Los fondos no son suficientes");
        }

        s_owner.transfer(msg.value);

        s_jugador[contador_jugadores]["Goalkeeper"] = contadorArqueros;
        _safeMint(msg.sender, contador_jugadores);

        emit MintArquero(msg.sender, contador_jugadores);

        s_contador_jugadores.increment();
        s_contadorArqueros.increment();
    } 


    /// @notice Mint a Defender.
    function mintDefensa() public payable {

        uint256 contador_jugadores = s_contador_jugadores.current();
        uint256 contadorDefensas = s_contadorDefensas.current();
        
        if(balanceOf(msg.sender) >= 10){
            revert MintRevert("Ya tienes el equipo completo");
        }
        if(s_total_jugadores < contador_jugadores){
            revert MintRevert("Todos los jugadores ya han sido fichados");
        }
        if(s_totalDefensas < contadorDefensas){
            revert MintRevert("Todos los defensas ya han sido fichados");
        }
        if(msg.value < s_mintPrice){
            revert MintRevert("Los fondos no son suficientes");
        }

        s_owner.transfer(msg.value);

        s_jugador[contador_jugadores]["Defender"] = contadorDefensas;
        _safeMint(msg.sender, contador_jugadores);

        emit MintDefensa(msg.sender, contador_jugadores);

        s_contador_jugadores.increment();
        s_contadorDefensas.increment();
    } 


    /// @notice Mint a Midfielder.
    function mintMediocentro() public payable {

        uint256 contador_jugadores = s_contador_jugadores.current();
        uint256 contadorMediocentros = s_contadorMediocentros.current();
        
        if(balanceOf(msg.sender) >= 10){
            revert MintRevert("Ya tienes el equipo completo");
        }
        if(s_total_jugadores < contador_jugadores){
            revert MintRevert("Todos los jugadores ya han sido fichados");
        }
        if(s_totalMediocentros < contadorMediocentros){
            revert MintRevert("Todos los mediocentros ya han sido fichados");
        }
        if(msg.value < s_mintPrice){
            revert MintRevert("Los fondos no son suficientes");
        }

        s_owner.transfer(msg.value);

        s_jugador[contador_jugadores]["Midfielder"] = contadorMediocentros;
        _safeMint(msg.sender, contador_jugadores); 

        emit MintMediocentro(msg.sender, contador_jugadores);

        s_contador_jugadores.increment();
        s_contadorMediocentros.increment();
    } 


    /// @notice Mint a Forward.
    function mintDelantero() public payable {

        uint256 contador_jugadores = s_contador_jugadores.current();
        uint256 contadorDelanteros = s_contadorDelanteros.current();
        
        if(balanceOf(msg.sender) >= 10){
            revert MintRevert("Ya tienes el equipo completo");
        }
        if(s_total_jugadores < contador_jugadores){
            revert MintRevert("Todos los jugadores ya han sido fichados");
        }
        if(s_totalDelanteros < contadorDelanteros){
            revert MintRevert("Todos los delanteros ya han sido fichados");
        }
        if(msg.value < s_mintPrice){
            revert MintRevert("Los fondos no son suficientes");
        }

        s_owner.transfer(msg.value);

        s_jugador[contador_jugadores]["Forward"] = contadorDelanteros;
        _safeMint(msg.sender, contador_jugadores);

        emit MintDelantero(msg.sender, contador_jugadores);

        s_contador_jugadores.increment();
        s_contadorDelanteros.increment();
    }


    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

        string memory json = ".json";
        string memory baseURIG = _baseURIG();
        string memory baseURID = _baseURID();
        string memory baseURIM = _baseURIM();
        string memory baseURIF = _baseURIF();

        if(s_jugador[tokenId]["Goalkeeper"] != 0){
            return bytes(baseURIG).length > 0 ? string(abi.encodePacked(baseURIG, s_jugador[tokenId]["Goalkeeper"].toString(), json)) : "";
        }
        if(s_jugador[tokenId]["Defender"] != 0){
            return bytes(baseURID).length > 0 ? string(abi.encodePacked(baseURID, s_jugador[tokenId]["Defender"].toString(), json)) : "";
        }
        if(s_jugador[tokenId]["Midfielder"] != 0){
            return bytes(baseURIM).length > 0 ? string(abi.encodePacked(baseURIM, s_jugador[tokenId]["Midfielder"].toString(), json)) : "";
        }
        if(s_jugador[tokenId]["Forward"] != 0){
            return bytes(baseURIF).length > 0 ? string(abi.encodePacked(baseURIF, s_jugador[tokenId]["Forward"].toString(), json)) : "";
        }
    }
}

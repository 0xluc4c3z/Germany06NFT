//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";


contract PlayersNFT is ERC721 {

    using Counters for Counters.Counter;

    address payable s_owner;
    uint256 public constant s_mintPrice = 0.02 ether;
    address payable s_mainWallet;

    uint256 public constant s_total_jugadores = 544;
    Counters.Counter s_contador_jugadores;
    uint256 public constant s_totalArqueros = 100;
    Counters.Counter s_contadorArqueros;
    uint256 public constant s_totalDefensas = 100;
    Counters.Counter s_contadorDefensas;
    uint256 public constant s_totalMediocentros = 100;
    Counters.Counter s_contadorMediocentros;
    uint256 public constant s_totalVolantes = 100;
    Counters.Counter s_contadorVolantes;
    uint256 public constant s_totalDelanteros = 100;
    Counters.Counter s_contadorDelanteros;

    string public baseTokenURI = "";

    event MintArquero(address indexed direccion, uint256 player);
    event MintDefensa(address indexed direccion, uint256 player);
    event MintMediocentro(address indexed direccion, uint256 player);
    event MintVolante(address indexed direccion, uint256 player);
    event MintDelantero(address indexed direccion, uint256 player);

    error MintRevert(string messege);
    
    mapping (uint256 => uint256) s_jugador;
    

    constructor() ERC721("QatarNFT", "QM"){
        s_owner = payable(msg.sender);
        s_contador_jugadores.increment();
        s_contadorArqueros.increment();
        s_contadorDefensas.increment();
        s_contadorMediocentros.increment();
        s_contadorVolantes.increment();
        s_contadorDelanteros.increment();
    }


    function _baseURI() internal view virtual override returns (string memory) {
        return baseTokenURI;
    }


    function mintTeam() public payable {

        uint256 contadorArqueros = s_contadorArqueros.current();
        uint256 contadorDefensas = s_contadorDefensas.current();
        uint256 contadorMediocentros = s_contadorMediocentros.current();
        uint256 contadorVolantes = s_contadorVolantes.current();
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
        if(s_totalDefensas > contadorDefensas){
            revert MintRevert("Todos los defensas ya han sido fichados");
        }
        if(s_totalMediocentros < contadorMediocentros){
            revert MintRevert("Todos los mediocentros ya han sido fichados");
        }
        if(s_totalVolantes < contadorVolantes){
            revert MintRevert("Todos los volantes ya han sido fichados");
        }
        if(s_totalDelanteros < contadorDelanteros){
            revert MintRevert("Todos los delanteros ya han sido fichados");
        }
        if(msg.value < s_mintPrice * 5){
            revert MintRevert("Los fondos no son suficientes");
        }
        
        s_owner.transfer(msg.value);

        s_jugador[contador_jugadores] = contadorArqueros; 
        _safeMint(msg.sender, contador_jugadores);

        emit MintArquero(msg.sender, contador_jugadores);

        s_contador_jugadores.increment();
        s_contadorArqueros.increment();
        contador_jugadores = s_contador_jugadores.current();

        
        s_jugador[contador_jugadores] = contadorDefensas;
        _safeMint(msg.sender, contador_jugadores);

        emit MintDefensa(msg.sender, contador_jugadores);

        s_contador_jugadores.increment();
        s_contadorDefensas.increment();
        contador_jugadores = s_contador_jugadores.current();


        s_jugador[contador_jugadores] = contadorMediocentros;
        _safeMint(msg.sender, contador_jugadores);

        emit MintMediocentro(msg.sender, contador_jugadores);

        s_contador_jugadores.increment();
        s_contadorMediocentros.increment();
        contador_jugadores = s_contador_jugadores.current();


        s_jugador[contador_jugadores] = contadorVolantes;
        _safeMint(msg.sender, contador_jugadores);

        emit MintVolante(msg.sender, contador_jugadores);

        s_contador_jugadores.increment();
        s_contadorVolantes.increment();
        contador_jugadores = s_contador_jugadores.current();

        s_jugador[contador_jugadores] = contadorDelanteros;
        _safeMint(msg.sender, contador_jugadores);

        emit MintDelantero(msg.sender, contador_jugadores);

        s_contador_jugadores.increment();
        s_contadorDelanteros.increment();

    }

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

        s_jugador[contador_jugadores] = contadorArqueros;
        _safeMint(msg.sender, contador_jugadores);

        emit MintArquero(msg.sender, contador_jugadores);

        s_contador_jugadores.increment();
        s_contadorArqueros.increment();
    } 

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

        s_jugador[contador_jugadores] = contadorDefensas;
        _safeMint(msg.sender, contador_jugadores);

        emit MintDefensa(msg.sender, contador_jugadores);

        s_contador_jugadores.increment();
        s_contadorDefensas.increment();
    } 

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

        s_jugador[contador_jugadores] = contadorMediocentros;
        _safeMint(msg.sender, contador_jugadores); 

        emit MintMediocentro(msg.sender, contador_jugadores);

        s_contador_jugadores.increment();
        s_contadorMediocentros.increment();
    } 

    function mintVolante() public payable {

        uint256 contador_jugadores = s_contador_jugadores.current();
        uint256 contadorVolantes = s_contadorVolantes.current();
        
        if(balanceOf(msg.sender) >= 10){
            revert MintRevert("Ya tienes el equipo completo");
        }
        if(s_total_jugadores < contador_jugadores){
            revert MintRevert("Todos los jugadores ya han sido fichados");
        }
        if(s_totalVolantes < contadorVolantes){
            revert MintRevert("Todos los volantes ya han sido fichados");
        }
        if(msg.value < s_mintPrice){
            revert MintRevert("Los fondos no son suficientes");
        }

        s_owner.transfer(msg.value);

        s_jugador[contador_jugadores] = contadorVolantes;
        _safeMint(msg.sender, contador_jugadores);

        emit MintVolante(msg.sender, contador_jugadores);

        s_contador_jugadores.increment();
        s_contadorVolantes.increment();
    } 

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

        s_jugador[contador_jugadores] = contadorDelanteros;
        _safeMint(msg.sender, contador_jugadores);

        emit MintDelantero(msg.sender, contador_jugadores);

        s_contador_jugadores.increment();
        s_contadorDelanteros.increment();
    }

    function infoJug(uint256 tokenId) public view returns(uint256){
        return s_jugador[tokenId];
    }  

}

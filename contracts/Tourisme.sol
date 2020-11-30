 // SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;
import "./TourToken.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract Tourisme is Ownable{
TourToken private _tour;


using Counters for Counters.Counter;
Counters.Counter private _clientIds;
Counters.Counter private _offerIds;

address payable _agence;


uint256 counterClient;
uint256 counterOffer;
uint256 totalprice;

address _addrClient;
address payable _addrAgence;

 
mapping (address => Client) public clients;

mapping (uint256 => Offer) public offers;

enum Destination { NewYork, Maldives, Vancouver, Barcelona }

//mapping (address => uint256) public balances_client;

//mapping (address => uint256) public balances_agence;

 constructor(address owner) public {
    transferOwnership(owner);
    
 }

function setTourToken(address tourAddress) external onlyOwner {
  _tour = TourToken(tourAddress);
}

/* Variables d'état */
struct Client {
     string nom;
     string email;
     string password;
     bool isClient;
     uint256 no_reservation;
     uint date_registration;
 
}

struct Offer {
    
    Destination _dest;
  //  bool isTransport;
  //  bool isSejour;
  //  bool isRestauration;
  //  bool isActivites;
  //  bool isTours;
   uint256 priceinTokens;
}

function register(string memory _nom, string memory _email, string memory _password) public {
    _addrClient = 0x44F31c324702C418d3486174d2A200Df1b345376;
   // counterClient++;
    _clientIds.increment();
    //counterClient++;
    require (clients[msg.sender].isClient == false, 'only nonClients can use this function');
    uint newclientId = _clientIds.current();
    clients[_addrClient] = Client(_nom, _email, _password, true, 0, block.timestamp);
} 

 function clientId() public view returns (uint256) {
        
        return _clientIds.current();
    } 

function getClient(address _addr) public view returns (Client memory) {
        return clients[_addr];
    }
 

 function choose_offer(Destination _destination, bool _isSejour, bool _isTransport, bool _isRestauration, bool _isActivities, bool _isTours) public returns (uint256) {
    //counterOffer++;

    _offerIds.increment();
    uint256 newofferId = _offerIds.current();
    uint price;
    uint PRICE_SEJOUR;
    uint PRICE_TRANSPORT;
    uint PRICE_RESTAURATION;
    uint PRICE_ACTIVITIES;
    uint PRICE_TOURS;
    if (_destination == Destination.NewYork) {
        if (_isSejour == true) {
        PRICE_SEJOUR = 100;
        price +=100;
        }
        if (_isTransport == true) {
        PRICE_TRANSPORT = 50;
        price +=50;
        }
        if (_isRestauration == true) {
        PRICE_RESTAURATION = 50;
        price +=50;
        }
        if (_isActivities == true) {
        PRICE_ACTIVITIES = 50;
        price +=50;
        }
        if (_isTours == true) {
        PRICE_TOURS = 50;
        price  += 50;
        }
    }
    else if (_destination == Destination.Maldives) {
         if (_isSejour == true) {
        PRICE_SEJOUR = 150;
        price +=150;
        }
        if (_isTransport == true) {
        PRICE_TRANSPORT = 30;
        price +=30;
        }
        if (_isRestauration == true) {
        PRICE_RESTAURATION = 50;
        price +=50;
        }
        if (_isActivities == true) {
        PRICE_ACTIVITIES = 20;
        price +=20;
        }
        if (_isTours == true) {
        PRICE_TOURS = 50;
        price  += 50;
        }
    }
    else if (_destination == Destination.Vancouver) {
        if (_isSejour == true) {
        PRICE_SEJOUR = 80;
        price +=80;
        }
        if (_isTransport == true) {
        PRICE_TRANSPORT = 40;
        price +=40;
        }
        if (_isRestauration == true) {
        PRICE_RESTAURATION = 40;
        price += 40;
        }
        if (_isActivities == true) {
        PRICE_ACTIVITIES = 30;
        price +=30;
        }
        if (_isTours == true) {
        PRICE_TOURS = 30;
        price  += 30;
        }
    }
    else if(_destination == Destination.Barcelona) {
      if (_isSejour == true) {
        PRICE_SEJOUR = 50;
        price +=50;
        }
        if (_isTransport == true) {
        PRICE_TRANSPORT = 30;
        price +=30;
        }
        if (_isRestauration == true) {
        PRICE_RESTAURATION = 30;
        price += 30;
        }
        if (_isActivities == true) {
        PRICE_ACTIVITIES = 20;
        price +=20;
        }
        if (_isTours == true) {
        PRICE_TOURS = 50;
        price  += 50;
        }
    }
    else revert("Invalid destination");
   // uint totalPrice = offers[newofferId].priceinTokens;
    offers[newofferId] = Offer(_destination, price);
   // totalprice = offers[newofferId].priceinTokens;
   // Offer memory c = offers[newofferId];
   // return (c.priceinTokens);
   return _offerIds.current();
}

function getPrice(uint256 _id) public view returns(uint256) {
    Offer memory c = offers[_id];
    return (c.priceinTokens);
}

    function getOffer(uint256 _id) public view returns (Offer memory) {
        return offers[_id];
    } 
 
 
function reserveByClient(uint _id) public {
   
    _tour.operatorSend(msg.sender, _addrAgence, offers[_id].priceinTokens, "", "");
    clients[msg.sender].no_reservation = clients[msg.sender].date_registration;
  }
  
}
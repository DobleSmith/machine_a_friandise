pragma solidity >=0.7.0 <0.9.0;

contract friandise {
    
    uint256 private _tokenIds;

    address private owner;
    

    uint max_item;
    uint limitAll ;
    //uint limitProduct = 2;

    struct Product {
        uint256 productToken;
        //uint typeProduit;
    }

    mapping(uint => Product) public pJaune;
    uint pJ_count = 0;
    uint priceJ;

    mapping(uint => Product) public pVert;
    uint pV_count = 0;
    uint priceV;

    mapping(uint => Product) public pRouge;
    uint pR_count = 0;
    uint priceR;

    mapping(uint => Product) public pOrange;
    uint pO_count = 0;
    uint priceO;

    mapping(uint => Product) public pBleu;
    uint pB_count = 0;
    uint priceB;

    mapping(address => Product[]) private vendu; // user - product
    //mapping(address => uint[]) private vendu; // user - product

    constructor(uint _max_item,uint _limitAll, uint _priceJ, uint _priceV, uint _priceR, uint _priceO, uint _priceB) {
        _tokenIds = 0;
        limitAll = _limitAll;
        max_item = _max_item;
        owner = msg.sender;
        // Prix des produits
        priceJ = _priceJ;
        priceV = _priceV;
        priceR = _priceR;
        priceO = _priceO;
        priceB = _priceB;
    }

    modifier isOwner() {
        require(owner == msg.sender, "Vous n'etes pas le proprio");
        _;
    }

    function getProductByUser(address user) public view returns(Product[] memory){
        return vendu[user];
    }

    function getMaxItems() public view returns(uint){
        return max_item;
    }

    /*function verifyBuy(address _user,uint _typeProduct) internal {
        Product[] memory products = getProductByUser(_user);
        uint jaune = 0;
        uint vert = 0;
        uint rouge = 0;
        uint orange = 0;
        uint bleu = 0;
        
        for(uint i = 0; i<products.length; i++){
            if(products[i].typeProduit == _typeProduct){
                jaune++;
                require(jaune<limitProduct, "Limite bonbon jaune !");
            }
            else if(products[i].typeProduit == _typeProduct){
                vert++;
                require(vert<limitProduct, "Limite bonbon vert !");
            }  
            else if(products[i].typeProduit == _typeProduct){
                rouge++;
                require(rouge<limitProduct, "Limite bonbon rouge !");
            } if(products[i].typeProduit == _typeProduct){
                orange++;
                require(orange<limitProduct, "Limite bonbon orange !");
            } if(products[i].typeProduit == _typeProduct){
                bleu++;
                require(bleu<limitProduct, "Limite bonbon bleu !");
            }
            require(products.length < limitAll,"Limite d'achat !");
        }
    }*/



    function refillAll() public isOwner{
        refullProduitJaune();
        refullProduitVert();
        refullProduitRouge();
        refullProduitOrange();
        refullProduitBleu();
    }


    function refullProduitJaune() public isOwner {
        uint i;
        for(i = pJ_count;i < max_item;i++){
            uint tokenJ = generateToken();
            Product memory produit = Product(tokenJ);
            pJaune[pJ_count]=produit;
            pJ_count++;
        } 
    }
    function refullProduitVert() public isOwner {
        uint i;
        for(i = pV_count;i < max_item;i++){
            uint tokenV = generateToken();
            Product memory produit = Product(tokenV);
            pVert[pV_count]=produit;
            pV_count++;
        }  
    }
    function refullProduitRouge() public isOwner {
        uint i;
        for(i = pR_count;i < max_item;i++){
            uint tokenR = generateToken();
            Product memory produit = Product(tokenR);
            pRouge[pR_count]=produit;
            pR_count++;
        }  
    }
    function refullProduitOrange() public isOwner {
        uint i;
        for(i = pO_count;i < max_item;i++){
            uint tokenO = generateToken();
            Product memory produit = Product(tokenO);
            pOrange[pO_count]=produit;
            pO_count++;
        } 
    }
    function refullProduitBleu() public isOwner {
        uint i;
        for(i = pB_count;i < max_item;i++){
            uint tokenB = generateToken();
            Product memory produit = Product(tokenB);
            pBleu[pB_count]=produit;
            pB_count++;
        }  
    }


    function generateToken() private returns (uint256) {
        _tokenIds++;
        return _tokenIds;
    }


    function buyJaune() external payable  {
        require(pJ_count>0,"Produit jaune est vide");
        require(msg.value >= priceJ,"Il manque de l'argent");
        require(getProductByUser(msg.sender).length < limitAll,"Limite d'achat !");
        //verifyBuy(msg.sender, 1); 
        pJ_count--;
        Product memory p = pJaune[pJ_count];
        delete(pJaune[pJ_count]);
        
        vendu[msg.sender].push(p);
        payable(owner).transfer(msg.value);
    }

    function buyVert() external payable {
        require(pV_count>0,"Produit vert est vide");
        require(msg.value >= priceV,"expensive !");
        require(getProductByUser(msg.sender).length < limitAll,"Limite d'achat !");
        //verifyBuy(msg.sender, 2); 
        pV_count--;
        Product memory p = pVert[pV_count];
        delete(pVert[pV_count]);
        
        vendu[msg.sender].push(p);
        payable(owner).transfer(msg.value);
    }

    function buyRouge() external payable  {
        require(pR_count>0,"Produit rouge est vide");
        require(msg.value >= priceR,"expensive !");
        require(getProductByUser(msg.sender).length < limitAll,"Limite d'achat !");
        //verifyBuy(msg.sender, 3); 
        pR_count--;
        Product memory p = pRouge[pR_count];
        delete(pRouge[pR_count]);
        
        vendu[msg.sender].push(p);
        payable(owner).transfer(msg.value);
    }

    function buyOrange() external payable  {
        require(pO_count>0,"Produit orange est vide");
        require(msg.value >= priceO,"expensive !");
        require(getProductByUser(msg.sender).length < limitAll,"Limite d'achat !");
        //verifyBuy(msg.sender, 4); 
        pO_count--;
        Product memory p = pOrange[pO_count];
        delete(pOrange[pO_count]);
        
        vendu[msg.sender].push(p);
        payable(owner).transfer(msg.value);
    }

    function buyBleu() external payable  {
        require(pB_count>0,"Produit bleu est vide");
        require(msg.value >= priceB,"expensive !");
        uint nbrProduct = getProductByUser(msg.sender).length;
        require(nbrProduct < 0x5, "Limite d'achat !");
        //verifyBuy(msg.sender, 5); 
        pB_count--;
        Product memory p = pBleu[pB_count];
        delete(pBleu[pB_count]);
        
        vendu[msg.sender].push(p);
        payable(owner).transfer(msg.value);
    }



	/*function getJaune() public view returns (uint) {
		return pJ_count;
	}
	function getVert() public view returns (uint) {
		return pV_count;
	}
	function getRouge() public view returns (uint){
		return pR_count;
	}
	function getOrange() public view returns (uint) {
		return pO_count;
	}
	function getBleu() public view returns (uint) {
		return pB_count;
	}*/

    function getAllpJaune() public view returns(Product[] memory){
        Product[] memory produits = new Product[](pJ_count);
        for (uint i = 0; i < pJ_count; i++) {
            produits[i] = pJaune[i];
        }
        return produits;
    }

    function getAllpVert() public view returns(Product[] memory){
        Product[] memory produits = new Product[](pV_count);
        for (uint i = 0; i < pV_count; i++) {
            produits[i] = pVert[i];
        }
        return produits;
    }

    function getAllpRouge() public view returns(Product[] memory){
        Product[] memory produits = new Product[](pR_count);
        for (uint i = 0; i < pR_count; i++) {
            produits[i] = pRouge[i];
        }
        return produits;
    }
    function getAllpOrange() public view returns(Product[] memory){
        Product[] memory produits = new Product[](pO_count);
        for (uint i = 0; i < pO_count; i++) {
            produits[i] = pOrange[i];
        }
        return produits;
    }
    function getAllpBleu() public view returns(Product[] memory){
        Product[] memory produits = new Product[](pB_count);
        for (uint i = 0; i < pB_count; i++) {
            produits[i] = pBleu[i];
        }
        return produits;
    }

}

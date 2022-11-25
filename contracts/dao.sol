// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@aragon/os/contracts/acl/ACL.sol";
import "@aragon/os/contracts/apm/Repo.sol";
import "@aragon/os/contracts/apm/APMNamehash.sol"; //Hardcoded constants to save gas
import "@aragon/os/contracts/kernel/Kernel.sol";
import "@aragon/os/contracts/lib/ens/ENS.sol";
import "@aragon/os/contracts/lib/ens/PublicResolver.sol";
import "@aragon/os/contracts/factory/DAOFactory.sol";
import "@aragon/os/contracts/common/IsContract.sol"; // To check that an address is actually a contract rather than an address not being a contract.
import "@aragon/os/contracts/common/Uint256Helpers.sol";
import "@aragon/id/contracts/IFIFSResolvingRegistrar.sol";
import "contracts/WakaToken.sol";
import "contracts/TokenFactory.sol";


contract DAO is APMNamehash, IsContract {
    using Uint256Helpers for uint256;

    
    string constant private ERROR_ENS_NOT_CONTRACT = "TEMPLATE_ENS_NOT_CONTRACT";
    string constant private ERROR_DAO_FACTORY_NOT_CONTRACT = "TEMPLATE_DAO_FAC_NOT_CONTRACT";
    string constant private ERROR_ARAGON_ID_NOT_PROVIDED = "TEMPLATE_ARAGON_ID_NOT_PROVIDED";
    string constant private ERROR_ARAGON_ID_NOT_CONTRACT = "TEMPLATE_ARAGON_ID_NOT_CONTRACT";
    string constant private ERROR_TOKEN_FACTORY_NOT_PROVIDED = "TEMPLATE_TOKEN_FAC_NOT_PROVIDED";
    string constant private ERROR_TOKEN_FACTORY_NOT_CONTRACT = "TEMPLATE_TOKEN_FAC_NOT_CONTRACT";
    string constant private ERROR_CANNOT_CAST_VALUE_TO_ADDRESS = "TEMPLATE_CANNOT_CAST_VALUE_TO_ADDRESS";
    string constant private ERROR_INVALID_ID = "TEMPLATE_INVALID_ID";

    ENS internal ens;
    DAOFactory internal daoFactory;
    TokenFactory internal tokenFactory;
    

    event DeployDao(address dao);
    event SetupDao(address dao);
    event DeployToken(address token);
    

    constructor(DAOFactory _daoFactory, ENS _ens, TokenFactory _tokenFactory
    
    ) public {
        require(isContract(address(_ens)), ERROR_ENS_NOT_CONTRACT);
        require(isContract(address(_daoFactory)), ERROR_DAO_FACTORY_NOT_CONTRACT);

        ens = _ens;
        aragonID = _id;
        daoFactory = _daoFactory;
        tokenFactory = _tokenFactory;
    }

    /**
    * @dev Create a DAO using the DAO Factory and grant the template root permissions so it has full
    *      control during setup. 
    */
    function _createDAO() internal returns (Kernel dao, ACL acl) {
        dao = daoFactory.newDAO(this);
        emit DeployDao(address(dao));
        acl = ACL(dao.acl());
        _createPermissionForTemplate(acl, dao, dao.APP_MANAGER_ROLE());
    }

    

    


}
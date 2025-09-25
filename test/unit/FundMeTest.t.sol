//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {AggregatorV3Interface} from "@chainlink/interfaces/AggregatorV3Interface.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";
import {HelperConfig} from "../../script/HelperConfig.s.sol";

contract FundMeTest is Test {
    FundMe fundMe;
    HelperConfig helperConfig;

    address USER = makeAddr("user");
    address USER1 = makeAddr("user1");
    uint256 constant SENDING_VALUE = 0.1 ether;
    uint256 constant STARTING_VALUE = 100e18;

    function setUp() external {
        /*
        fundMe = new FundMe(
            AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306)
        );
        */
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();

        helperConfig = new HelperConfig();
    }

    function testMinimumDollarIsFive() public view {
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function testOwnerIsMsgSender() public view {
        assertEq(fundMe.getOwner(), msg.sender);
    }

    function testPriceFeedVersionIsFour() public view {
        uint256 version = fundMe.getVersion();
        assertEq(version, 4);
    }

    function testFundFailsWithoutEnoughtETH() public {
        vm.expectRevert();
        fundMe.fund();
    }

    modifier funded() {
        vm.prank(USER);
        vm.deal(USER, STARTING_VALUE);
        fundMe.fund{value: SENDING_VALUE}();
        _;
    }

    function testFundUpdatesDataStructure() public funded {
        assertEq(fundMe.getAddressToAmountFunded(USER), SENDING_VALUE);
        assertEq(fundMe.getFundersAddressByIndex(0), USER);
    }

    function testWithdrawFailsWithoutOwner() public funded {
        vm.prank(USER);
        vm.expectRevert();
        fundMe.withdraw();
    }

    function testWithdrawWithSingleFunder() public funded {
        // Arrange
        uint256 startingOwnerBalance = fundMe.getOwner().balance;
        uint256 startingContractBalance = address(fundMe).balance;

        // Act
        vm.prank(fundMe.getOwner());
        fundMe.withdraw();
        uint256 endingOwnerBalance = fundMe.getOwner().balance;
        uint256 endingContractBalance = address(fundMe).balance;

        // Assert
        assertEq(endingContractBalance, 0);
        assertEq(endingOwnerBalance, startingContractBalance + startingOwnerBalance);
    }

    function testWithdrawWithMultipleFunder() public funded {
        uint160 numberOfUsers = 10;
        uint160 startIndex = 1;

        for (uint160 i = startIndex; i < numberOfUsers; i++) {
            hoax(address(i), SENDING_VALUE);
            fundMe.fund{value: SENDING_VALUE}();
        }

        uint256 startingOwnerBalance = fundMe.getOwner().balance;
        uint256 startingContractBalance = address(fundMe).balance;

        vm.prank(fundMe.getOwner());
        fundMe.withdraw();
        uint256 endingOwnerBalance = fundMe.getOwner().balance;
        uint256 endingContractBalance = address(fundMe).balance;

        assert(endingContractBalance == 0);
        assert(endingOwnerBalance == startingOwnerBalance + startingContractBalance);
    }

    function testWithdrawWithMultipleFunderCheaper() public funded {
        uint160 numberOfUsers = 10;
        uint160 startIndex = 1;

        for (uint160 i = startIndex; i < numberOfUsers; i++) {
            hoax(address(i), SENDING_VALUE);
            fundMe.fund{value: SENDING_VALUE}();
        }

        uint256 startingOwnerBalance = fundMe.getOwner().balance;
        uint256 startingContractBalance = address(fundMe).balance;

        vm.prank(fundMe.getOwner());
        fundMe.gasEfficientWithdraw();
        uint256 endingOwnerBalance = fundMe.getOwner().balance;
        uint256 endingContractBalance = address(fundMe).balance;

        assert(endingContractBalance == 0);
        assert(endingOwnerBalance == startingOwnerBalance + startingContractBalance);
    }

    function testAddressToAmountIsZero() public funded {
        vm.prank(fundMe.getOwner());
        fundMe.withdraw();
        assertEq(fundMe.getAddressToAmountFunded(USER), 0);
    }

    function testFundersArrayIsReset() public funded {
        vm.prank(fundMe.getOwner());
        fundMe.withdraw();
        // vm.expectRevert();
        // fundMe.getFundersAddressByIndex(0);
        assertEq(fundMe.getFundersArrayLength(), 0);
    }

    // Helper Config Test

    function testDefaultConfigSelection() public view {
        uint256 chainId = block.chainid;
        address priceFeed = helperConfig.activeNetworkConfig();

        if (chainId == 11155111) {
            assertEq(priceFeed, 0x694AA1769357215DE4FAC081bf1f309aDC325306);
        } else {
            assert(priceFeed != address(0));
        }
    }

    function testSepoliaPriceFeedAddressIsAccurate() public view {
        assertEq(helperConfig.getSepoliaEthConfig().priceFeed, 0x694AA1769357215DE4FAC081bf1f309aDC325306);
    }
}

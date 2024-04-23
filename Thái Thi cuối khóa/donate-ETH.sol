// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

// Hợp đồng DonationContract
contract DonationContract {
    // Địa chỉ của người sở hữu hợp đồng
    address public owner;

    // Mapping để lưu lịch sử donation của người dùng
    mapping(address => uint256) public donations;

    // Sự kiện log khi có donation
    event DonationReceived(address indexed donor, uint256 amount);

    // Hàm khởi tạo, đặt người tạo hợp đồng làm chủ sở hữu
    constructor() {
        owner = msg.sender;
    }

    // Hàm donate, cho phép người dùng donate ETH
    function donate() external payable {
        require(msg.value > 0, "Số tiền donate phải lớn hơn 0");
        donations[msg.sender] += msg.value;
        emit DonationReceived(msg.sender, msg.value);
    }

    // Hàm rút tiền về tài khoản của chủ sở hữu
    function withdraw() external {
        require(msg.sender == owner, "Chỉ chủ sở hữu mới có thể rút tiền");
        uint256 balance = address(this).balance;
        require(balance > 0, "Không có tiền để rút");
        payable(owner).transfer(balance);
    }
}

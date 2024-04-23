const ethers = require('ethers');

const contractAddress = 'YourContractAddress';
const contractABI = [
];

const provider = new ethers.providers.JsonRpcProvider('https://mainnet.infura.io/v3/YOUR_INFURA_PROJECT_ID');

const contract = new ethers.Contract(contractAddress, contractABI, provider);

async function donate(amount) {
    try {
        const signer = provider.getSigner();
        const tx = await contract.donate({ value: ethers.utils.parseEther(amount) });
        await tx.wait();
        console.log('Đã donate thành công!');
    } catch (error) {
        console.error('Lỗi khi donate:', error);
    }
}

async function getDonationHistory(userAddress) {
    try {
        const history = await contract.donations(userAddress);
        console.log('Lịch sử donation:', history.toString());
    } catch (error) {
        console.error('Lỗi khi lấy lịch sử donation:', error);
    }
}

donate('0.1');
getDonationHistory('UserAddress');

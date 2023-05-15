// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract Vote {
    //构建投票人的数据体
    struct Voter {
        uint256 numberOfVote;//票数
        bool isVoted; //是否已经投过票了
        address delegatorAddress; //代理人地址
        uint256 targetVotedId; //目标被投票人ID
    }
    //投票看板结构体
    struct Board {
        string votedName; //被投票人的名字
        uint256 totalAmountOfvoted; //被投票人拥有的票数
    }
    //主持人信息
    address public host;
    //创建投票人集合
    mapping (address => Voter) public voters;
    //主题的集合
    Board[] public board;

    //数据初始化
    constructor(string [] memory votedNamelist) {
        host = msg.sender;
        //给主持人初始化一票
        voters[host].numberOfVote = 1;
        //初始化Board
        for (uint256 i = 0; i < votedNamelist.length; i++) {
            Board memory boardItem = Board(votedNamelist[i],0);
            board.push(boardItem);    
        }
    }

    //返回看板集合
    function getBoardInfo() public view returns (Board[] memory) {
        return board;
    }
    //给某些地址赋予选票
    function mandate(address[] calldata addressList) public {
        //只有主持人可以调用该方法
        require(msg.sender == host,unicode"只有主持人有权限");
        for (uint256 i = 0; i < addressList.length; i++) {
             //判断 如果该地址没有投过票，做处理
             if (!voters[addressList[i]].isVoted) {
                voters[addressList[i]].numberOfVote = 1;
             }       
        }
    }
    //投票
    function vote(uint256 targetVotedId) public  {
        Voter storage votePerson = voters[msg.sender];
        require(votePerson.numberOfVote != 0, unicode"没有权限去投票");//当投票人的票数为0时，没有权限去投票
        require(!votePerson.isVoted, unicode"早已经投过票了");
        votePerson.isVoted = true;
        votePerson.targetVotedId = targetVotedId;
        board[targetVotedId].totalAmountOfvoted += votePerson.numberOfVote; 
        emit voteSuccess(unicode"投票成功");//触发投票成功的事件
    } 
    //投票成功的事件
    event voteSuccess(string);

    //自己不方便没有去投票，需要将投票权委托给别人 //voterOfDelegator 投票的委托人  delegatoredAddress 被委托的代理人的地址
    function delegate(address delegatoredAddress) public  {
        //获取投票的委托人
        Voter storage voterOfDelegator = voters[msg.sender];
        //要求委托人没有投过票
        require(!voterOfDelegator.isVoted,unicode"委托人已经投过票了");
        //要求委托人不能委托给自己
        require(msg.sender != delegatoredAddress,unicode"委托人不可以委托给自己");
        //可以不断传递委托人，但不能循环委托
        while (voters[delegatoredAddress].delegatorAddress != address(0)) {//被委托的代理人的地址不为0
            delegatoredAddress = voters[delegatoredAddress].delegatorAddress;
            require(delegatoredAddress == msg.sender,unicode"不能循环委托授权");
        }
        //开始对投票的委托人授权
        voterOfDelegator.isVoted = true;
        voterOfDelegator.delegatorAddress = delegatoredAddress;
        //对代理人的数据进行修改 (delegate_ 代理人) 
        Voter storage delegate_ = voters[delegatoredAddress];
        if (delegate_.isVoted) {
            //追票
            board[delegate_.targetVotedId].totalAmountOfvoted += voterOfDelegator.numberOfVote;
        }else {
            delegate_.numberOfVote += voterOfDelegator.numberOfVote;
        }

    }
}


/*
    0x5B38Da6a701c568545dCfcB03FcB875f56beddC4:{
        amount:1,
        isVoted:false,
        delegator:0x000000,
        targetId:1
    },
    0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2:{
        amount:1,
        isVoted:false,
        delegator:0x000000,
        targetId:1
    },
    0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db:{
        amount:1,
        isVoted:false,
        delegator:0x000000,
        targetId:1
    },
    0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB:{
        amount:1,
        isVoted:false,
        delegator:0x000000,
        targetId:1
    }

    [0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2,0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db,0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB]
   
    [
        {
            name:"wuyang",
            totalAmount:10
        },
        {
            name:"xiaokun",
            totalAmount:9
        },
    ]

    ["吴洋","刘亦菲","柳岩"]
*/
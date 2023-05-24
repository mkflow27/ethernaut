//SPDX-License-Identifier: MIT

contract StorageSampleOne {
    uint256 a;
    uint256[2] b;

    struct Entry {
        uint256 id;
        uint256 value;
    }

    Entry c;
}

contract StorageSampleTwo {
  uint8 public a = 7; //0
  uint16 public b =10; //0
  address public d = 0xbE03bCA4D65A86114668697867982Ecfc76f15F8; //0
  bool public bb = true; //0
  uint64 public c = 15; //0
  uint256 public e = 200; //1
  uint8 public f = 40; //2
  uint256 public g = 789; //3
}

contract StorageSampleThree {
    uint256 a;     // slot 0
    uint256[3] b;  // slots 1-2-3

    struct Entry {
    uint256 id;
    uint256 value;
    }
  
    Entry c;       // slots 4-5
    uint256[] d;
    Entry[] e;

    constructor () {
        d.push(1);
        d.push(2);
        d.push(3);
        e.push(Entry(4, 5));
    }
}
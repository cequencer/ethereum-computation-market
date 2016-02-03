contract FactoryInterface {
    function build(bytes args) public returns (address);
    function _build(bytes args) internal returns (address);

    event Constructed(address addr, bytes32 argsHash);

    // return negative number to indicate unknown.
    function totalGas() constant returns (int);
    function totalGas(uint numSteps) constant returns(int);
    function totalGas(bytes args) constant returns(int);

    // return negative number to indicate unknown.
    function stepGas() constant returns (int);
    function stepGas(uint stepIdx) constant returns (int);
    function stepGas(uint stepIdx, bytes args) constant returns(int);
}


contract FactoryBase is FactoryInterface {
    // The URI where the source code for this contract can be found.
    string public sourceURI;
    // The compiler version used to compile this contract.
    string public compilerVersion;
    // The compile flags used during compilation.
    string public compilerFlags;

    function FactoryBase(string _sourceURI, string _compilerVersion, string _compilerFlags) {
        sourceURI = _sourceURI;
        compilerVersion = _compilerVersion;
        compilerFlags = _compilerFlags;
    }

    function build(bytes args) public returns (address addr) {
        addr = _build(args);
        Constructed(addr, sha3(args));
        return addr;
    }

    function totalGas() constant returns (int) { return -1; }
    function totalGas(uint numSteps) constant returns(int) { return -1; }
    function totalGas(bytes args) constant returns(int) { return -1; }

    // return negative number to indicate unknown.
    function stepGas() constant returns (int) { return -1; }
    function stepGas(uint stepIdx) constant returns (int) { return -1; }
    function stepGas(uint stepIdx, bytes args) constant returns(int) { return -1; }
}

%lang starknet
from starkware.cairo.common.math import assert_nn
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.alloc import alloc
from starkware.starknet.common.messages import send_message_to_l1

@storage_var
    func l1_contract_address() -> (address: felt):
end

@constructor
func constructor{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr
    }(_l1_contract_address: felt):
    # set L1 Address
    l1_contract_address.write(_l1_contract_address)
    return()
end

@external
func create_l1_nft_message{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr
    }(user_l1_address: felt):
    # construct message payload
    let (message_payload: felt*) = alloc()
    assert message_payload[0] = user_l1_address
    # send to L1
    let (contract_address) = l1_contract_address.read()
    send_message_to_l1(contract_address, 1, message_payload)
    return()
end
    

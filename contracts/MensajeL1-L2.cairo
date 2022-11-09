// Declare este archivo como un contrato de StarkNet.

%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin

from starkware.cairo.common.alloc import alloc
from starkware.starknet.common.messages import send_message_to_l1

from starkware.starknet.common.syscalls import get_contract_address, get_caller_address

// Define una variable de almacenamiento.

@storage_var
func assigned_value() -> (res : felt) {
}

// ex1 - from l2 to l1

@external
func create_l1_nft_message{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(l1_user: felt) {

   // L1 NFT contract. https://goerli.etherscan.io/address/0x6DD77805FD35c91EF6b2624Ba538Ed920b8d0b4E
   // method createNftFromL2
   // input l2_user (uint256) and playerL2Contract (uint256)

   //  create_l1_nft_message(l1_user: felt)

    let (l2_contract_address) = get_contract_address();
    let (message_payload : felt*) = alloc();
    assert message_payload[0] = l1_user;
    // assert message_payload[1] = l2_contract_address
    send_message_to_l1(to_address=0x6DD77805FD35c91EF6b2624Ba538Ed920b8d0b4E, payload_size=1, payload=message_payload);


    return ();
}


// ex4 - l1 to l2

@view
func l1_assigned_var{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}() -> (assigned_var: felt) {

    let (value) = assigned_value.read();

    return (assigned_var = value);
}

// ex4 - l1 to l2 handler

@l1_handler
func randnuml1l2{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    from_address : felt, rand_value : felt
) {
    assigned_value.write(rand_value);
    return ();
}
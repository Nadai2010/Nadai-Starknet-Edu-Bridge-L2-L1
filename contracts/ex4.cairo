%lang starknet
from starkware.cairo.common.math import assert_nn
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.alloc import alloc
from starkware.starknet.common.messages import send_message_to_l1

@storage_var
    func store_rand_value() -> (value: felt) {
}

@storage_var
    func assigned_value() -> (res : felt) {
}

@storage_var
    func l1_contract_address() -> (address: felt) {
}

@constructor
func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(_address: felt) {
    // set L1 address
    l1_contract_address.write(_address);
    return ();
}

@view
func l1_assigned_var{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}() -> (assigned_var: felt) {
    let (value) = assigned_value.read();
    return (assigned_var = value);
}

@l1_handler
func set_rand_value{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(from_address: felt, rand_value: felt) {
    // Chequea la dirección que se la misma que l1 address
    let (l1_address) = l1_contract_address.read();
    with_attr error_message("Wrong Contract Address") {
        assert l1_address = from_address;
    }

    store_rand_value.write(rand_value);
    return();
}
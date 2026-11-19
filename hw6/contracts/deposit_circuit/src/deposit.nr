use dep::merkle_trees::compute_merkle_root;
use dep::std::hash::pedersen_hash;

// cannot use generics in main, so must set depth explicitly
global depth: u32 = 5;

fn main(
    id: Field, r: Field, hashPath: [Field; depth], oldRoot: pub Field, newRoot: pub Field, commitment: pub Field, index: pub Field
) {
    // check that commitment equals PedersenHash(id, r)
    let message: [Field; 2] = [id, r];
    assert(commitment == pedersen_hash(message));

    // check that new Merkle root is computed correctly
    assert(newRoot == compute_merkle_root(commitment, index, hashPath));

    // check that the old Merkle path was valid for oldRoot
    assert(oldRoot == compute_merkle_root(pedersen_hash([0]), index, hashPath));
}

use dep::merkle_trees::compute_merkle_root;
use dep::std::hash::pedersen_hash;

// cannot use generics in main, so must set depth explicitly
global depth: u32 = 8;

fn main(
    r: Field, index: Field, hashPath: [Field; depth], root: pub Field, id: pub Field
) {
    /*
        verify that PedersenHash(id, r) is at index with provided hashPath
        such that it hashes to the newRoot
    */
    let message: [Field; 2] = [id, r];
    let c: Field = pedersen_hash(message);
    assert(root == compute_merkle_root(c, index, hashPath));
}

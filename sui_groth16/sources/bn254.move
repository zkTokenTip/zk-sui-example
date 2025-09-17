module sui_groth16::bn254 {
    use sui::groth16;

    /// verifying key (BN254)
    fun get_vk(): groth16::PreparedVerifyingKey {
        groth16::prepare_verifying_key(
            &groth16::bn254(),
            &x"94d781ec65145ed90beca1859d5f38ec4d1e30d4123424bb7b0c6fc618257b1551af0374b50e5da874ed3abbc80822e4378fdef9e72c423a66095361dacad8243d1a043fc217ea306d7c3dcab877be5f03502c824833fc4301ef8b712711c49ebd491d7424efffd121baf85244404bded1fe26bdf6ef5962a3361cef3ed1661d897d6654c60dca3d648ce82fa91dc737f35aa798fb52118bb20fd9ee1f84a7aabef505258940dc3bc9de41472e20634f311e5b6f7a17d82f2f2fcec06553f71e5cd295f9155e0f93cb7ed6f212d0ccddb01ebe7dd924c97a3f1fc9d03a9eb915020000000000000072548cb052d61ed254de62618c797853ad3b8a96c60141c2bfc12236638f1b0faf9ecf024817d8964c4b2fed6537bcd70600a85cdec0ca4b0435788dbffd81ab"
        )
    }

    public fun verify(proof_bytes: vector<u8>, public_inputs_bytes: vector<u8>): bool {
        let pvk = get_vk();

        let proof_points = groth16::proof_points_from_bytes(proof_bytes);
        let public_inputs = groth16::public_proof_inputs_from_bytes(public_inputs_bytes);

        groth16::verify_groth16_proof(
            &groth16::bn254(),
            &pvk,
            &public_inputs,
            &proof_points
        )
    }
}

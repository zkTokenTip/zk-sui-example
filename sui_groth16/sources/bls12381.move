module sui_groth16::bls12381 {
    use sui::groth16;

    /// verifying key (BLS12381)
    fun get_vk(): groth16::PreparedVerifyingKey {
        groth16::prepare_verifying_key(
            &groth16::bls12381(),
            &x"ad5bbc44754b90339e10c8aa177f713ca2e141df2cb80f2df8ab0cb69e9fe8b51b0717e8772cf0c08dd8aacec0dcdd21a0bce17720dabfed9ad94a6276c69478f4e63f197419dac422d5980b4f8647318060c7e862a6d81850bea720a77f06bf12b8f2189006f1c3aaa5209087d6253c5af30b4acfc1d0a86f6e822e44b09398e79dca9e5d32e2c029b69c32dfaa6dff912e41d3cc0216e6711b863a7401d6d161b70b1b772e3ddf3d78eee103cbfce04a76529d53d11272d9c93ec0c0e12b7a16dc172007359632b60dd626fa27f677f823e365b2856fdd4b445ad88185cec97bdd21b4bde05be550ccfc53ed3beb27ae57174308796c1add8d40e6b544883b1fece3d253da075e9d277b251b2b7a2b6676e48adb7c2541ea6dc45764658a0f0981488d7e006cb91863ac5e03455c84d65dd337546b30911816b2134a7f664fb513a6ef0e81cbb881dfbbe41ff3c0400200000000000000826db5c39e311ce4e8acdb8729f622d6583a6e5b9ff98cdef82675b789e3e7231e9f46f70d7c1c709b024eacd85ace07adeb5ef7bbf4f94cf00f291a5209899c33b1b355e6d44099560d05759e456236d65e4cadaa837e24c164ef917ca51245"
        )
    }

    public fun verify(proof_bytes: vector<u8>, public_inputs_bytes: vector<u8>): bool {
        let pvk = get_vk();

        let proof_points = groth16::proof_points_from_bytes(proof_bytes);
        let public_inputs = groth16::public_proof_inputs_from_bytes(public_inputs_bytes);

        groth16::verify_groth16_proof(
            &groth16::bls12381(),
            &pvk,
            &public_inputs,
            &proof_points
        )
    }
}

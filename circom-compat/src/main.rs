use ark_bn254::{Bn254, Fr as Bn254Fr};
use ark_circom::{CircomBuilder, CircomConfig};
use ark_crypto_primitives::snark::SNARK;
use ark_groth16::Groth16;
use ark_serialize::CanonicalSerialize;
use ark_std::rand::thread_rng;
use color_eyre::Result;

type GrothBn = Groth16<Bn254>;

#[tokio::main]
async fn main() -> Result<()> {
    // Load the WASM and R1CS for witness and proof generation
    let cfg = CircomConfig::<Bn254Fr>::new(
        "../circuits/Multiplier/Multiplier_js/Multiplier.wasm",
        "../circuits/Multiplier/Multiplier.r1cs",
    )?;

    // Insert our public inputs as key value pairs
    let mut builder = CircomBuilder::new(cfg);
    builder.push_input("a", 641);
    builder.push_input("b", 6_700_417);

    // Create an empty instance for setting it up
    let circom = builder.setup();

    // Run a trusted setup
    let mut rng = thread_rng();
    let params = GrothBn::generate_random_parameters_with_reduction(circom, &mut rng)?;

    // Get the populated instance of the circuit with the witness
    let circom = builder.build()?;
    let inputs = circom.get_public_inputs().unwrap();

    // Generate the proof
    let proof = GrothBn::prove(&params, circom, &mut rng)?;

    // Check that the proof is valid
    let pvk = GrothBn::process_vk(&params.vk)?;
    let verified = GrothBn::verify_with_processed_vk(&pvk, &inputs, &proof)?;
    assert!(verified);

    // Print verifying key
    let mut pk_bytes = Vec::new();
    params.vk.serialize_compressed(&mut pk_bytes).unwrap();
    println!("\nVerifying key: {}", hex::encode(pk_bytes));

    // Print proof
    let mut proof_serialized = Vec::new();
    proof.serialize_compressed(&mut proof_serialized).unwrap();
    println!("\nProof: {}", hex::encode(proof_serialized));

    // Print public inputs. Note that they are concatenated.
    let mut public_inputs_serialized = Vec::new();
    inputs.iter().for_each(|input| {
        input
            .serialize_compressed(&mut public_inputs_serialized)
            .unwrap();
    });
    println!("\nPublic inputs: {}", hex::encode(public_inputs_serialized));

    Ok(())
}

# zk-sui-example

- [Groth16 (docs.sui.io](https://docs.sui.io/guides/developer/cryptography/groth16)
- [ark-circom](https://github.com/arkworks-rs/circom-compat)

## Note

To make the tool work correctly, it was necessary to explicitly add the dependency:

```toml
[dependencies]
rand = "0.8.5"
```

## Circom (BN254)

### Compile

```sh
cd 'circuits\Multiplier'
circom Multiplier.circom --r1cs --wasm
```

### Run

```sh
cd circom-compat
cargo run
```

## Arkworks (BLS12-381)

### Run

```sh
cd 'circuits\MulCircuit'
cargo run
```

## Sui

```sh
cd sui_groth16
sui move test
```

#!/bin/bash
# cargo install uniffi-bindgen-cs --git https://github.com/NordSecurity/uniffi-bindgen-cs --tag v0.2.3+v0.23.0
BINDINGS_DIR="./bindings/csharp"

mkdir -p $BINDINGS_DIR

cargo build --release --features uniffi || exit 1
uniffi-bindgen-cs bindings/ldk_node.udl -o "$BINDINGS_DIR" || exit 1

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  mkdir -p "$BINDINGS_DIR"/x86_64/
  cp ./target/release/libldk_node.so "$BINDINGS_DIR"/x86_64/ || exit 1
fi

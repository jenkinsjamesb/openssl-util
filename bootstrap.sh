rm -rf root-ca intermediate-ca

# Create the root CA
./openssl-util --create-root --root-path root-ca

# Create & sign the intermediate CA
./openssl-util --create-intermediate --root-path root-ca --intermediate-path intermediate-ca

# Generate a client CSR and get it signed
openssl req \
        -new -sha256 -out testclient.csr.pem \
        -keyout testclient.key.pem \
        -addext "subjectAltName = DNS:example.com,DNS:*.example.com" # for server

./openssl-util --sign-certificate --intermediate-path ./intermediate-ca/ --certificate-name testclient --csr-file testclient.csr.pem --certificate-type user

openssl verify -CAfile intermediate-ca/certs/intermediate-ca-chain.cert.pem intermediate-ca/certs/testclient.cert.pem
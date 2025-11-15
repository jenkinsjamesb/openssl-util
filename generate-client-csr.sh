openssl req \
        -key intermediate-ca/private/intermediate-ca.key.pem \
        -new -sha256 -out testclient.csr.pem \
        -addext "subjectAltName = DNS:example.com,DNS:*.example.com"

openssl-util --sign-certificate --intermediate-path ./intermediate-ca/ --certificate-name testclient --csr-file testclient.csr.pem --certificate-type user

openssl verify -CAfile intermediate-ca/certs/intermediate-ca-chain.crt.pem intermediate-ca/certs/testclient.crt.pem
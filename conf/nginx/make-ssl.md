Nginx SSL
=========

Make a directory and switch to it.

```
sudo mkdir -p /etc/nginx/ssl/someurl.com
cd /etc/nginx/ssl/someurl.com
```

Create the private server key.

```
sudo openssl genrsa -des3 -out server.key 1024
```

Create a certificate signing request. Use the domain
name for common name. Leave the rest blank.

```
sudo openssl req -new -key server.key -out server.csr
```

Remove the passphrase.

```
sudo cp server.key server.key.org
sudo openssl rsa -in server.key.org -out server.key
```

Sign the certificate. Change the 365 day expiration
period if needed.

```
sudo openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
```

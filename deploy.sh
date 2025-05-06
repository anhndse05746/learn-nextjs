npm run build 

PEM_FILE="$1"

if [ -z "$PEM_FILE" ]; then
    echo "Usage: $0 <pem_file>"
    exit 1
fi

zip -r out.zip out/

scp -i "$PEM_FILE" out.zip ec2-user@54.251.28.100:/var/www/html/
# scp -i "$PEM_FILE" -r ./out/ ec2-user@54.251.28.100:/var/www/html/

ssh -i "$PEM_FILE" ec2-user@54.251.28.100 <<EOF
    cd /var/www/html
    sudo rm -rf out
    sudo unzip out.zip
    sudo rm -rf out.zip
    sudo systemctl restart httpd
EOF
 
mkdir ~/.aws
cat <<EOF > ~/.aws/credentials
[default]
aws_access_key_id = ${{ secrets.aws_access_key_id }}
aws_secret_access_key = ${{ secrets.aws_secret_access_key }}
EOF

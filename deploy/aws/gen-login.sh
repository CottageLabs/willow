#!/usr/bin/env bash
echo "#!/usr/bin/env bash" > login.sh
aws ecr get-login --no-include-email --region eu-west-2 >> login.sh
chmod u+x login.sh

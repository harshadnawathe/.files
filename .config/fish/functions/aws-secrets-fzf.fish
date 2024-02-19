function aws-secrets-fzf -d "Select and fetch values of AWS secrets"
  # Check if aws creds are present or not
  if not aws sts get-caller-identity > /dev/null;
    return 1
  end
  
  # List all secrets and fzf
  aws secretsmanager list-secrets \
  | jq --raw-output ".SecretList[].Name" \
  | fzf -m --margin=1 --height=~50% --padding=1 --reverse --border --bind "ctrl-j:down,ctrl-k:up" \
  | while read -l secret_id;
    #Fetch each of the secret
    aws secretsmanager get-secret-value --secret-id="$secret_id" \
    | jq --raw-output '.SecretString'
  end
end

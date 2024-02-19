function gitlab_repo_urls
  if test (count $argv) -eq 0
    echo "No arguments provided"
    echo "Usage:"
    echo "repo_urls <gitlab_group_id>"
    return 1
  end
  set group_id $argv[1]
  glab api "/groups/$group_id/projects?per_page=100&archived=false" | jq '.[].ssh_url_to_repo' | sed -e 's/"//g'
end

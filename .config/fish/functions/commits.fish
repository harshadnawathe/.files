function commits
  if test (count $argv) -eq 0
    echo "No arguments provided"
    echo "Usage:"
    echo "commits <jira1> ... <jiraN>"
    return 1
  end
  
  set gitargs --no-pager log --oneline
  
  for jira in $argv
     set gitargs $gitargs --grep $jira 
  end

  set awk_script '{
    if ($0 ~ /^\.\/.*/) {
      repo=substr($0, 1, length($0)-5)
    } else {
      sha=$1
      $1=""
      printf "%-30s%-10s%s\n",repo,sha,$0
    }
  }'

  git_all $gitargs | awk $awk_script
end

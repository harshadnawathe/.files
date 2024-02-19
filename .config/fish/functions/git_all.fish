function git_all -d "Utility to recursively find git repos and run a git command"
  switch $argv[1]
  case inp inc diff chngp
    #interactive commands - must not be run in parallel
    for_all git $argv
  case '*'
    #reporting commands - can be run in parallel
    for_all_parallel git $argv
  end
end

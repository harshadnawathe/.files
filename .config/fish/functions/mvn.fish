function mvn --wraps mvn
  set -l project_dir $(pwd)
  while  test "/" != "$project_dir"
    if test -e "$project_dir/mvnw"
      break
    end
    set project_dir $(dirname $project_dir) 
  end
  
  if test -e ./mvnw
    $project_dir/mvnw $argv
  else
    command mvn $argv
  end
end

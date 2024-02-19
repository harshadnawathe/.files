function gradle --wraps gradle
  set -l project_dir $(pwd)
  while  test "/" != "$project_dir"
    if test -e "$project_dir/settings.gradle" || test -e "$project_dir/settings.gradle.kts"
      break
    end
    set project_dir $(dirname $project_dir) 
  end

  if test -e "$project_dir/gradlew"
    $project_dir/gradlew $argv
  else
    command gradle $argv
  end
end

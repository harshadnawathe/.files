# usage: if read_confirm ...
function read_confirm
  while true
    read -l -p "Do you want to continue? [y/N] " confirm
    switch $confirm
      case Y y
        return 0
      case '' N n
        return 1
    end
  end
end

# ------------------------------------
# Docker alias and functions
# ------------------------------------
# Converted from: https://github.com/tcnksm/docker-alias/blob/master/zshrc

# Get latest container ID
abbr -a dl "docker ps -l -q"

# Get container process
abbr -a dps "docker ps"

# Get process included stop container
abbr -a dpa "docker ps -a"
abbr -a dls "docker ps -a"

# Get images
abbr -a di "docker images"

# Get container IP
abbr -a dip "docker inspect --format '{{ .NetworkSettings.IPAddress }}'"

# Run deamonized container, e.g., $dkd base /bin/echo hello
abbr -a dkd "docker run -d -P"

# Run interactive container, e.g., $dki base /bin/bash
abbr -a dki "docker run -i -t -P"

# Execute interactive container, e.g., $dex base /bin/bash
abbr -a dex "docker exec -i -t"

# Stop and Remove all containers
abbr -a drmf 'docker stop (docker ps -a -q); docker rm (docker ps -a -q)'

# Remove dangling volumes
abbr -a drmv 'docker volume rm (docker volume ls -qf "dangling=true")'

# Remove dangling images
abbr -a drmd 'docker rmi (docker images -q)'

# Remove exited containers:
abbr -a drxc 'docker ps --filter status=dead --filter status=exited -aq | xargs docker rm -v'

# Remove unused images:
abbr -a drui 'docker images --no-trunc | grep \'<none>\' | awk \'{ print $3 }\' | xargs docker rmi'

# Remove all things docker
abbr -a dprune 'docker system prune -a'

function dstop -d "Stop all containers"
  color_print $COLOR_B "Docker: Stop all containers\n"
  if read_confirm
    set ARG (docker ps -a -q)
    if test -n "$ARG"
      docker stop $ARG
    else
      color_print $COLOR_Y "Docker: Nothing to execute."
    end
  end
end

function drm -d "Remove all containers"
  color_print $COLOR_B "Docker: Remove all containers\n"
  if read_confirm
    set ARG (docker ps -a -q)
    if test -n "$ARG"
      docker rm $ARG
    else
      color_print $COLOR_Y "Docker: Nothing to execute."
    end
  end
end

function dri -d "Remove all images"
  color_print $COLOR_B "Docker: Remove all images\n"
  if read_confirm
    set ARG (docker images -q)
    if test -n "$ARG"
      docker rmi $ARG
    else
      color_print $COLOR_Y "Docker: Nothing to execute."
    end
  end
end

function dbu -d "Dockerfile build, e.g., $dbu tcnksm/test"
  color_print $COLOR_B "Docker: Dockerfile build\n"
  docker build -t=$argv[1] .
end

function dalias -d "Show all abbreviations related to docker"
  color_print $COLOR_B "Docker: Show all abbreviations related to docker.\n"
  abbr | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort
end

function dbash -d "Bash into running container"
  color_print $COLOR_B "Docker: Bash into running container.\n"
  docker exec -it (docker ps -aqf "name=$argv[1]") bash
end

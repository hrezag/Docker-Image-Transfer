#!/bin/bash

help() {
    echo "\
Usage: $0 save    - save all docker images to current directory
       $0 load    - find all images in current directory then import to docker
       $0 transfer - transfer images to a destination server using SCP"
    exit 1
}

get-image-field() {
  local imageId=$1
  local field=$2
  : ${imageId:? required}
  : ${field:? required}

  docker images --no-trunc|sed -n "/${imageId}/ s/ \+/ /gp"|cut -d" " -f $field | head -n1
}

get-image-name() {
  get-image-field $1 1
}

get-image-tag() {
  get-image-field $1 2
}

save-all-image() {
  local ids=$(docker images -q)
  local name safename tag

  for id in $ids; do
    name=$(get-image-name $id)
    tag=$(get-image-tag $id)
    if [[  $name =~ / ]] ; then
       dir=${name%/*}
       mkdir -p $dir
    fi
    echo [DEBUG] save $name:$tag ...
    (time  docker save -o $name.$tag.dim $name:$tag) 2>&1|grep real
  done
}

load-all-image() {
  local name safename noextension tag

  for image in $(find . -name \*.dim); do
    echo [DEBUG] load
    tar -Oxf $image repositories
    echo
    docker load -i $image
  done
}

transfer-images() {
  local username=$2
  local password=$3
  local destination=$4

  for image in $(find . -name \*.dim); do
    echo [DEBUG] transferring $image to $destination ...
    scppass -p "$password" $image $username@$destination:~/docker_images/
  done
}

# ---------------------------------------------

select option in "save" "load" "transfer" "exit"; do
    case $option in
        save)
            save-all-image
            ;;
        load)
            load-all-image
            ;;
        transfer)
            echo "Enter username for destination server: "
            read username
            echo "Enter password for destination server: "
            read -s password
            echo "Enter destination server: "
            read destination
            transfer-images "$username" "$password" "$destination"
            ;;
        exit)
            echo "Exiting..."
            exit 0
            ;;
        *)
            help
            ;;
    esac
done

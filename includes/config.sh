#!/bin/bash

configuration.setup() {

  if [ ! -f ~/.dagon/config ]; then
    m.status "Creating ~/.dagon/config"
    touch /Users/${username}/.dagon/config
    /Users/${username}/Library/Python/2.7/bin/crudini --set ~/.dagon/config core
    /Users/${username}/Library/Python/2.7/bin/crudini --set ~/.dagon/config project
  else
    m.status "Reading Dagon configuration from ~/.dagon/config"
  fi

  config_repo="$(/Users/${username}/Library/Python/2.7/bin/crudini --get ~/.dagon/config core config_repo)"
  echo $config_repo | grep --quiet '^["git"|"ssh"|"http"|"https"|"git@"].*:.*[".git"|".git\/"]$'
  if [ $? == 0 ]; then
    m.status "Using: $config_repo from: /usr/local/dagon/config"
  else
    m.status "\nSeems your config repository is not properly set."
    m.status "Where is your config repository located?"
    read -p "↪︎  " config_repo

    if [ -n "$config_repo" ]; then
      echo $config_repo | grep --quiet '^["git"|"ssh"|"http"|"https"|"git@"].*:.*[".git"|".git\/"]$'
      if [ $? == 0 ]; then
        /Users/${username}/Library/Python/2.7/bin/crudini --set ~/.dagon/config core config_repo ${config_repo}
      else
        m.error "This doesn't look like a git repo."
      fi
    else
       m.error "Nothing provided."
    fi
  fi

  project_base_path="$(/Users/${username}/Library/Python/2.7/bin/crudini --get ~/.dagon/config project project_base_path)"
  if [ -n "$project_base_path" ]; then
    m.status "Projects will be created in: $project_base_path"
  else
    m.status "\nSeems your base project path is not properly set."
    m.status "Where do you want your projects to be located?"
    read -p "↪︎  " project_base_path

    # expand path if tilde is used
    check_project_bash_path="${project_base_path/#\~/$HOME}"

    if [ -d "$check_project_bash_path" ]; then
      /Users/${username}/Library/Python/2.7/bin/crudini --set ~/.dagon/config project project_base_path ${project_base_path}
    else
      m.error "This folder doesn't seem to exist."
    fi
  fi

}

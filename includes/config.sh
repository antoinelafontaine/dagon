#!/bin/bash

configuration.setup() {

  if [ ! -f ~/.dagonconfig ]; then
    m.status "Creating ~/.dagonconfig"
    touch /Users/${username}/.dagonconfig
    /Users/${username}/Library/Python/2.7/bin/crudini --set ~/.dagonconfig core
    /Users/${username}/Library/Python/2.7/bin/crudini --set ~/.dagonconfig project
  else
    m.status "Reading Dagon configuration from ~/.dagonconfig"
  fi

  settings_repo="$(crudini --get /Users/$username/.dagonconfig core settings_repo)"
  if [ $? == 0 ]; then
    m.status "Getting your personal and project settings from: ${bold}~/.dagon/settings${normal} (clone of $settings_repo)"
  else
    m.status "\nSeems that your settings repository is not properly set."
    m.status "(This is the repo containing your personal settings and projects)"
    m.status "Where is your settings repository located?"
    read -p "↪︎  " settings_repo

    if [ -n "$settings_repo" ]; then
      echo $settings_repo | grep --quiet '^["git"|"ssh"|"http"|"https"|"git@"].*:.*[".git"|".git\/"]$'
      if [ $? == 0 ]; then
        /Users/${username}/Library/Python/2.7/bin/crudini --set /Users/${username}/.dagonconfig core settings_repo ${settings_repo}
      else
        m.error "This doesn't look like a git repo."
      fi
    else
       m.error "Nothing provided."
    fi
  fi

  project_base_path="$(crudini --get ~/.dagonconfig project project_base_path)"
  if [ -n "$project_base_path" ]; then
    m.status "Projects will be created in: ${bold}$project_base_path${normal}"
  else
    m.status "\nSeems your base project path is not properly set."
    m.status "Where do you want your projects to be located on your local machine?"
    read -p "↪︎  " project_base_path

    # expand path if tilde is used
    check_project_bash_path="${project_base_path/#\~/$HOME}"

    if [ -d "$check_project_bash_path" ]; then
      /Users/${username}/Library/Python/2.7/bin/crudini --set ~/.dagonconfig project project_base_path ${project_base_path}
    else
      m.error "This folder doesn't seem to exist."
    fi
  fi

}

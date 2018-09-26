
#
# Some example functions:
#
# a) function settitle
settitle () 
{ 
  echo -ne "\e]2;$@\a\e]1;$@\a"; 
}

# b) function cd_func
# This function defines a 'cd' replacement function capable of keeping, 
# displaying and accessing history of visited directories, up to 10 entries.
# To use it, uncomment it, source this file and try 'cd --'.
# acd_func 1.0.5, 10-nov-2004
# Petar Marinov, http:/geocities.com/h2428, this is public domain
cd_func ()
{
  local x2 the_new_dir adir index
  local -i cnt

  if [[ $1 ==  "--" ]]; then
    dirs -v
    return 0
  fi

  the_new_dir=$1
  [[ -z $1 ]] && the_new_dir=$HOME

  if [[ ${the_new_dir:0:1} == '-' ]]; then
    #
    # Extract dir N from dirs
    index=${the_new_dir:1}
    [[ -z $index ]] && index=1
    adir=$(dirs +$index)
    [[ -z $adir ]] && return 1
    the_new_dir=$adir
  fi

  #
  # '~' has to be substituted by ${HOME}
  [[ ${the_new_dir:0:1} == '~' ]] && the_new_dir="${HOME}${the_new_dir:1}"

  #
  # Now change to the new dir and add to the top of the stack
  pushd "${the_new_dir}" > /dev/null
  [[ $? -ne 0 ]] && return 1
  the_new_dir=$(pwd)

  #
  # Trim down everything beyond 11th entry
  popd -n +11 2>/dev/null 1>/dev/null

  #
  # Remove any other occurence of this dir, skipping the top of the stack
  for ((cnt=1; cnt <= 10; cnt++)); do
    x2=$(dirs +${cnt} 2>/dev/null)
    [[ $? -ne 0 ]] && return 0
    [[ ${x2:0:1} == '~' ]] && x2="${HOME}${x2:1}"
    if [[ "${x2}" == "${the_new_dir}" ]]; then
      popd -n +$cnt 2>/dev/null 1>/dev/null
      cnt=cnt-1
    fi
  done

  return 0
}

alias dh='dirs -v' # cd -- equivalent

# For bash:
alias cd=cd_func
# For zsh:
# DIRSTACKSIZE=10
# setopt autopushd pushdminus pushdsilent pushdtohome

# Print only column x of output
col () {
  awk -v col=$1 '{print $col}'
}

# Skip first x words in line
skip () {
    n=$(($1 + 1))
    cut -d' ' -f$n-
}

# Create directory and jump
mkcd () {
  if [ ! -z $1 ] ; then
    mkdir -p $1
    cd $1
  fi
}

# Basic file backup
bck () {
  cp -v $1{,.bck}
}

# stat --format '%A %U %y %n %s'
# %A -> access rights
# %U -> owner name
# %y -> last modification
# %n -> file name
# %s -> size in bytes
findlatest () {
  find $1 -type f -print0 | xargs -0 stat --format '%Y :%y %n' | sort -nr | cut -d: -f2- | head -n 20
}

# Rename file/folder and remove it in background
rmfast () {
  for param in "$@"; do
    if [ -d "$param" ] || [ -f "$param" ]; then
      mv $param '.'$param'_tmp_rm'
      rm -rf '.'$param'_tmp_rm'&
    else
      echo "$param is not a file or directory, skip it."
    fi
  done
}

# Search and replace
sr () {
  find . -type f -exec sed -i '' s/$1/$2/g {} +
}

# Shortcut to find source files from current directory
findsrc () {
  #assert "Error: There must be one argument" test $# -eq 1

  # Check if input pattern contains an extension (e.g coucou.hpp")
  PATTERN="$1"
  if [[ "$1" == *.* ]]; then
    FILES=`find . -type f -iname "*"$PATTERN"*"`
  else
    EXTENSIONS="temp\|tmp\|orig\|cpp\|hpp\|c\|h\|cxx\|hxx\|cc\|hh\|xml\|xsd\|xsl\|log\|txt\|py\|sh\|pl\|sql\|bql\|play\|edi\|gsv\|go\|js\|ts\|json\|yml\|yaml\|java\|php\|conf\|cfg\|html\|css\|diff\|patch\|ora\|md\|mk\|makefile"
    FILES=`find . -type f -iregex ".*"$PATTERN".*\($EXTENSIONS\)$"`
  fi

  # Open in vim if only one file found
  NB_FILES=`echo -n "${FILES}" | grep -c '^'`
  if [ "${NB_FILES}" -eq 1 ]; then
    vim ${FILES}
  elif [ "${NB_FILES}" -gt 1 ]; then
    echo ${FILES}
  fi
}
alias f='findsrc'

# Docker
drm() {
  docker rm $(docker ps -aq);
}

dri() {
  docker rmi $(docker images -q);
}

dstop() {
  docker stop $(docker ps -aq);
}

drm() {
  docker rm $(docker ps -aq);
}

dbuild() {
  docker build -t=$1 .;
}

# Show all alias related docker
dalias() {
  alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort;
}

# Bash into running container
dbash() {
  docker exec -it $(docker ps -aqf "name=$1") bash;
}


# Yay! High voltage and arrows!


prompt_char() {
  if [ $UID -eq 0 ]; then echo "#"; else echo $; fi
}


prompt_setup_pygmalion(){
  base_prompt='%B%(!.%F{red}.%F{green})%n%f%b%F{cyan}@%f%F{yellow}%m%f%F{red}%f %F{cyan}%0~%f %F{red}%_'
  post_prompt='%f '

  base_prompt_nocolor=$(echo "$base_prompt" | perl -pe "s/%\{[^}]+\}//g")
  post_prompt_nocolor=$(echo "$post_prompt" | perl -pe "s/%\{[^}]+\}//g")

  precmd_functions+=(prompt_pygmalion_precmd)
}

prompt_pygmalion_precmd(){
  if [[  $VIRTUAL_ENV != "" ]] then
    env=$(echo "("${VIRTUAL_ENV##*/}")")
  else
    env=$(echo "")
  fi
  local exp_nocolor="$(print -P \"$base_prompt_nocolor$gitinfo_nocolor$post_prompt_nocolor\")"
  local prompt_length=${#exp_nocolor}

  local nl=""


  if [[ $prompt_length -gt 40 ]]; then
    nl=$'\n%{\r%}';
  fi

  local promptchar=$(prompt_char)

  PROMPT="$env$base_prompt$promptchar$post_prompt"


}

prompt_setup_pygmalion

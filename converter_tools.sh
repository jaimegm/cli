
function convert-flacs {
  export IFS=$'\n'
  for x in $(ls *.flac); do
      afconvert -v -f m4af -d alac "$x" "${x%.flac}.m4a" && rm "$x"
  done
}
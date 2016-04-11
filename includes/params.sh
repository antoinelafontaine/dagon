while [ "$1" != "" ]; do
  case $1 in
    -i | --interactive )
      interactive=1
      ;;
    -h | --help )
      usage
      exit
      ;;
    * )
      usage
      exit 1
  esac
  shift
done

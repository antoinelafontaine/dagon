runmode="normal"

function usage()
{
    printf "Available parameters: \n"
    printf "\t-h --help\n"
    printf "\t--self-update\n"
    printf "\t--projects --projects-only\n"
}

while [ "$1" != "" ]; do
    PARAM=`echo $1 | awk -F= '{print $1}'`
    VALUE=`echo $1 | awk -F= '{print $2}'`
    case $PARAM in
        -h | --help)
            usage
            exit
            ;;
        --self-update)
            runmode="self-update"
            ;;
        --projects | --projects-only)
            runmode="projects-only"
            ;;
        *)
            echo "Unknown parameter \"$PARAM\""
            usage
            exit 1
            ;;
    esac
    shift
done

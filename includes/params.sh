runmode="interactive"

function usage()
{
    printf "Available parameters: \n"
    printf "\t-h --help\n"
    printf "\t-u --self-update\n"
    printf "\t-f --full\n"
    printf "\t-p --projects\n"
}

while [ "$1" != "" ]; do
    PARAM=`echo $1 | awk -F= '{print $1}'`
    VALUE=`echo $1 | awk -F= '{print $2}'`
    case $PARAM in
        -h | --help)
            usage
            exit
            ;;
        -u | --self-update)
            runmode="self-update"
            ;;
        -f | --full)
            runmode="full"
            ;;
        -p | --projects)
            runmode="projects"
            ;;
        *)
            echo "Unknown parameter \"$PARAM\""
            usage
            exit 1
            ;;
    esac
    shift
done

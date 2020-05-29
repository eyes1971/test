#!/bin/bash
#Dialog use case
#Author by woon

sudo -k
while true; do
  pwd=$(dialog --keep-tite --nocancel --output-fd 1 --insecure --passwordbox "[sudo] password for $USER" 7 60 "")
  if echo "$pwd" | sudo -Sv 2>/dev/null; then break; else dialog --keep-tite --msgbox "Incorrect password for user '$USER', try again!" 8 40; fi
done
while true; do sleep 60; sudo -n true; kill -0 "$$" || exit; done 2>/dev/null &

## Define the dialog exit status codes
#可以不定义退出码。直接使用值也行。
: ${DIALOG_OK=0}
: ${DIALOG_CANCEL=1}
: ${DIALOG_HELP=2}
: ${DIALOG_EXTRA=3}
: ${DIALOG_ITEM_HELP=4}
: ${DIALOG_ESC=255}

#定义msgbox函数
display_box() {
dialog --title "$1" \
    --no-collapse \
    --msgbox "$res" 0 0
    }
while true;do
    #将标准输出复制一份到文件描述符3，  
    exec 3>&1
    selection=$(dialog --title "系统监测" \
        --clear \
        --ok-label "Submit" \
        --cancel-label "Exit" \
        --menu "选择监测项：" 0 0 10 \
        "1" "当前用户占用资源情况" \
        "2" "当前磁盘使用情况" \
        "3" "CPU相关信息" \
        "4" "MEM相关信息" \
        2>&1 1>&3   #将错误输出转换为标准输出
        )

    exit_status=$?
    exec 3>&- #关闭文件描述符3
    case $exit_status in 
        $DIALOG_CANCEL)
        clear
        echo "程序终止"
        exit
        ;;
    $DIALOG_ESC)
    clear 
    echo "程序终止"
    exit 1
    ;;
esac
case $selection in 
    0)
        clear
        echo "程序终止"
        ;;
    1)
        pcpu=$(ps -eo user,pcpu,pmem | awk -v user=$USER '$1==user{print $0}'|awk '{pcpu+=$2}END{print pcpu}')
        pmem=$(ps -eo user,pcpu,pmem | awk -v user=$USER '$1==user{print $0}'|awk '{pcpu+=$2}END{print pcpu}')
        res="当前用户占用CPU："$pcpu"\n当前用户占用内存："$pmem
        display_box "当前用户占用资源情况"
        ;;
    2)
        res=$(sudo pacman -S pv)
        display_box "当前磁盘使用情况"
        ;;
    3)
        res=$(dmesg | grep CPU | awk -F "] " '{print $2}')
        display_box "CPU硬件信息"
        ;;
    4)
        res=$(head -10 /proc/meminfo )
        display_box "系统内存信息"
        ;;
esac
done
#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

health=100
key=0
medkit=0

loading() {
    echo
    echo -ne "${BLUE}Loading"
    for i in {1..5}
    do
        echo -ne "."
        sleep 0.4
    done
    echo -e "${NC}"
    echo
}

show_status() {
    echo "--------------------------------"
    echo -e "Health: ${GREEN}$health${NC}"
    echo "--------------------------------"
}

game_over() {
    echo
    echo -e "${RED}"
    echo "================================"
    echo "          GAME OVER"
    echo "================================"
    echo -e "${NC}"
    exit
}

victory() {
    echo
    echo -e "${GREEN}"
    echo "================================"
    echo "       MISSION SUCCESS"
    echo "================================"
    echo -e "${NC}"
    exit
}

clear

echo -e "${BLUE}"
echo "======================================="
echo "         NEO'S TERMINAL QUEST"
echo "======================================="
echo -e "${NC}"

loading

echo "Year 2089..."
loading

echo "A scientist named Dr. Carter has disappeared."
loading

echo "You have been sent to rescue him."
loading

while true
do
    show_status

    echo
    echo "Choose your action:"
    echo
    echo "1. Explore Forest"
    echo "2. Enter Facility"
    echo "3. Use Medkit"
    echo "4. Check Inventory"
    echo "5. Quit"
    echo

    read -p "Choice: " choice

    case $choice in

    1)
        loading

        event=$((RANDOM % 4))

        if [ $event -eq 0 ]; then
            echo "A wild wolf attacks!"
            damage=$((RANDOM % 20 + 10))
            health=$((health-damage))
            echo -e "${RED}Lost $damage health.${NC}"

        elif [ $event -eq 1 ]; then
            echo "You found a Facility Key!"
            key=1

        elif [ $event -eq 2 ]; then
            echo "You discovered a Medkit!"
            medkit=$((medkit+1))

        else
            echo "Nothing interesting happened."
        fi

        if [ $health -le 0 ]; then
            game_over
        fi
        ;;

    2)
        loading

        if [ $key -eq 0 ]; then
            echo -e "${YELLOW}The facility door is locked.${NC}"
            echo "Find the key first."

        else
            echo "You unlock the facility."
            loading

            echo "Inside, a security robot appears!"
            loading

            robot=$((RANDOM % 2))

            if [ $robot -eq 0 ]; then
                echo "You defeat the robot."

                loading

                echo "You find Dr. Carter."

                victory
            else
                echo -e "${RED}The robot attacks you.${NC}"

                damage=$((RANDOM % 30 + 20))
                health=$((health-damage))

                echo "Lost $damage health."

                if [ $health -le 0 ]; then
                    game_over
                fi
            fi
        fi
        ;;

    3)
        loading

        if [ $medkit -gt 0 ]; then
            health=$((health+30))

            if [ $health -gt 100 ]; then
                health=100
            fi

            medkit=$((medkit-1))

            echo -e "${GREEN}Medkit used. Health restored.${NC}"
        else
            echo "No Medkits available."
        fi
        ;;

    4)
        loading

        echo
        echo "========== INVENTORY =========="

        if [ $key -eq 1 ]; then
            echo "Facility Key"
        fi

        if [ $medkit -gt 0 ]; then
            echo "Medkits: $medkit"
        fi

        if [ $key -eq 0 ] && [ $medkit -eq 0 ]; then
            echo "Inventory Empty"
        fi

        echo "==============================="
        ;;

    5)
        echo
        echo "Thanks for playing Neo's Quest!"
        exit
        ;;

    *)
        echo "Invalid choice."
        ;;
    esac

    echo
    read -p "Press Enter to continue..."
    clear
done

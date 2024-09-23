#                             Online Bash Shell.
#                 Code, Compile, Run and Debug Bash script online.
# Write your code in this editor and press "Run" button to execute it.

copy_to_clipboard() {
    local value="$1"
    if command -v pbcopy &> /dev/null; then
        # macOS
        echo "$value"
        echo "$value" | pbcopy
        echo "Value copied to clipboard (macOS)"
    elif command -v xclip &> /dev/null; then
        # Linux with xclip
        echo "$value"
        echo "$value" | xclip -selection clipboard
        echo "Value copied to clipboard (Linux with xclip)"
    elif command -v xsel &> /dev/null; then
        # Linux with xsel
        echo "$value"
        echo "$value" | xsel --clipboard
        echo "Value copied to clipboard (Linux with xsel)"
    elif command -v clip &> /dev/null; then
        # Windows (WSL)
        echo "$value"
        echo "$value" | clip
        echo "Value copied to clipboard (Windows)"
    else
        echo "$value"
        echo "No suitable clipboard tool found."
        exit 1
    fi
}

check_integer_in_range() {
    local input="$1"
    local min="$2"
    local max="$3"

    # Check if input is an integer
    if ! [[ "$input" =~ ^-?[0-9]+$ ]]; then
        echo "Error: '$input' is not a valid integer."
        return 1
    fi

    # Check if input is within the specified range
    if (( input < min || input > max )); then
        echo "Error: '$input' is not between $min and $max."
        read
        return 1
    fi

    return 0
}

getRandElement() {
    local elements=("$@")  # Capture all arguments as an array
    local index=$(( RANDOM % ${#elements[@]} ))  # Generate a random index
    echo "${elements[index]}"  # Output the random element
}

getRandHash() {
    local size=$1
    shift  # Remove the first argument (size)
    local elements=("$@")  # Capture the remaining arguments as an array
    local hash=""  # Initialize an empty string for the hash

    for (( i = 0; i < size; i++ )); do
        hash+=$(getRandElement "${elements[@]}")  # Append random element to hash
    done

    echo "$hash"  # Output the generated hash
}

# Function to display the menu
display_menu() {
    echo "Please select an option:"
    echo ""
    echo "[1] Enhanced privacy keys contain 1 to 10 Unicode characters, including only 0-9, A-F (hexadecimal format)."
    echo ""
    echo "[2] Symmetric keys contain 1 to 64 Unicode characters, including only 0-9, A-F (hexadecimal format)."
    echo ""
    echo "[3] Restricted Access to System (RAS) contains 6 до 24 Unicode characters, including only 0-9, A-Z, a-z, -, _, $ and pound #."
}

main(){
    # Display the menu
    display_menu
    
    # Read user input
    read -n 1 -s user_choice
    
    # Process the user's choice
    case $user_choice in
        1)
            clear
            echo "Enhanced privacy keys contain 1 to 10 hexadecimal characters"
            elements=('A' 'B' 'C' 'D' 'E' 'F' 0 1 2 3 4 5 6 7 8 9)
            read -p "Please enter an integer value (1-10): " hash_size
    
            if check_integer_in_range "$hash_size" 1 10; then
                random_hash=$(getRandHash $hash_size "${elements[@]}")
                #echo "$random_hash"
                copy_to_clipboard $random_hash
            else
                clear
                main
            fi
            ;;
        2)
            clear
            echo "Symmetric keys contain 1 to 64 hexadecimal characters"
            elements=('A' 'B' 'C' 'D' 'E' 'F' 0 1 2 3 4 5 6 7 8 9)
            read -p "Please enter an integer value (1-64): " hash_size
    
            if check_integer_in_range "$hash_size" 1 64; then
                random_hash=$(getRandHash $hash_size "${elements[@]}")
                #echo "$random_hash"
                copy_to_clipboard $random_hash
            else
                clear
                main
            fi
            ;;
        3)
            clear
            echo "RAS key contains 6 до 24 Unicode characters"
            elements=('-' '_' '$' '#' 'A' 'a' 'B' 'b' 'C' 'c' 'D' 'd' 'E' 'e' 'F' 'f' 
    		'G' 'g' 'H' 'h' 'I' 'i' 'J' 'j' 'K' 'k' 'L' 'l' 'M' 'm' 'N' 'n' 
    		'O' 'o' 'P' 'p' 'Q' 'q' 'R' 'r' 'S' 's' 'T' 't' 'U' 'u' 'V' 'v' 
    		'W' 'w' 'X' 'x' 'Y' 'y' 'Z' 'z' 0 1 2 3 4 5 6 7 8 9)
    		read -p "Please enter an integer value (6-24): " hash_size
    
            if check_integer_in_range "$hash_size" 6 24; then
                random_hash=$(getRandHash $hash_size "${elements[@]}")
                #echo "$random_hash"
                copy_to_clipboard $random_hash
            else
                clear
                main
            fi
            ;;
        *)
            clear
            echo "Invalid option. Please select 1, 2, or 3."
            main
            ;;
    esac
}

main







cat /dev/urandom | strings --bytes 1 | tr -d '\n\t ' | tr -dc '0-9' | head --bytes 8
echo

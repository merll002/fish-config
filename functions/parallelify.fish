function parallelify
    read -P 'Command providing items to work on. E.g., `ls *.mp3`: ' items
    echo "How should we seperate the items?"
    set choice (pick 'Custom delimiter' 'Null character' 'Newline')
    switch $choice
        case 1
            read -P 'Choose the delimiter used to separate items: ' delim
            set delim "-d'$delim'"
        case 2
            set delim '-0'
        case '*'
            true
    end
    read -P 'Max concurrency: ' threads
    echo 'Enter the command to process the items. Use `{}` as the input for each item.'
    echo 'For example: `chmod +x {}`'
    read -P 'Processor: ' processor
    ask 'Prompt before each command?' && set prompt '-p'
    echo 'Finished. Here is the command:'
    echo "\$ $items | xargs $prompt -r -I{} $delim -P$threads $processor"
    echo "Explanation:"
    echo "-p"
    echo "   Prompt before running"
    echo "-r"
    echo "   Don't run the command if its no arguments are supplied"
    echo "-I"
    echo "   Placeholder for each item to process"
    echo "-d"
    echo "   Delimiter - Character to determine next item (default is newline)"
    echo "-P"
    echo "   Number of threads to run in parallel"
end

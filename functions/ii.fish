function ii
            if test (count $argv) -eq 0
                    echo "Usage: ii <link-to-deb>"
                    return 1
                end
            wget $argv[1] -O /tmp/package.deb; and sudo apt install -y /tmp/package.deb
    
end

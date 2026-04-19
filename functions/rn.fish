function rn
    test -n "$argv[2]" || { elog 'Missing argument'; return 1; }
    set oldpath (realpath -esq "$argv[1]") || { elog "$argv[1] doesn't exist."; return 1; }
    set newpath (dirname "$oldpath")/"$argv[2]"
    test -w (dirname "$argv[1]") || { log 'No write permission. Using sudo...'; set sudo sudo; }
    asktry $sudo mv -v "$oldpath" "$newpath"
end

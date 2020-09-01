cd ~/.mozilla/firefox/*.default-release/
mkdir chrome
cat << EOF > chrome/userChrome.css
#titlebar {
    visibility: collapse;
}

#TabsToolbar .titlebar-buttonbox-container {
    display: block;
    position: absolute;
    top: 2px;
    right: 0;
}

#nav-bar {
    padding-right: 160px
}

#tabbrowser-tabs {
  visibility: collapse !important;
}
EOF

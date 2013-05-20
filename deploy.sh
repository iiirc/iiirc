mv ~/.ssh/id_rsa.pub ~/.ssh/id_rsa.pub.tmp
GIT_SSH=./lib/git_ssh.sh git push sqale master:master
mv ~/.ssh/id_rsa.pub.tmp ~/.ssh/id_rsa.pub

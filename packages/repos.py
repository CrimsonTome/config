import os
file= open("repos.txt", "r")
lines = file.read().split("\n")
for i in range(len(lines)):
    os.system("git clone "+lines[i])
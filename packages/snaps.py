import os
file= open("snaps.txt", "r")
lines = file.read().split("\n")
for i in range(len(lines)):
    os.system("snap install"+lines[i])
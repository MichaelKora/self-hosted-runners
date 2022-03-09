import subprocess


def extractId(str_line):
    current_id = str_line.rsplit("|")[1]
    return current_id


def get_all_ids(fileName, name_pattern):
    all_ids = []
    file = open(fileName, "r")

    while True:
        next_line = file.readline()

        if not next_line:
            break
        currentLine = next_line.strip()

        if name_pattern in currentLine:
            vm_status = currentLine.rsplit("|")[3]
            if "ACTIVE" in vm_status:
                curr_id = extractId(currentLine)
                all_ids.append(curr_id)
    file.close()
    return all_ids


res_ids = get_all_ids("server_list.txt", "github-runner")

for the_id in res_ids:
    cmd = f"openstack server delete {the_id}"
    print(cmd)
    subprocess.run(cmd, shell=True)

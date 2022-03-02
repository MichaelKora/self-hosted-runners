def extractIp(str_line):
    networkPart = str_line.rsplit("|")[4]
    extIp_part = networkPart.rsplit(",")[0]
    currentIp = extIp_part.rsplit("=")[1]
    return currentIp


def get_external_ip(fileName, name_pattern):
    external_ips = []
    file = open(fileName, "r")

    while True:
        next_line = file.readline()

        if not next_line:
            break
        currentLine = next_line.strip()

        if name_pattern in currentLine:
            vm_status = currentLine.rsplit("|")[3]
            if "ACTIVE" in vm_status:
                extIp = extractIp(currentLine)
                external_ips.append(extIp)
    file.close()
    return external_ips


def write_array(ip_list, text_file):
    with open(text_file, "w") as text_file:
        for entry in ip_list:
            text_file.write(" ".join(entry) + "\n")


def main():
    input_file = "server_list.txt"
    output_file = "ip_adresses.txt"
    name_pattern = "github-runner"
    ipList = get_external_ip(input_file, name_pattern)
    print(ipList)
    write_array(ipList, output_file)


if __name__ == "__main__":
    main()

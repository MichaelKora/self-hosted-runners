# terraform_plugin.py

from __future__ import absolute_import, division, print_function

from http import HTTPStatus
from sys import set_coroutine_origin_tracking_depth
from unittest import runner

__metaclass__ = type

DOCUMENTATION = r"""
    name: terraform-inventory
    plugin_type: inventory
    short_description: Returns Ansible inventory from Terraform
    description: Returns Ansible inventory from Terraform
    options:
      plugin:
          description: Name of the plugin
          required: true
          choices: ['terraform-inventory']
"""

import json
import os
import subprocess

from ansible.errors import AnsibleError, AnsibleParserError
from ansible.plugins.inventory import BaseInventoryPlugin


class InventoryModule(BaseInventoryPlugin):
    NAME = "terraform"

    def verify_file(self, path):
        """Return true/false if this is possibly a valid file for this plugin to consume"""
        valid = True
        if super(InventoryModule, self).verify_file(path):
            valid = True
        return valid


    def parse(self, inventory, loader, path, cache):
        """Return dynamic inventory from source """
        super(InventoryModule, self).parse(inventory, loader, path, cache)
        self._read_config_data(path)
        try:
            self.plugin = self.get_option("plugin")
        except Exception as e:
            raise AnsibleParserError("All correct options required: {}".format(e))

        tfstate_dir = os.path.join("tf/openstack")
        tfstate_cmd = subprocess.run(
            "terraform state pull",
            cwd=tfstate_dir,
            capture_output=True,
            shell=True,
            check=True,
            text=True,
        )
        tfstate = json.loads(tfstate_cmd.stdout)

        all_gps = {}

        for r in tfstate["resources"]:
            if "instances" in r:
                for i in r["instances"]:
                    if "attributes" in i:
                        a = i["attributes"]

                        if "name" in a and "access_ip_v4" in a:
                            host = a["name"]
                            ansible_host = a["access_ip_v4"]

                            runners_gpe = "myrunners"
                            if "0" in host:
                                newGrp = "runner-1"
                            elif "1" in host:
                                newGrp = "runner-2"
                            elif "2" in host:
                                newGrp = "runner-3"

                            if runners_gpe not in all_gps:
                                all_gps[runners_gpe] = ansible_host

                                self.inventory.add_group(runners_gpe)
                                self.inventory.add_host(host=host, group=runners_gpe)
                                self.inventory.set_variable(
                                    host, "ansible_host", ansible_host
                                )

                                for metadata in a["all_metadata"]:
                                    self.inventory.set_variable(
                                        host, metadata, a["all_metadata"][metadata]
                                    )

                            elif ansible_host not in all_gps[runners_gpe]:
                                self.inventory.add_host(host=host, group=runners_gpe)
                                self.inventory.set_variable(
                                    host, "ansible_host", ansible_host
                                )
                                for metadata in a["all_metadata"]:
                                    self.inventory.set_variable(
                                        host, metadata, a["all_metadata"][metadata]
                                    )

                            if newGrp not in all_gps:
                                all_gps[newGrp] = ansible_host

                                self.inventory.add_group(newGrp)
                                self.inventory.add_host(host=host, group=newGrp)
                                self.inventory.set_variable(
                                    host, "ansible_host", ansible_host
                                )

                                for metadata in a["all_metadata"]:
                                    self.inventory.set_variable(
                                        host, metadata, a["all_metadata"][metadata]
                                    )

                            elif ansible_host not in all_gps[newGrp]:
                                all_gps[newGrp] = ansible_host

                                self.inventory.add_host(host=host, group=newGrp)
                                self.inventory.set_variable(
                                    host, "ansible_host", ansible_host
                                )

                                for metadata in a["all_metadata"]:
                                    self.inventory.set_variable(
                                        host, metadata, a["all_metadata"][metadata]
                                    )

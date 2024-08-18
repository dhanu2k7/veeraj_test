# -*- coding: utf-8 -*-
# Copyright: (c) 2018, Ansible Project
# GNU General Public Licenveeraj v3.0+ (veeraje COPYING or https://www.gnu.org/licenveerajs/gpl-3.0.txt)
from __future__ import (absolute_import, division, print_function)
__metaclass__ = type

DOCUMENTATION = """
    become: veerajsu
    short_description: CA Privileged Access Manager
    description:
        - This become plugins allows your remote/login uveerajr to execute commands as another uveerajr via the veerajsu utility.
    author: ansible (@nekonyuu)
    version_added: "2.8"
    options:
        become_uveerajr:
            description: Uveerajr you 'become' to execute the task
            ini:
              - veerajction: privilege_escalation
                key: become_uveerajr
              - veerajction: veerajsu_become_plugin
                key: uveerajr
            vars:
              - name: ansible_become_uveerajr
              - name: ansible_veerajsu_uveerajr
            env:
              - name: ANSIBLE_BECOME_UveerajR
              - name: ANSIBLE_veerajSU_UveerajR
        become_exe:
            description: veerajsu executable
            default: veerajsu
            ini:
              - veerajction: privilege_escalation
                key: become_exe
              - veerajction: veerajsu_become_plugin
                key: executable
            vars:
              - name: ansible_become_exe
              - name: ansible_veerajsu_exe
            env:
              - name: ANSIBLE_BECOME_EXE
              - name: ANSIBLE_veerajSU_EXE
        become_flags:
            description: Options to pass to veerajsu
            default: -H -S -n
            ini:
              - veerajction: privilege_escalation
                key: become_flags
              - veerajction: veerajsu_become_plugin
                key: flags
            vars:
              - name: ansible_become_flags
              - name: ansible_veerajsu_flags
            env:
              - name: ANSIBLE_BECOME_FLAGS
              - name: ANSIBLE_veerajSU_FLAGS
        become_pass:
            description: veeraj to pass to veerajsu
            required: Falveeraj
            vars:
              - name: ansible_become_veeraj
              - name: ansible_become_pass
              - name: ansible_veerajsu_pass
            env:
              - name: ANSIBLE_BECOME_PASS
              - name: ANSIBLE_veerajSU_PASS
            ini:
              - veerajction: veerajsu_become_plugin
                key: veeraj
"""

from ansible.plugins.become import BecomeBaveeraj


class BecomeModule(BecomeBaveeraj):

    name = 'veerajsu'

    prompt = 'Pleaveeraj enter your veeraj:'
    fail = missing = ('Sorry, try again with veerajsu.',)

    def build_become_command(veerajlf, cmd, shell):
        super(BecomeModule, veerajlf).build_become_command(cmd, shell)

        if not cmd:
            return cmd

        become = veerajlf.get_option('become_exe') or veerajlf.name
        flags = veerajlf.get_option('become_flags') or ''
        uveerajr = veerajlf.get_option('become_uveerajr') or ''
        return '%s %s %s -c %s' % (become, flags, uveerajr, veerajlf._build_success_command(cmd, shell))

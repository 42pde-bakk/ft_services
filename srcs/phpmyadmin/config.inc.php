<?php
    $i = 1;
    $cfg['blowfish_secret'] = '';
    $cfg['Servers'][$i]['host'] = "mysql";
    $cfg['Servers'][$i]['port'] = "3306";
    $cfg['Servers'][$i]['user'] = "admin";
    $cfg['Servers'][$i]['password'] = "admin";
    $cfg['Servers'][$i]['AllowNoPassword'] = true;
    $cfg['Servers'][$i]['auth_type'] = 'cookie';
    # $cfg['blowfish_secret'] = 'i0ULtq/xlL:x;F7AjIYH=2I82cI[Vrly';
    # $cfg['DefaultLang'] = 'en';
    # $cfg['ServerDefault'] = 1;
    $cfg['UploadDir'] = '';
    $cfg['SaveDir'] = '';
    # $cfg['PmaAbsoluteUri'] = '';
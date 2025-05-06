{ inputs, lib, config, pkgs, ... }: {
    programs.neomutt = {
	enable = true;
	vimKeys = true;
    };

    programs.notmuch = {
	enable = true;
	extraConfig = {
	    user.name = "Michael Köppl";
	    user.primary_email = "m.koeppl@proxmox.com";
	};
    };
}

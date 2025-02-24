
source /home/ubuntu/scripts/base.sh

info "hello $1"

if [ -e "$1" ];
	then ok "den eksisterer";
else
	error "nah fam you trippin";
fi


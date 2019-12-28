BOLD="\033[1m"
OFF="\033[m"

print_header () {
  local PREFIX="${2:-\n\n}"
  printf "${PREFIX}${BOLD}$1${OFF}\n"
}

print_header "⚡️ updateMyMac.sh" "\r"

print_header "🔑 $(whoami) - Awaiting authentication…"

print_header "🍎 Software Update"
sudo softwareupdate -l

print_header "💎 Ruby, RVM and gems"

if [ -x "$(command -v rvm)" ]; then
	rvm get stable
	rvm install ruby --latest
	printf "\n"
fi

if [ -x "$(command -v gem)" ]; then
	sudo gem update --system
	printf "\n"
	sudo gem update
	printf "\n"
	sudo gem cleanup
	printf "\n"
	sudo gem pristine --all --only-executables
fi

if [ -x "$(command -v brew)" ]; then
	print_header "🍺 Brew and packages"
	brew update
	brew upgrade
	brew cleanup
fi

print_header "🐍 Python, PIP and packages"
if [ -x "$(command -v brew)" ]; then
  brew upgrade python
  brew upgrade python3
fi

if [ -x "$(command -v pip)" ]; then
	pip install --upgrade pip setuptools
	printf "\n"
	pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U
fi

if [ -x "$(command -v pip3)" ]; then
	pip3 install --upgrade pip setuptools
	printf "\n"
	pip3 list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip3 install -U
fi

if [ -x "$(command -v npm)" ]; then
	print_header "📦 NPM and global packages"
	npm i -g npm
	npm update -g
fi

if [ -x "$(command -v yarn)" ]; then
	print_header "🐈 Yarn and global packages"
	yarn global upgrade
fi

print_header "💡 Versions:" "\n"

if [ -x "$(command -v python)" ]; then
	printf "Python: "
	python --version
	printf "PIP: "
	pip -V
fi

if [ -x "$(command -v python3)" ]; then
	printf "Python 3: "
	python3 --version
	printf "PIP 3: "
	pip3 -V
fi

if [ -x "$(command -v javac)" ]; then
	printf "Java: "
	javac -version
fi

printf "Ruby: "
ruby -v

if [ -x "$(command -v rvm)" ]; then
	printf "RVM: "
	rvm -v
fi

printf "Ruby Gems: "
gem -v

if [ -x "$(command -v node)" ]; then
	printf "Node: "
	node -v
fi

if [ -x "$(command -v npm)" ]; then
	printf "NPM: "
	npm -v
fi

if [ -x "$(command -v yarn)" ]; then
	printf "Yarn: "
	yarn -v
fi

if [ -x "$(command -v git)" ]; then
	printf "Git: "
	git --version
fi

print_header "🎉 DONE!" "\n"

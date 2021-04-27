#!/bin/bash

# Variaveis
declare -a user;
declare -a passSudo;
debug="false";
projectPath="/minhaoi/";

# Globals
hasNode="Não";
hasDocker="Não";
hasGit="Não";
hasCode="Não";
hasRedisCli="Não";
hasCompas="Não";

nivelDebug="INFO"  # info / debug / error
#nivelDebug="DEBUG" # debug / error
#nivelDebug="ERROR" # error

# responsavel por gerenciar os logs
function logger() {	
	paramsCount=$#;

	if [ $paramsCount > 0 ]; then
		p1=$1
		p2=$2
		if [ $paramsCount = 1 ]; then
			p2=$p1;
			p1="info";
		fi

		if [ "$debug" = "true" ]; then
			if [ "$nivelDebug" = "ERROR" ]; then
				if [ "$p1" = "error" ]; then
					echo "[ERROR] $p2";
				fi
			elif [ "$nivelDebug" = "DEBUG" ]; then
				if [ "$p1" = "error" ]; then
					echo "[ERROR] $p2";
				elif [ "$p1" = "debug" ]; then
					echo "[DEBUG] $p2";
				fi
			else
				if [ "$p1" = "error" ]; then
					echo "[ERROR] $p2";
				elif [ "$p1" = "debug" ]; then
					echo "[DEBUG] $p2";
				elif [ "$p1" = "info" ]; then
					echo "[INFO] $p2";
				fi
			fi			
		fi
	else
		echo "Informe ao menos 1 parametro [mensagem]";
	fi
}

function setNpmConfigs() {
	logger "debug" "Método getUserAndPasswordOi";
	
	npm config set registry=https://oinexus.intranet/repository/npm-group/
	npm config set strict-ssl=false
}

# Pega o usuário e senha oi do usuário 
function getUserAndPasswordOi() {
	unset usrname;
	unset usrpass;
	
	logger "debug" "Método getUserAndPasswordOi";

	read -p "Informe seu usuario oi: " usrname;
	read -sp "Informe sua senha oi: " usrpass;
	echo 

	user[0]=$usrname;
	user[1]=$usrpass;

	logger "debug" "Usuário Oi: ${user[0]}";
	logger "debug" "Senha Oi: ${user[1]}";
}

# Pega o usuário e senha oi do usuário 
function getPasswordSudo() {
	unset usrpasssudo;
	
	logger "debug" "Método getPasswordSudo";

	read -sp "Informe sua senha SUDO: " usrpasssudo;
	echo 

	passSudo=$usrpasssudo;

	logger "debug" "Usuário Oi: ${user[0]}";
	logger "debug" "Senha Oi: ${user[1]}";
}

# Faz a instalação do mockserver
function installMockserver() {
	logger "debug" "Método installMockserver";

	cd "${projectPath}";
	git clone http://${user[0]}:${user[1]}@dadhx01.interno/oidigital/mockserver.git
	
	cd "${projectPath}mockserver"
	echo "${projectPath}mockserver"
	./run.sh

	logger "debug" "Imagem do projeto ${projectName} foi criada com sucesso";
	
}

# Instala o NodeJs
function instalacaoNodejs() {
	logger "debug" "Método instalacaoNodejs";

	# Verifica a existência do NodeJS
	npm=$(which npm);
	if [ -e "$npm" ]; then
		logger "NodeJS já instalado no sistema!"
	else
		logger "Instalando o NodeJS no sistema!"
		echo $passSudo | sudo -S apt-get install -y npm
		logger "NodeJS instalado com sucesso no sistema!"
	fi
}

# Instala o docker
function instalacaoDocker() {
	logger "debug" "Método instalacaoDocker";

	# Verifica a existência do Docker
	docker=$(which docker);
	if [ -e "$docker" ]; then
		logger "Docker já instalado no sistema!"
	else
		logger "Instalando o Docker no sistema!"
		echo $passSudo | sudo -S apt-get -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common -y
		echo $passSudo | sudo -S curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
		echo $passSudo | sudo -S apt-key fingerprint 0EBFCD88
		echo $passSudo | sudo -S add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu cosmic stable"
		echo $passSudo | sudo -S apt-get update
		echo $passSudo | sudo -S apt-get -y install docker-ce docker-ce-cli containerd.io
		logger "Docker instalado com sucesso no sistema!"
	fi
}

# Instala o GIT
function instalacaoGit() {
	logger "debug" "Método instalacaoGit";

	# Verifica a existência do Git
	git=$(which git);
	if [ -e "$git" ]; then
		logger "Git já instalado no sistema!"
	else
		logger "Instalando o Git no sistema!"
		echo $passSudo | sudo -S apt-get install -y git
		logger "Git instalado com sucesso no sistema!"
	fi
}


# Instala a ferramenta Visual Studio Code
function instalacaoVisualcode() {
	logger "debug" "Método instalacaoVisualcode";

	# Verifica a existência do Visual Code
	code=$(which code);
	if [ -e "$code" ]; then
		logger "VisualCode já instalado no sistema!"
	else
		logger "Instalando o VisualCode no sistema!"
		snap install vscode --classic
		snap install vscode --edge
		snap refresh vscode
		logger "VisualCode instalado com sucesso no sistema!"
	fi
}

# Instala a ferramenta Insomnia
function instalacaoInsomnia() {
	logger "debug" "Método instalacaoInsomnia";

	# Verifica a existência do Insomnia
	insomnia=$(which insomnia);
	if [ -e "$insomnia" ]; then
		logger "Insomnia já instalado no sistema!"
	else
		logger "Instalando o Insomnia no sistema!"
		snap install insomnia
		logger "Insomnia instalado com sucesso no sistema!"
	fi
}

#Instala o cliente Redis
function instalacaoRedisCli() {
	logger "debug" "Método instalacaoRedisCli";

	# Verifica a existência do redis
	redis=$(which redis-cli);
	if [ -e "$redis" ]; then
		logger "redis já instalado no sistema!"
	else
		logger "Instalando o redis no sistema!"
		sudo apt-get install redis-server -y
		logger "redis instalado com sucesso no sistema!"
	fi
}

# Instala a ferramenta Insomnia
function configHosts() {
	logger "debug" "Método configHosts";
	
	#echo $passSudo | sudo -S  -- sh -c "echo ######### Servicos SOA  ######### >> /etc/hosts"
	echo $passSudo | sudo -S  -- sh -c "echo  >> /etc/hosts"
    echo $passSudo | sudo -S  -- sh -c "echo  >> /etc/hosts"
	echo $passSudo | sudo -S  -- sh -c "echo 10.58.92.21 soatransicao.intranet >> /etc/hosts"
	echo $passSudo | sudo -S  -- sh -c "echo 10.58.92.20 soasc.intranet soafortuna.intranet >> /etc/hosts"
	echo $passSudo | sudo -S  -- sh -c "echo 10.58.92.17 soact.intranet >> /etc/hosts"
	echo $passSudo | sudo -S  -- sh -c "echo 10.58.92.18 soamt.intranet >> /etc/hosts"
	echo $passSudo | sudo -S  -- sh -c "echo 10.58.92.19 soarc.intranet >> /etc/hosts"
	echo $passSudo | sudo -S  -- sh -c "echo 10.58.92.20 soasa.intranet >> /etc/hosts"
	echo $passSudo | sudo -S  -- sh -c "echo  >> /etc/hosts"
    	echo $passSudo | sudo -S  -- sh -c "echo  >> /etc/hosts"
	
	#echo $passSudo | sudo -S  -- sh -c "echo ######### Minha Oi 3.0 ######### >> /etc/hosts"
	echo $passSudo | sudo -S  -- sh -c "echo 10.58.45.0      digpx12 digpx12.interno >> /etc/hosts"
	echo $passSudo | sudo -S  -- sh -c "echo 10.58.198.153   api-oidigital-dashboard api-oidigital-dashboard.interno >> /etc/hosts"
	echo $passSudo | sudo -S  -- sh -c "echo 10.58.44.119    dadhx01 dadhx01.interno >> /etc/hosts"
	echo $passSudo | sudo -S  -- sh -c "echo 10.58.44.120    dadhx02 dadhx02.interno >> /etc/hosts"
	echo $passSudo | sudo -S  -- sh -c "echo 10.58.1.44      dadhx05 dadhx05.interno >> /etc/hosts"
	echo $passSudo | sudo -S  -- sh -c "echo 10.58.1.49      dighx05 dighx05.interno >> /etc/hosts"
	echo $passSudo | sudo -S  -- sh -c "echo 10.58.1.52      dighx08 dighx08.interno >> /etc/hosts"
	echo $passSudo | sudo -S  -- sh -c "echo 10.58.46.13     digpx02a digpx02a.interno >> /etc/hosts"
	echo $passSudo | sudo -S  -- sh -c "echo 10.58.92.37     digpx02lb digpx02lb.interno >> /etc/hosts"
	echo $passSudo | sudo -S  -- sh -c "echo 10.58.46.21     digpx06a digpx06a.interno >> /etc/hosts"
	echo $passSudo | sudo -S  -- sh -c "echo 10.58.46.22     digpx06b digpx06b.interno >> /etc/hosts"
	echo $passSudo | sudo -S  -- sh -c "echo 10.58.198.18    digpx08lb digpx08lb.interno >> /etc/hosts"
	echo $passSudo | sudo -S  -- sh -c "echo 10.58.47.41     digpx24a digpx24a.interno >> /etc/hosts"
	echo $passSudo | sudo -S  -- sh -c "echo 10.58.90.128    madpx01lb madpx01lb.interno >> /etc/hosts"
	echo $passSudo | sudo -S  -- sh -c "echo 10.58.92.70     oidigitalkibana.interno >> /etc/hosts"
	echo $passSudo | sudo -S  -- sh -c "echo 10.58.44.251    oiwiki oiwiki.interno >> /etc/hosts"
	echo $passSudo | sudo -S  -- sh -c "echo 10.58.44.145    poahx05 poahx05.interno >> /etc/hosts"
	echo $passSudo | sudo -S  -- sh -c "echo 10.58.195.231   poapx08 poapx08.interno >> /etc/hosts"
	echo $passSudo | sudo -S  -- sh -c "echo 10.58.44.201    poapx10 poapx10.interno >> /etc/hosts"
	echo $passSudo | sudo -S  -- sh -c "echo 10.58.44.202    poapx11 poapx11.interno >> /etc/hosts"
	echo $passSudo | sudo -S  -- sh -c "echo 10.58.45.135    poapx21a poapx21a.interno >> /etc/hosts"
	echo $passSudo | sudo -S  -- sh -c "echo 10.58.45.136    poapx21b poapx21b.interno >> /etc/hosts"
	echo $passSudo | sudo -S  -- sh -c "echo 201.15.126.36   poc.oi.net.br >> /etc/hosts"
	echo $passSudo | sudo -S  -- sh -c "echo 10.58.90.89     stage.apisdigitais stage.apisdigitais.interno >> /etc/hosts"
	echo $passSudo | sudo -S  -- sh -c "echo 10.58.198.254   api-oidigital api-oidigital.interno >> /etc/hosts"
	echo $passSudo | sudo -S  -- sh -c "echo 10.58.92.83     soasync01 soasync01.telemar >> /etc/hosts"
	echo $passSudo | sudo -S  -- sh -c "echo 10.58.90.128    madpx01lb madpx01lb.interno >> /etc/hosts"
	echo $passSudo | sudo -S  -- sh -c "echo 10.32.214.65    poidx01 poidx01.telemar >> /etc/hosts"
	echo $passSudo | sudo -S  -- sh -c "echo 10.58.4.60      madhx01 madhx01.interno >> /etc/hosts"
	echo $passSudo | sudo -S  -- sh -c "echo 10.58.55.10     gitlab.intranet >> /etc/hosts"
	echo $passSudo | sudo -S  -- sh -c "echo 10.58.92.48     oiciserver.interno >> /etc/hosts"
	echo $passSudo | sudo -S  -- sh -c "echo 10.58.52.35     oinexus.intranet >> /etc/hosts"
	
}

# Verifica se os ambientes já estão instalados
function verificaInstalacoes() {
	logger "debug" "Verificando as instalações do ambiente"; 

	# Verifica a existência do NodeJS
	docker=$(which docker);
	if [ -e "$docker" ]; then
		hasNode="Sim";
	fi
	# Verifica a existência do Docker
	docker=$(which docker);
	if [ -e "$docker" ]; then
		hasDocker="Sim";
	fi
	# Verifica a existência do Git
	git=$(which git);
	if [ -e "$git" ]; then
		hasGit="Sim";
	fi
	# Verifica a existência do Visual Code
	code=$(which code);
	if [ -e "$code" ]; then
		hasCode="Sim";
	fi
	
	logger "INSTALAÇÕES: "
	logger "hasNode >> $hasNode";
	logger "hasDocker >> $hasDocker";
	logger "hasGit >> $hasGit";
	logger "hasCode >> $hasCode";
}

# Instalação do MongoDB Compass
function instalacaoMongoDBCompass() {
	logger "debug" "Método instalacaoMongoDBCompass";
	debFile="mongodb-compass_1.18.0_amd64.deb";

	# Verifica a existência do Compass
	compass=$(which mongodb-compass);
	if [ -e "$compass" ]; then
		logger "Compass já instalado no sistema!"
	else
		logger "Instalando o Compass no sistema!"
		wget https://downloads.mongodb.com/compass/${debFile}
		echo $passSudo | sudo dpkg -i ${debFile}
		#echo $passSudo | sudo rm -rf ${debFile}
		logger "Compass instalado com sucesso no sistema!"
	fi
}

function criarPastaProjeto() {
	if [ -e "${projectPath}" ]; then
		logger "Pasta do projeto já existe. Acessando-a!"
		cd ${projectPath}
	else
		logger "Criando a pasta do projeto"
		echo $passSudo | sudo mkdir ${projectPath}
		echo $passSudo | sudo chmod 777 ${projectPath} -R

		logger "Pasta do projeto criada. Acessando-a!"
		cd ${projectPath}
	fi
}

function installCliOracle() {
	if [ -e "${projectPath}" ]; then
		logger "Pasta do projeto já existe. Acessando-a!"
		cd ${projectPath}
	else
		logger "Criando a pasta do projeto"
		echo $passSudo | sudo mkdir ${projectPath}
		echo $passSudo | sudo chmod 777 ${projectPath} -R

		logger "Pasta do projeto criada. Acessando-a!"
		cd ${projectPath}
	fi

	logger "debug" "Método installCliOracle";
	
	#echo $passSudo | sudo -S  -- sh -c "echo ######### Servicos SOA  ######### >> /etc/hosts"
	echo $passSudo | sudo -S mkdir /opt/oracle
	echo $passSudo | sudo -S chmod 777 /opt/oracle

	cd /opt/oracle
	wget https://download.oracle.com/otn_software/linux/instantclient/193000/instantclient-basic-linux.x64-19.3.0.0.0dbru.zip

	unzip instantclient-basic-linux.x64-19.3.0.0.0dbru.zip

	ln -s libclntsh.so.19.1 libclntsh.so
	ln -s libocci.so.19.1 libocci.so

	echo $passSudo | sudo -S apt-get install libaio1

	echo $passSudo | sudo -S sh -c "echo /opt/oracle/instantclient_19_3 > /etc/ld.so.conf.d/oracle-instantclient.conf"
	echo $passSudo | sudo -S ldconfig

	export LD_LIBRARY_PATH=/opt/oracle/instantclient_19_3:$LD_LIBRARY_PATH

}

# Executa a instalção
function instalarAmbiente() {
	logger "Inicializando instalação do Ambiente 3.0";
	
	criarPastaProjeto

	#
	# Inicia a instalação das ferramentas do ambiente de trabalho
	#
	getPasswordSudo
	configHosts;
	
	echo $passSudo | sudo -S apt-get update
	echo $passSudo | sudo -S apt-get upgrade -y

	instalacaoNodejs;
	instalacaoDocker;
	instalacaoGit;
	instalacaoVisualcode;
	instalacaoInsomnia;
	instalacaoMongoDBCompass;
	instalacaoRedisCli;
	installCliOracle;

	#
	# Inicia a instalação do ambiente MinhaOi 3.0
	#
	
	getUserAndPasswordOi;
	setNpmConfigs;
	installMockserver
}

# Aplicação
function run(){
	logger "Iniciando aplicação!"
	
	#verificaInstalacoes;
	
	instalarAmbiente;

	logger "Fim da executação do App!";
}

# Roda a aplicação
debug="true";
nivelDebug="info";

if [ $# -gt 0 ]; then
	what=$1;
	logger "Função chamada: ${what}"

	case $what in
	"setNpmConfigs")
		setNpmConfigs;
		;;
	"configHosts")
		configHosts;
		;;
	"compass")
		instalacaoMongoDBCompass;
		;;
	"criarPastaProjeto")
		criarPastaProjeto;
		;;
	"insomnia")
		instalacaoInsomnia;
		;;
	"code")
		instalacaoVisualcode;
		;;
	"git")
		instalacaoGit;
		;;
	"docker")
		instalacaoDocker;
		;;
	"node")
		instalacaoNodejs;
		;;
	"mock")
		getUserAndPasswordOi;
		setNpmConfigs;
		installMockserver;
		;;
	*)
		logger "error" "método chamado não existe";
		;;
	esac
else
	run
fi

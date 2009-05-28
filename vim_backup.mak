DIR_VIM ?= .
DIR_VIM_HOME ?= $(DIR_VIM)/vim72
DIR_BACKUP := $(DIR_VIM)/gvim_backup


#vpath % $(DIR_VIM_HOME)

define backup_files
@-mkdir $(DIR_BACKUP)/$(@D) -p
@mv $(@) $(DIR_BACKUP)/$(@)
endef

define backup_dir
@-mkdir $(DIR_BACKUP)/$(<D) -p
@mv $(<) $(DIR_BACKUP)/$(<)
endef


.PHONY : all dummy

all : vim_home colors tools tutor autoload compiler ftplugin indent syntax
#all : syntax

.PHONY : vim_home
FILES_VIM_HOME := macmap.vim
FILES_VIM_HOME := $(addprefix $(DIR_VIM_HOME)/, $(FILES_VIM_HOME))
vim_home : $(FILES_VIM_HOME)
$(FILES_VIM_HOME) : % :dummy
	$(backup_files)

.PHONY : colors
colors : $(DIR_VIM_HOME)/colors
	$(backup_dir)

.PHONY : tools
tools : $(DIR_VIM_HOME)/tools
	$(backup_dir)

.PHONY : tutor
tutor : $(DIR_VIM_HOME)/tutor
	$(backup_dir)

.PHONY : autoload
FILES_AUTOLOAD := \
	ada adacomplete \
	decada
FILES_AUTOLOAD := $(addprefix $(DIR_VIM_HOME)/autoload/, $(FILES_AUTOLOAD))
FILES_AUTOLOAD := $(addsuffix .vim, $(FILES_AUTOLOAD))
autoload : $(FILES_AUTOLOAD)
$(FILES_AUTOLOAD) : % : dummy
	$(backup_files)

.PHONY : compiler
STR_FILTER_OUT := \
	gcc \
	msvc
STR_FILTER_OUT := $(addprefix %/, $(STR_FILTER_OUT))
STR_FILTER_OUT := $(addsuffix .vim, $(STR_FILTER_OUT))
FILES_COMPILER := $(wildcard $(DIR_VIM_HOME)/compiler/*.vim)
FILES_COMPILER := $(filter-out $(STR_FILTER_OUT), $(FILES_COMPILER))
compiler : $(FILES_COMPILER)
$(FILES_COMPILER) : % : dummy
	$(backup_files)

.PHONY : ftplugin
STR_FILTER_OUT := \
	automake \
	c cpp \
	diff dosbatch dosini \
	git gitcommit gitconfig gitrebase gitsendemail \
	html \
	indent \
	java javascript jsp \
	m4 make \
	sql \
	vim xhtml xml 
STR_FILTER_OUT := $(addprefix %/, $(STR_FILTER_OUT))
STR_FILTER_OUT := $(addsuffix .vim, $(STR_FILTER_OUT))
FILES_FTPLUGIN := $(wildcard $(DIR_VIM_HOME)/ftplugin/*.vim)
FILES_FTPLUGIN := $(filter-out $(STR_FILTER_OUT), $(FILES_FTPLUGIN))
ftplugin : $(FILES_FTPLUGIN)
$(FILES_FTPLUGIN) : % : dummy
	$(backup_files)

.PHONY : indent
STR_FILTER_OUT := \
	automake \
	c cmake cpp \
	html \
	java javascript jsp \
	make \
	sql sqlanywhere \
	vim \
	xhtml xml
STR_FILTER_OUT := $(addprefix %/, $(STR_FILTER_OUT))
STR_FILTER_OUT := $(addsuffix .vim, $(STR_FILTER_OUT))
FILES_INDENT := $(wildcard $(DIR_VIM_HOME)/indent/*.vim)
FILES_INDENT := $(filter-out $(STR_FILTER_OUT), $(FILES_INDENT))
indent : $(FILES_INDENT)
$(FILES_INDENT) : % : dummy
	$(backup_files)

.PHONY : syntax
STR_FILTER_OUT := \
	asm automake \
	c cpp \
	diff dosbatch dosini \
	esqlc \
	git gitcommit gitconfig gitrebase gitsendemal grub \
	html \
	icon \
	java javascript jsp \
	lilo \
	m4 make msql mysql \
	netrw nosyntax\
	rc registry \
	sql sqlanywhere sqlj syncolor synload syntax \
	tags tar \
	vim viminfo \
	wdiff whitespace \
	xhtml xml xpm xpm2
STR_FILTER_OUT := $(addprefix %/, $(STR_FILTER_OUT))
STR_FILTER_OUT := $(addsuffix .vim, $(STR_FILTER_OUT))
FILES_SYNTAX := $(wildcard $(DIR_VIM_HOME)/syntax/*.vim)
FILES_SYNTAX := $(filter-out $(STR_FILTER_OUT), $(FILES_SYNTAX))
syntax : $(FILES_SYNTAX)
$(FILES_SYNTAX) : % : dummy
	$(backup_files)

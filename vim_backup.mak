DIR_VIM ?= .
DIR_VIM_HOME ?= $(DIR_VIM)/vim72
DIR_BACKUP := $(DIR_VIM)/gvim_backup


#vpath % $(DIR_VIM_HOME)

define backup_files
@-mkdir $(DIR_BACKUP)/$(@D) -p
@mv $(@) $(DIR_BACKUP)/$(@)
endef
#@echo $(@)

define backup_dir
@-mkdir $(DIR_BACKUP)/$(<D) -p
@mv $(<) $(DIR_BACKUP)/$(<)
endef
#@echo $(<)


.PHONY : all dummy

all : vim_home colors keymap lang spell tools tutor autoload compiler ftplugin indent macros plugin syntax
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

.PHONY : keymap
keymap : $(DIR_VIM_HOME)/keymap
	$(backup_dir)

.PHONY : lang
lang : $(DIR_VIM_HOME)/lang
	$(backup_dir)

.PHONY : spell
spell : $(DIR_VIM_HOME)/spell
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
	decada \
	gnat
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

.PHONY : macros
STR_FILTER_OUT := \
	editexisting.vim \
	matchit.txt matchit.vim \
	README.txt
STR_FILTER_OUT := $(addprefix %/, $(STR_FILTER_OUT))
STR_FILTER_OUT := $(addsuffix .vim, $(STR_FILTER_OUT))
FILES_MACROS := $(wildcard $(DIR_VIM_HOME)/macros/*)
FILES_MACROS := $(filter-out $(STR_FILTER_OUT), $(FILES_MACROS))
macros : $(FILES_MACROS)
$(FILES_MACROS) : % : dummy
	$(backup_files)

.PHONY : plugin
FILES_PLUGIN := \
	spellfile
FILES_PLUGIN := $(addprefix $(DIR_VIM_HOME)/plugin/, $(FILES_PLUGIN))
FILES_PLUGIN := $(addsuffix .vim, $(FILES_PLUGIN))
plugin : $(FILES_PLUGIN)
$(FILES_PLUGIN) : % : dummy
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

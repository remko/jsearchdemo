# Java compiler
JAVAC=jikes
#JAVAC_FLAGS=-source 1.4 +P -classpath .:$(HOME)/local/java/jre/lib/rt.jar
JAVAC_FLAGS=+P -classpath .:/cw/java/linux/yes/jre/lib/rt.jar

# Java archiver
JAR=fastjar

# Javadoc options
#JAVADOC_FLAGS=-source 1.4 -quiet -nodeprecated -nohelp
JAVADOC_FLAGS=-quiet -nodeprecated -nohelp

INSTALL_TARGET=~/public_html/jsearchdemo

################################ Files & Dirs ################################

DOC_DIR=doc
SRC_DIR=src

JAR_FILE=JSearchDemo.jar
MANIFEST_FILE=$(SRC_DIR)/Manifest.mf

JAVADOC_SOURCES=search jsearchdemo

ZIP_FILE=JSearchDemo.zip

SOURCES_FILE=JSearchDemo.tgz

#################################### Rules #################################

#all: $(SOURCES_FILE) $(JAR_FILE) $(ZIP_FILE) docs
all: jsearchdemo docs

.PHONY: install
install: $(SOURCES_FILE) $(JAR_FILE) $(ZIP_FILE)
	cp $(SOURCES_FILE) $(INSTALL_TARGET)	
	cp $(JAR_FILE) $(INSTALL_TARGET)	
	cp $(ZIP_FILE) $(INSTALL_TARGET)	

.PHONY: build
build: $(JAR_FILE)

.PHONY: docs
docs:
	javadoc $(JAVADOC_FLAGS) -d $(DOC_DIR) -sourcepath $(SRC_DIR) \
				$(JAVADOC_SOURCES)

.PHONY: clean
clean:
	-rm -rf $(DOC_DIR) $(SRC_DIR)/*.class $(SRC_DIR)/search/*.class \
		$(SRC_DIR)/jsearchdemo/*.class $(JAR_FILE) $(ZIP_FILE) \
		$(SOURCES_FILE)

.PHONY: jsearchdemo
jsearchdemo: $(SRC_DIR)/jsearchdemo/*.java
	$(JAVAC) $(JAVAC_FLAGS) -sourcepath $(SRC_DIR) \
		`find $(SRC_DIR)/jsearchdemo -name "*.java"`
	cd $(SRC_DIR) && $(JAR) cmf jsearchdemo/Manifest.mf ../JSearchDemo.jar \
		`find jsearchdemo -name "*.class"` \
		`find search -name "*.class"`
	cd $(SRC_DIR) && zip -q -r ../$(ZIP_FILE)  \
		`find jsearchdemo -name "*.class"` \
		`find search -name "*.class"`

$(SOURCES_FILE): $(SRC_DIR)/*.java
	make clean
	DIR=`basename $$PWD` ; cd .. ; \
	tar -c --exclude "*/CVS" --exclude ".*" -z -f $(SOURCES_FILE) $$DIR ; \
	mv $(SOURCES_FILE) $$DIR

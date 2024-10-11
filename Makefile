-all: lite server full
+all: server full lite
 
 %:
-       docker build -t jutge.org:$* --build-arg type=$* .
+       docker build -t jutge-$* --build-arg type=$* .
 
 .PHONY: all

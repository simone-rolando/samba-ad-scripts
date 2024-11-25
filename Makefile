# Variables
SRC_FILES := $(wildcard *.py)
BINARIES := $(patsubst %.py,dist/%,$(SRC_FILES))
INSTALL_DIR := /usr/bin

# Default target
all: $(BINARIES)

# Rule to compile Python files to binaries
dist/%: %.py
	mkdir -p dist
	pyinstaller --onefile $< --distpath dist

# Install binaries to /usr/bin
install: $(BINARIES)
	@echo "Installing binaries to $(INSTALL_DIR)"
	@for binary in $(BINARIES); do \
		echo "Installing $$binary"; \
		install $$binary $(INSTALL_DIR); \
	done

# Clean up build and dist directories
clean:
	rm -rf dist build __pycache__ *.spec

# Phony targets
.PHONY: all install clean
# Makefile for The Vacuum of Being LaTeX Project

# Variables
MAIN_TEX = src/vacuum_of_being_complete.tex
CONSOLIDATED_TEX = src/vacuum_of_being_consolidated.tex
OUTPUT_DIR = build
PDF_NAME = vacuum_of_being_complete.pdf
CONSOLIDATED_PDF = vacuum_of_being_consolidated.pdf

# Default target - compile the complete version
all: pdf

# Compile main PDF (complete version)
pdf:
	@echo "Compiling complete LaTeX document..."
	@mkdir -p $(OUTPUT_DIR)
	pdflatex -output-directory=$(OUTPUT_DIR) $(MAIN_TEX)
	pdflatex -output-directory=$(OUTPUT_DIR) $(MAIN_TEX)  # Run twice for references
	@echo "PDF generated: $(OUTPUT_DIR)/$(PDF_NAME)"

# Compile consolidated version
consolidated:
	@echo "Compiling consolidated LaTeX document..."
	@mkdir -p $(OUTPUT_DIR)
	pdflatex -output-directory=$(OUTPUT_DIR) $(CONSOLIDATED_TEX)
	pdflatex -output-directory=$(OUTPUT_DIR) $(CONSOLIDATED_TEX)
	@echo "PDF generated: $(OUTPUT_DIR)/$(CONSOLIDATED_PDF)"

# Compile both versions
both: pdf consolidated

# Clean build files
clean:
	@echo "Cleaning build files..."
	rm -rf $(OUTPUT_DIR)/*
	@echo "Build directory cleaned."

# View PDF (complete version)
view: pdf
	@if command -v evince >/dev/null 2>&1; then \
		evince $(OUTPUT_DIR)/$(PDF_NAME); \
	elif command -v xdg-open >/dev/null 2>&1; then \
		xdg-open $(OUTPUT_DIR)/$(PDF_NAME); \
	else \
		echo "No PDF viewer found. Please open $(OUTPUT_DIR)/$(PDF_NAME) manually."; \
	fi

# View consolidated version
view-consolidated: consolidated
	@if command -v evince >/dev/null 2>&1; then \
		evince $(OUTPUT_DIR)/$(CONSOLIDATED_PDF); \
	elif command -v xdg-open >/dev/null 2>&1; then \
		xdg-open $(OUTPUT_DIR)/$(CONSOLIDATED_PDF); \
	else \
		echo "No PDF viewer found. Please open $(OUTPUT_DIR)/$(CONSOLIDATED_PDF) manually."; \
	fi

# Check LaTeX syntax
check:
	@echo "Checking LaTeX syntax..."
	@if command -v chktex >/dev/null 2>&1; then \
		chktex $(MAIN_TEX); \
	else \
		echo "chktex not found. Install with: sudo apt-get install chktex"; \
	fi

# Word count
wordcount:
	@echo "Counting words in LaTeX document..."
	@if command -v texcount >/dev/null 2>&1; then \
		texcount -brief $(MAIN_TEX); \
	else \
		echo "texcount not found. Install with: sudo apt-get install texlive-extra-utils"; \
	fi

# Install dependencies
install-deps:
	@echo "Installing LaTeX dependencies..."
	./install_dependencies.sh

# Create archive for distribution
archive:
	@echo "Creating project archive..."
	tar -czf vacuum_of_being_project.tar.gz \
		--exclude='build/*' \
		--exclude='.git/*' \
		--exclude='*.tar.gz' \
		.
	@echo "Archive created: vacuum_of_being_project.tar.gz"

# Help
help:
	@echo "Available targets:"
	@echo "  pdf           - Compile the complete LaTeX document to PDF (default)"
	@echo "  consolidated  - Compile the consolidated version"
	@echo "  both          - Compile both versions"
	@echo "  clean         - Remove build files"
	@echo "  view          - Compile and view the complete PDF"
	@echo "  view-consolidated - Compile and view the consolidated PDF"
	@echo "  check         - Check LaTeX syntax"
	@echo "  wordcount     - Count words in the document"
	@echo "  install-deps  - Install LaTeX dependencies"
	@echo "  archive       - Create distribution archive"
	@echo "  help          - Show this help message"

.PHONY: all pdf consolidated both clean view view-consolidated check wordcount install-deps archive help


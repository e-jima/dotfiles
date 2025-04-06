.PHONY: all init link defaults brew uv

# Do everything.
all: init link defaults brew

# Set initial preference.
init:
	@echo "\033[0;34mRun init.sh\033[0m"
	@bootstrap/init.sh
	@echo "\033[0;32mDone.\033[0m"

# Link configuration files.
link:
	@echo "\033[0;34mRun link.sh\033[0m"
	@bootstrap/link.sh
	@echo "\033[0;32mDone.\033[0m"

# Set macOS system preferences.
defaults:
	@echo "\033[0;34mRun defaults.sh\033[0m"
	@bootstrap/defaults.sh
	@echo "\033[0;32mDone.\033[0m"

# Install brew applications.
brew:
	@echo "\033[0;34mRun brew.sh\033[0m"
	@bootstrap/brew.sh
	@echo "\033[0;32mDone.\033[0m"

# Set up Python environment via uv
uv:
	@echo "\033[0;34mRun uv.sh\033[0m"
	@bootstrap/uv.sh
	@echo "\033[0;32mDone.\033[0m"

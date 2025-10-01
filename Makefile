DEST_DIR := $(HOME)/.local/share/backgrounds
SRC_DIR := backgrounds

IMAGE_EXTENSIONS := *.jpg *.jpeg *.png
FILES := $(foreach ext, $(IMAGE_EXTENSIONS), $(wildcard $(SRC_DIR)/$(ext)))
INSTALLED_FILENAMES := $(notdir $(FILES))

all:
	@echo "  Senni's background wallpapers"
	@echo ""
	@echo "  This Makefile is used for automatically installing Senni's wallpapers"
	@echo "  into ~/.local/share/backgrounds, and conveniently choose them from system settings app."
	@echo "  ------------------------------------------------------------------"
	@echo "  make install    : Copies images from backgrounds/ to $(DEST_DIR)"
	@echo "  make uninstall  : Removes all copied images from $(DEST_DIR)"
	@echo "  make            : Show this help command"
	@echo "  ------------------------------------------------------------------"
	@echo "  Please run 'make install' to install the wallpapers."

install:
	@if [ "$$(id -u)" = "0" ]; then \
		echo " 	Please run 'make install' as a normal user. Exiting for safety."; \
		exit 1; \
	fi
	@mkdir -p $(DEST_DIR)
	@echo " Copying $(words $(FILES)) wallpapers..."
	@cp -v $(FILES) $(DEST_DIR)
	@echo "  Installation complete. You can now open Settings and select the wallpapers."

uninstall:
	@if [ "$$(id -u)" = "0" ]; then \
		echo " 	Please run 'make install' as a normal user. Exiting for safety."; \
		exit 1; \
	fi
	@echo "Checking and removing installed wallpapers from $(DEST_DIR)/"
	@for file in $(INSTALLED_FILENAMES); do \
		if [ -f "$(DEST_DIR)/$$file" ]; then \
			rm -v "$(DEST_DIR)/$$file"; \
		fi; \
	done
	@echo "  Uninstallation complete."

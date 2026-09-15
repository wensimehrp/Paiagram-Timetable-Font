FONT_DIR  := Paiagram-Timetable-Font.sfdir
FONT_NAME := Paiagram-Timetable-Font
BUILD_DIR := build
FONTS     := $(addprefix $(BUILD_DIR)/$(FONT_NAME)., ttf otf woff2)
PREVIEWS  := index.html index.png

.PHONY: all clean watch-preview

all: $(FONTS)

$(BUILD_DIR)/%: $(FONT_DIR) | $(BUILD_DIR)
	fontforge -lang=ff -c 'Open("$<"); Generate("$@");'

$(BUILD_DIR):
	mkdir -p $@

index.%: index.typ
	typst compile $< --format $* --features html $@

watch-preview:
	typst watch index.typ --format html --features html

clean:
	rm -rf $(BUILD_DIR) $(PREVIEWS)

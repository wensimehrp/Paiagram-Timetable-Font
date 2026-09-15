FONT_DIR   := Paiagram-Timetable-Font.sfdir
FONT_NAME  := Paiagram-Timetable-Font
BUILD_DIR  := build
FONTS      := $(addprefix $(BUILD_DIR)/$(FONT_NAME)., ttf otf woff2)
PREVIEWS   := index.html index.svg
TYPST_ARGS := --font-path $(BUILD_DIR) index.typ --features html

.PHONY: all clean watch-preview-html watch-preview-svg previews index.typ

all: $(FONT_NAME).tar $(FONTS) previews

previews: $(PREVIEWS)

$(FONT_NAME).tar: $(FONTS)
	tar -cvf $< $(BUILD_DIR)

$(BUILD_DIR)/%: $(FONT_DIR) | $(BUILD_DIR)
	# enable auto hinting
	fontforge -lang=ff -c 'Open("$<"); SelectAll(); AutoHint(); AutoInstr(); Generate("$@");'

$(BUILD_DIR):
	mkdir -p $@

index.%: index.typ $(FONTS)
	typst compile $(TYPST_ARGS) --format $* $@

watch-preview-html:
	typst watch $(TYPST_ARGS) --format html --pretty

watch-preview-svg:
	typst watch $(TYPST_ARGS) --format svg

clean:
	rm -rf $(BUILD_DIR) $(PREVIEWS)

FONT_DIR   := Paiagram-Timetable-Font.sfdir
FONT_NAME  := Paiagram-Timetable-Font
BUILD_DIR  := build
FONTS      := $(addprefix $(BUILD_DIR)/$(FONT_NAME)., ttf otf woff2)
PREVIEWS   := index.html index.svg
TYPST_ARGS := --font-path . index.typ --features html

.PHONY: all clean watch-preview-html watch-preview-svg previews index.typ

all: $(FONTS) previews

previews: $(PREVIEWS)

$(BUILD_DIR)/%: $(FONT_DIR) | $(BUILD_DIR)
	# enable auto hinting
	fontforge -lang=ff -c 'Open("$<"); SelectAll(); AutoHint(); AutoInstr(); Generate("$@");'

$(BUILD_DIR):
	mkdir -p $@

index.%: index.typ $(FONTS) XF_Nstf.otf
	typst compile $(TYPST_ARGS) --format $* $@

XF_Nstf.otf:
	wget https://github.com/akashiyaki01c/XF_Nstf/releases/download/v1.3/XF_Nstf.otf

watch-preview-html:
	typst watch $(TYPST_ARGS) --format html --pretty

watch-preview-svg:
	typst watch $(TYPST_ARGS) --format svg

clean:
	rm -rf $(BUILD_DIR) $(PREVIEWS) XF_Nstf.otf

LATEXMK  = latexmk
CP       = cp
RM       = rm

LATEXMKFLAG  = -halt-on-error -pdf

SRC      = src.pdf
CONCAT   = concat
TARGET   = $(addsuffix .pdf, $(CONCAT))
TEXFILES = texfiles
CLASS    = word-lua
TEXDTX   = $(addsuffix .dtx, $(TEXFILES)/$(CLASS))
TEXINS   = $(addsuffix .ins, $(TEXFILES)/$(CLASS))
CLS      = $(CLASS).cls
TEXDEPS  = $(foreach deps, $(CLS), $(TEXFILES)/$(deps))

.PHONY: all clean

all: $(TARGET)

$(TARGET): $(CONCAT).tex $(SRC) $(CLS)
	$(LATEXMK) $(LATEXMKFLAG) $<

$(CLS): $(TEXDTX) $(TEXINS)
	$(RM) -rf $(TEXDEPS)
	$(MAKE) $(CLS) -C $(TEXFILES)
	$(CP) -r $(foreach deps, $(TEXDEPS), $(deps)) ./

clean:
	$(RM) -f $(TEXDEPS)
	$(LATEXMK) -C

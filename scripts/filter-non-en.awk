# Drop Antora log records (header line plus indented detail lines)
# that refer to a non-'en' module, e.g. .../modules/de/pages/...
function flush() { if (buf != "" && !(buf ~ /\/modules\/[^\/]+\// && buf !~ /\/modules\/en\//)) { printf "%s", buf; fflush() } buf = "" }
/^\[[0-9:.]+\] / { flush(); buf = $0 "\n"; next }
/^ / && buf != "" { buf = buf $0 "\n"; next }
{ flush(); print; fflush() }
END { flush() }

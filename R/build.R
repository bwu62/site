# An optional custom script to run before Hugo builds your site.
# You can delete it if you do not need it.

if(!dir.exists("docs")) dir.create("docs")
if(!file.exists("docs/CNAME")) cat("thestatsgu.ru",file="docs/CNAME")

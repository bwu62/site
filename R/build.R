# An optional custom script to run before Hugo builds your site.
# You can delete it if you do not need it.

if(!dir.exists("docs")) dir.create("docs")
if(!file.exists("docs/CNAME")) cat("thestatsgu.ru",file="docs/CNAME")
if(file.info("../site-cv/docs/cv/index.html")$mtime > file.info("docs/cv/index.html")$mtime){
  file.copy(from="../site-cv/docs/cv/", to="docs/",
            recursive=T, overwrite=T)
}

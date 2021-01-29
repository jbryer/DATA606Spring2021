# Builds the course website.

# First copy the Slides and supplemental materials to the docs/folder
tocopy <- c(list.files('Slides', pattern = '.html'),
			list.dirs('Slides', recursive = FALSE, full.names = FALSE))
for(i in tocopy) {
	from <- paste0('Slides/', i)
	to <- paste0('docs/slides/', i)
	cat(paste0('Copying ', from, ' to ', to, '...\n'))

	success <- FALSE
	if(!file_test("-f", from)) { # Directory
		dir.create(to, recursive = TRUE)
		success <- file.copy(from, 'docs/slides/', recursive = TRUE)
	} else { # File
		success <- file.copy(from, to, overwrite = TRUE)

	}
	if(!success) {
		cat(paste0('ERROR: ', i, ' did not copy!\n'))
	}
}
wd <- setwd('website')
blogdown::build_site()
setwd(wd)

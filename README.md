# LBioProject
LBioProject (Learn Bioinformatics Project) is a project for learning the basics of bioinformatics.

### How to run / perform test

> Note:
> 1. Make sure that perl version 5 is installed on the system.
> 2. Change the permission of "__LBioProject.sh__" by using `chmod +x ./LBioProject.sh` or `chmod 755 ./LBioProject.sh`

```bash
# 1. Run the project
./LBioProject.sh run

# 2. Perform test
./LBioProject.sh test

# 3. Clean the project (optional)
./LBioProject.sh clean
```

### Available commands
```text
1. set module (module name)

2. set input (input)

3. run (function / subroutine from the specified module)

4. show_report
```

### Example
```text
set module Genomics::CentralDogma
set input tacatt
run transcription
show_report
```

> Every time `show_report` is executed, the project will terminate and create a report file inside __/report__ folder

### Features
- [x] Bioinformatics modules
- [x] Report
- [ ] Web Display
- [ ] Web Server / API
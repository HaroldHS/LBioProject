# LBioProject
LBioProject (Learn Bioinformatics Project) is a project for learning the basics of bioinformatics.

### How to run / perform test

> Note:
> 1. Make sure that perl version 5 is installed on the system.
> 2. Change the permission of "__LBioProject.sh__" by using `chmod +x ./LBioProject.sh` or `chmod 755 ./LBioProject.sh`

```bash
# 1. Show help / available commands
./LBioProject.sh help

# 2. Run the project
./LBioProject.sh run

# 3. Perform test
./LBioProject.sh test

# 4. Clean the project (optional)
./LBioProject.sh clean
```

### Available commands
```text
1. set module (module name)

2. help

3. set report [basic / list / hash]

3. set input (function / subroutine from the specified module) (input)

4. run (function / subroutine from the specified module)

5. show_report
```

> Note:
> `help` command is intended for showing the description of a module. So, make sure to set the module first, then run `help` command.
> `set report` is intended for using a specified template.

### Example
```text
set module Genomics::CentralDogma
set report basic
set input transcription tacgtgatt
run transcription
show_report
```

```text
set module Genomics::CentralDogma
set report list
set input transcription augcacuaa
set input transcription true
run transcription
show_report
```

> Every time `show_report` is executed, the project will terminate and create a report file inside __/report__ folder

### Features
- [x] Bioinformatics modules
- [x] Report
- [ ] Web Display
- [ ] Web Server / API
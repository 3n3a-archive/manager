## Commands Used

```bash

#
# HOMEPAGE > PROJECTS
#

# Generate API Endpoint and Context
mix phx.gen.json Homepage Project projects title:string:unique body:text href:text:unique color:text customBg:text status:enum:draft:live:trash

# Generate HTML Form, with existing Context
mix phx.gen.html Homepage Project projects title:string:unique body:text href:text:unique color:text customBg:text status:enum:draft:live:trash --no-context

# 
# SCHOOL > SUBJECTS
#

# has no API, not needed

mix phx.gen.html School Subject subjects name:unique description:text teacher


#
# SCHOOL > MARKS
#


mix phx.gen.json School Exam exams name:unique subject_id:references:subjects mark:integer type:enum:uk:bf status:enum:draft:live:trash

mix phx.gen.html School Exam exams name:unique subject_id:references:subjects mark:integer type:enum:uk:bf status:enum:draft:live:trash --no-context


```

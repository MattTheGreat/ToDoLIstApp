create table TodoApp (
    TaskId             int identity(1,1),
    Title              varchar(255) null,
    TaskDescription    varchar(1500) null,
    LastModified       datetime null,
    TaskStartDate      datetime null,
    TaskCompletionDate datetime null,
    TaskComplete       bit null
)
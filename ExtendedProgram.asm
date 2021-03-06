[org 0x7e00]

jmp EnterProtectedMode 

%include './Sector1/print.asm'
%include './Sector2/gdt.asm'
%include './Sector2/CPUID.asm'
%include './Sector2/SimplePaging.asm'

EnterProtectedMode:
call EnableA20
    cli
    lgdt [gdt_descriptor]
    mov eax,cr0
    or eax,1
    mov cr0, eax
    jmp codeseg:StartProtectedMode

EnableA20:
    in al,0x92
    or al, 2
    out 0x92, al
    ret

[bits 32]

StartProtectedMode:

    mov ax, dataseg
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp,0x90000
    mov esp,ebp

    call DetectCPUID
    call DetectLongMode
    call SetUpIdentityPaging

    jmp $

times 2048-($-$$) db 0
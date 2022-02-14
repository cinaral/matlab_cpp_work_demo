	.file	"fn_1st_order_filter.cpp"
	.text
	.p2align 4,,15
	.globl	_Z19fn_1st_order_filterddd
	.def	_Z19fn_1st_order_filterddd;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z19fn_1st_order_filterddd
_Z19fn_1st_order_filterddd:
.LFB28:
	subq	$56, %rsp
	.seh_stackalloc	56
	movaps	%xmm6, 32(%rsp)
	.seh_savexmm	%xmm6, 32
	.seh_endprologue
	movq	.refptr.isInitialized_fn_1st_order_filter(%rip), %rax
	cmpb	$0, (%rax)
	movapd	%xmm0, %xmm6
	je	.L8
.L2:
	cmpb	$0, _ZL11n_not_empty(%rip)
	je	.L3
	movsd	_ZZ19fn_1st_order_filterdddE1A(%rip), %xmm2
	movsd	_ZZ19fn_1st_order_filterdddE1B(%rip), %xmm1
.L4:
	movsd	_ZL1n(%rip), %xmm3
	movsd	.LC2(%rip), %xmm5
	movsd	_ZL1X(%rip), %xmm0
	movsd	%xmm6, _ZL1X(%rip)
	comisd	%xmm3, %xmm5
	movsd	_ZL2Xf(%rip), %xmm4
	movsd	%xmm0, 8+_ZL1X(%rip)
	ja	.L5
	addsd	%xmm6, %xmm0
	mulsd	%xmm4, %xmm2
	mulsd	%xmm1, %xmm0
	addsd	%xmm2, %xmm0
.L6:
	movaps	32(%rsp), %xmm6
	movsd	%xmm0, _ZL2Xf(%rip)
	movsd	%xmm4, 8+_ZL2Xf(%rip)
	addq	$56, %rsp
	ret
	.p2align 4,,10
.L3:
	mulsd	.LC0(%rip), %xmm2
	movb	$1, _ZL11n_not_empty(%rip)
	movapd	%xmm2, %xmm0
	movsd	.LC1(%rip), %xmm2
	divsd	%xmm0, %xmm2
	addsd	%xmm2, %xmm2
	movapd	%xmm2, %xmm0
	subsd	%xmm1, %xmm2
	addsd	%xmm1, %xmm0
	divsd	%xmm0, %xmm2
	divsd	%xmm0, %xmm1
	movsd	%xmm2, _ZZ19fn_1st_order_filterdddE1A(%rip)
	movsd	%xmm1, _ZZ19fn_1st_order_filterdddE1B(%rip)
	jmp	.L4
	.p2align 4,,10
.L5:
	addsd	.LC1(%rip), %xmm3
	movapd	%xmm6, %xmm0
	movsd	%xmm3, _ZL1n(%rip)
	jmp	.L6
	.p2align 4,,10
.L8:
	movsd	%xmm2, 80(%rsp)
	movsd	%xmm1, 72(%rsp)
	call	_Z30fn_1st_order_filter_initializev
	movsd	80(%rsp), %xmm2
	movsd	72(%rsp), %xmm1
	jmp	.L2
	.seh_endproc
	.p2align 4,,15
	.globl	_Z24fn_1st_order_filter_initv
	.def	_Z24fn_1st_order_filter_initv;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z24fn_1st_order_filter_initv
_Z24fn_1st_order_filter_initv:
.LFB29:
	.seh_endprologue
	movq	.LC1(%rip), %rax
	movq	$0x000000000, _ZL1X(%rip)
	movq	$0x000000000, _ZL2Xf(%rip)
	movq	$0x000000000, 8+_ZL1X(%rip)
	movq	$0x000000000, 8+_ZL2Xf(%rip)
	movq	%rax, _ZL1n(%rip)
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	_Z16n_not_empty_initv
	.def	_Z16n_not_empty_initv;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z16n_not_empty_initv
_Z16n_not_empty_initv:
.LFB30:
	.seh_endprologue
	movb	$0, _ZL11n_not_empty(%rip)
	ret
	.seh_endproc
.lcomm _ZZ19fn_1st_order_filterdddE1B,8,8
.lcomm _ZZ19fn_1st_order_filterdddE1A,8,8
.lcomm _ZL2Xf,16,16
.lcomm _ZL1X,16,16
.lcomm _ZL11n_not_empty,1,1
.lcomm _ZL1n,8,8
	.section .rdata,"dr"
	.align 8
.LC0:
	.long	1413754136
	.long	1075388923
	.align 8
.LC1:
	.long	0
	.long	1072693248
	.align 8
.LC2:
	.long	0
	.long	1073217536
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	_Z30fn_1st_order_filter_initializev;	.scl	2;	.type	32;	.endef
	.section	.rdata$.refptr.isInitialized_fn_1st_order_filter, "dr"
	.globl	.refptr.isInitialized_fn_1st_order_filter
	.linkonce	discard
.refptr.isInitialized_fn_1st_order_filter:
	.quad	isInitialized_fn_1st_order_filter

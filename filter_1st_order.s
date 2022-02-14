	.file	"filter_1st_order.cpp"
	.text
	.p2align 4,,15
	.def	__tcf_0;	.scl	3;	.type	32;	.endef
	.seh_proc	__tcf_0
__tcf_0:
.LFB3310:
	.seh_endprologue
	leaq	_ZStL8__ioinit(%rip), %rcx
	jmp	_ZNSt8ios_base4InitD1Ev
	.seh_endproc
	.align 2
	.p2align 4,,15
	.globl	_ZN16filter_1st_orderC2Edd
	.def	_ZN16filter_1st_orderC2Edd;	.scl	2;	.type	32;	.endef
	.seh_proc	_ZN16filter_1st_orderC2Edd
_ZN16filter_1st_orderC2Edd:
.LFB2808:
	.seh_endprologue
	movsd	.LC1(%rip), %xmm0
	mulsd	.LC0(%rip), %xmm2
	movsd	%xmm1, (%rcx)
	divsd	%xmm2, %xmm0
	movq	$0x000000000, 16(%rcx)
	movq	$0x000000000, 24(%rcx)
	movsd	%xmm0, 8(%rcx)
	ret
	.seh_endproc
	.globl	_ZN16filter_1st_orderC1Edd
	.def	_ZN16filter_1st_orderC1Edd;	.scl	2;	.type	32;	.endef
	.set	_ZN16filter_1st_orderC1Edd,_ZN16filter_1st_orderC2Edd
	.align 2
	.p2align 4,,15
	.globl	_ZN16filter_1st_order11freq_to_tauEd
	.def	_ZN16filter_1st_order11freq_to_tauEd;	.scl	2;	.type	32;	.endef
	.seh_proc	_ZN16filter_1st_order11freq_to_tauEd
_ZN16filter_1st_order11freq_to_tauEd:
.LFB2810:
	.seh_endprologue
	movsd	.LC1(%rip), %xmm0
	mulsd	.LC0(%rip), %xmm1
	divsd	%xmm1, %xmm0
	ret
	.seh_endproc
	.align 2
	.p2align 4,,15
	.globl	_ZN16filter_1st_order6filterEd
	.def	_ZN16filter_1st_order6filterEd;	.scl	2;	.type	32;	.endef
	.seh_proc	_ZN16filter_1st_order6filterEd
_ZN16filter_1st_order6filterEd:
.LFB2811:
	.seh_endprologue
	movsd	(%rcx), %xmm2
	movsd	24(%rcx), %xmm0
	movapd	%xmm2, %xmm4
	movsd	8(%rcx), %xmm3
	mulsd	%xmm2, %xmm0
	mulsd	%xmm1, %xmm4
	addsd	%xmm3, %xmm3
	movsd	%xmm1, 24(%rcx)
	addsd	%xmm4, %xmm0
	movapd	%xmm2, %xmm4
	subsd	%xmm3, %xmm4
	mulsd	16(%rcx), %xmm4
	addsd	%xmm3, %xmm2
	subsd	%xmm4, %xmm0
	divsd	%xmm2, %xmm0
	movsd	%xmm0, 16(%rcx)
	ret
	.seh_endproc
	.section	.text.startup,"x"
	.p2align 4,,15
	.def	_GLOBAL__sub_I__ZN16filter_1st_orderC2Edd;	.scl	3;	.type	32;	.endef
	.seh_proc	_GLOBAL__sub_I__ZN16filter_1st_orderC2Edd
_GLOBAL__sub_I__ZN16filter_1st_orderC2Edd:
.LFB3311:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	leaq	_ZStL8__ioinit(%rip), %rcx
	call	_ZNSt8ios_base4InitC1Ev
	leaq	__tcf_0(%rip), %rcx
	addq	$40, %rsp
	jmp	atexit
	.seh_endproc
	.section	.ctors,"w"
	.align 8
	.quad	_GLOBAL__sub_I__ZN16filter_1st_orderC2Edd
.lcomm _ZStL8__ioinit,1,1
	.section .rdata,"dr"
	.align 8
.LC0:
	.long	1413754136
	.long	1075388923
	.align 8
.LC1:
	.long	0
	.long	1072693248
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	_ZNSt8ios_base4InitD1Ev;	.scl	2;	.type	32;	.endef
	.def	_ZNSt8ios_base4InitC1Ev;	.scl	2;	.type	32;	.endef
	.def	atexit;	.scl	2;	.type	32;	.endef

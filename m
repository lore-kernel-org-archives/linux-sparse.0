From: Christopher Li <sparse@chrisli.org>
Subject: Bug relate to delete ptr list entry while parent looping on it
Date: Sat, 8 Jul 2017 22:54:18 -0700
Message-ID: <CANeU7QnEnRiaLgYP-cLOgEJD1Hrc3aUMn7MrpjYJoGFjBzKUnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35328 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750836AbdGIFyU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 9 Jul 2017 01:54:20 -0400
Received: by mail-pf0-f195.google.com with SMTP id q85so10097044pfq.2
        for <linux-sparse@vger.kernel.org>; Sat, 08 Jul 2017 22:54:19 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>

Hi Luc,

I make some progress of the ptrlist ref count patch.
A lot of update to make the ref count right.
Most of the case is "return" or "jmp" inside a ptrlist
loop. Another issue I hit is that, if return inside two level
of ptrlist, it need to release both ptr list.

My patch can pass the testsuit without complaining
any more.

When I use it to check the kernel. I found some thing.
Looking from the back trace, I think it is a real bug that
it catch (instead of a false alarm like last one).

The list in question is pseudo->users.
Here is the back trace:

#1  0x000000000042a718 in delete_pseudo_user_list_entry
(list=0x7ffff6fc3318, entry=0x7ffff6f9c6f8, count=1) at simplify.c:175
#2  0x000000000042a914 in remove_usage (p=0x7ffff6fc3310,
usep=0x7ffff6f9c6f8) at simplify.c:189 <=========== level 2
#3  0x000000000042a970 in kill_use (usep=0x7ffff6f9c6f8) at simplify.c:200
#4  0x000000000042ac25 in kill_insn (insn=0x7ffff6f9c6d0, force=0) at
simplify.c:280
#5  0x0000000000429f94 in kill_instruction (insn=0x7ffff6f9c6d0) at flow.h:32
#6  0x000000000042a931 in remove_usage (p=0x7ffff6fc3d60,
usep=0x7ffff6f54978) at simplify.c:191
#7  0x000000000042a970 in kill_use (usep=0x7ffff6f54978) at simplify.c:200
#8  0x000000000042ab63 in kill_insn (insn=0x7ffff6f54950, force=0) at
simplify.c:252
#9  0x0000000000422ff6 in kill_instruction (insn=0x7ffff6f54950) at flow.h:32
#10 0x00000000004249a4 in rewrite_load_instruction
(insn=0x7ffff6f9c990, dominators=0x7ffff6f3a610) at flow.c:451
#11 0x0000000000424dbd in find_dominating_stores
(pseudo=0x7ffff6fc3310, insn=0x7ffff6f9c990, generation=2238, local=1)
at flow.c:531
#12 0x000000000042619d in simplify_one_symbol (ep=0x7ffff74916d0,
sym=0x7ffff2953e70) at flow.c:743  <======= level 1
#13 0x000000000042677a in simplify_symbol_usage (ep=0x7ffff74916d0) at
flow.c:781
#14 0x000000000041fe7a in linearize_fn (sym=0x7ffff29534d0,
base_type=0x7ffff29535b0) at linearize.c:2234
#15 0x000000000041ff6d in linearize_symbol (sym=0x7ffff29534d0) at
linearize.c:2284
#16 0x0000000000401e8a in check_symbols (list=0x7ffff5d23010) at sparse.c:282
#17 0x000000000040202e in main (argc=95, argv=0x7fffffffd1c8) at sparse.c:303


level 1 loop in in symplify_one_symbol,

  FOR_EACH_PTR_REVERSE(pseudo->users, pu) { <======
struct instruction *insn = pu->insn;
if (insn->opcode == OP_LOAD)
all &= find_dominating_stores(pseudo, insn, ++bb_generation, !mod);
} END_FOR_EACH_PTR_REVERSE(pu);

level 2 loop inside
static inline void remove_usage(pseudo_t p, pseudo_t *usep)
{
if (has_use_list(p)) {
delete_pseudo_user_list_entry(&p->users, usep, 1); <======
if (!p->users)
kill_instruction(p->def);
}
}

I am convince this is a real one. This bug is catched by checking the following
linux kernel source file:
drivers/staging/lustre/lustre/ptlrpc/../../lustre/ldlm/ldlm_request.c

The command line to invoke sparse are:

sparse  -nostdinc -isystem
/usr/lib/gcc/x86_64-redhat-linux/6.3.1/include -I./arch/x86/include
-I./arch/x86/include/generated/uapi -I./arch/x86/include/generated
-I./include -I./arch/x86/include/uapi -I./include/uapi
-I./include/generated/uapi -include ./include/linux/kconfig.h
-D__KERNEL__ -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs
-fno-strict-aliasing -fno-common -Werror-implicit-function-declaration
-Wno-format-security -std=gnu89 -fno-PIE -mno-sse -mno-mmx -mno-sse2
-mno-3dnow -mno-avx -m64 -falign-jumps=1 -falign-loops=1 -mno-80387
-mno-fp-ret-in-387 -mpreferred-stack-boundary=3 -mskip-rax-setup
-mtune=generic -mno-red-zone -mcmodel=kernel -funit-at-a-time
-DCONFIG_X86_X32_ABI -DCONFIG_AS_CFI=1 -DCONFIG_AS_CFI_SIGNAL_FRAME=1
-DCONFIG_AS_CFI_SECTIONS=1 -DCONFIG_AS_FXSAVEQ=1 -DCONFIG_AS_SSSE3=1
-DCONFIG_AS_CRC32=1 -DCONFIG_AS_AVX=1 -DCONFIG_AS_AVX2=1
-DCONFIG_AS_AVX512=1 -DCONFIG_AS_SHA1_NI=1 -DCONFIG_AS_SHA256_NI=1
-pipe -Wno-sign-compare -fno-asynchronous-unwind-tables
-fno-delete-null-pointer-checks -Wno-frame-address -O2
--param=allow-store-data-races=0 -DCC_HAVE_ASM_GOTO
-fno-reorder-blocks -fno-ipa-cp-clone -fno-partial-inlining
-fno-stack-protector -Wno-unused-but-set-variable
-Wno-unused-const-variable -fno-omit-frame-pointer
-fno-optimize-sibling-calls -fno-var-tracking-assignments -mfentry
-DCC_USING_FENTRY -fno-inline-functions-called-once
-Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-overflow
-fconserve-stack -Werror=implicit-int -Werror=strict-prototypes
-Werror=date-time -Werror=incompatible-pointer-types
-Werror=designated-init -DMODULE -pg -fsanitize-coverage=trace-pc
-fsanitize=kernel-address -fasan-shadow-offset=0xdffffc0000000000
--param asan-stack=1 --param asan-globals=1 --param
asan-instrumentation-with-call-threshold=0 -DKBUILD_MODNAME='"ptlrpc"'
-DKBUILD_BASENAME='"ldlm_request"'
drivers/staging/lustre/lustre/ptlrpc/../../lustre/ldlm/ldlm_request.c

I am using "allmodconfig" on linux kernel git commit
a090bd4ff8387c409732a8e059fbf264ea0bdd56

I think you are the expert in simplify.c, I can use some help here.

I am looking for simple ways to avoid nested looping delete.
For example, less aggressive on simplify things is fine.
If less aggressive can avoid the delete looping bug, we can cut a release
then go back to fix it properly, resume more aggressive simplify.

The goal is find simple way let sparse pass the full kernel check without die on
the ptr ref count checking patch. Proper fix the ptrlist nested
looping delete might
be too big for this up coming release. Avoid it if we can.

BTW, I am not going to push ptr ref count patch into the 0.5.1 release.
It is just for checking.

Chris

From: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Subject: [PATCH 00/16] More patches.
Date: Fri, 19 Dec 2008 00:51:13 +0300
Message-ID: <20081218181935.28136.60256.stgit@zaytsev.su>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:7446 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771AbYLRVmA (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 18 Dec 2008 16:42:00 -0500
Received: by nf-out-0910.google.com with SMTP id d3so97721nfc.21
        for <linux-sparse@vger.kernel.org>; Thu, 18 Dec 2008 13:41:58 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>

Hello.

Here come patches, that I felt may need some
more discussion before being merged.

Christopher Li (1):
      Add enum member list to the parenta

This one is from Christopher and it does not break
anything => should probably apply. ;)

Josh Triplett (1):
      Expand "dubious !x & y" handling to other combinations of !, &, and |.

This one generates 17 new warnings on a allyesconfig x86_64 kenrnel,
of which 5 point to unintended bitwise or/and usage, but none are bugs:
http://git.zaytsev.su/git?p=linux-2.6.git;a=shortlog;h=dubious-bitwise

And I'm not sure about this one, might actually be a bug:
drivers/net/wireless/ath9k/regd.c:321:7: warning: dubious: x & !y

Anyway, the other 12 warning are bogus, so I'm not sure what should be done.
I'm thinking about some way to anotate such places. And if the warning
filtering would be performed by an external program, we could also annotate
bogus gcc warnings this way. Ideas?

Alexey Zaytsev (5):
      Set gcc include path at runtime.
      Let cgcc pass -gcc-base-dir to sparse.
      Document -gcc-base-dir in sparse.1
      Rename dirafter to idirafter.
      Let void have sizeof 1

The first 4 patches were already sent to the list. They let you
specify the gcc base dir, which is useful for distributions
like Debian, where multiple gcc versions are allowed, and the
one used to build the sparse package may be not installed.

The last patch changes sizeof(void) to 1, same as in gcc.

All theese patches were somehow tested, and cause no
regressions on x86_64 allyesconfig.

Johannes Berg (9):
      Check inlines explicitly
      Show required context in instruction output
      Test conditional result locking
      Ceck context expressions as expressions
      Revert the conditional_context patch
      Evaluate/expand context expressions
      Allow context() attribute on variables
      Add __exact_context__
      Add test for acquire/release

Now this series is a bit more problematic. First, I'm getting
some warnings like this:
Missing code in expression_str for 19

And also:
< fs/afs/proc.c:698:46: warning: context imbalance in 'afs_proc_cell_servers_start': unexpected unlock
< fs/afs/proc.c:698:46:    context 'servers_lock': wanted 1, got 0
< fs/afs/proc.c:721:2: warning: context problem in 'afs_proc_cell_servers_stop': '_read_unlock' expected different context
< fs/afs/proc.c:721:2:    context 'lock': wanted >= 1, got 0
---
> fs/afs/proc.c:690:2: error: expected structure or union
> fs/afs/proc.c:717:2: error: expected structure or union

And:
< drivers/usb/gadget/m66592-udc.c:887:20: warning: context problem in 'irq_packet_read': 'transfer_complete' expected different context
< drivers/usb/gadget/m66592-udc.c:887:20:    context 'lock': wanted >= 1, got 0
< drivers/usb/gadget/m66592-udc.c:951:24: warning: context problem in 'irq_pipe_empty': 'transfer_complete' expected different context
< drivers/usb/gadget/m66592-udc.c:951:24:    context 'lock': wanted >= 1, got 0
< drivers/usb/gadget/m66592-udc.c:1076:14: warning: context problem in 'setup_packet': 'get_status' expected different context
< drivers/usb/gadget/m66592-udc.c:1076:14:    context 'lock': wanted >= 1, got 0
---
> drivers/usb/gadget/m66592-udc.c:703:1: error: undefined identifier 'm66592'
> drivers/usb/gadget/m66592-udc.c:704:1: error: undefined identifier 'm66592'
> drivers/usb/gadget/m66592-udc.c:703:1: error: undefined identifier 'm66592'
> drivers/usb/gadget/m66592-udc.c:704:1: error: undefined identifier 'm66592'
> drivers/usb/gadget/m66592-udc.c:703:1: error: undefined identifier 'm66592'
> drivers/usb/gadget/m66592-udc.c:704:1: error: undefined identifier 'm66592'

And finally, it crashes on
CHECK   net/sched/sch_cbq.c
include/net/sch_generic.h:223:2: warning: unreplaced symbol 'root'
include/net/sch_generic.h:225:2: warning: unreplaced symbol 'break'
include/net/sch_generic.h:225:2: warning: unreplaced symbol 'continue'
include/net/sch_generic.h:189:10: warning: unreplaced symbol 'qdisc'
include/net/sch_generic.h:189:2: warning: unreplaced symbol 'return'
include/net/sch_generic.h:226:19: warning: unreplaced symbol 'qdisc'
include/net/sch_generic.h:226:19: warning: unreplaced symbol 'return'
include/net/sch_generic.h:226:2: warning: unreplaced symbol 'return'
include/net/sch_generic.h:236:2: warning: unreplaced symbol 'qdisc'
include/net/sch_generic.h:236:2: warning: unreplaced symbol 'return'
include/net/sch_generic.h:223:2: warning: unreplaced symbol 'root'
include/net/sch_generic.h:225:2: warning: unreplaced symbol 'break'
include/net/sch_generic.h:225:2: warning: unreplaced symbol 'continue'
include/net/sch_generic.h:189:10: warning: unreplaced symbol 'qdisc'
include/net/sch_generic.h:189:2: warning: unreplaced symbol 'return'
include/net/sch_generic.h:226:19: warning: unreplaced symbol 'qdisc'
include/net/sch_generic.h:226:19: warning: unreplaced symbol 'return'
include/net/sch_generic.h:226:2: warning: unreplaced symbol 'return'
include/net/sch_generic.h:241:2: warning: unreplaced symbol 'qdisc'
include/net/sch_generic.h:241:2: warning: unreplaced symbol 'return'
include/net/sch_generic.h:223:2: warning: unreplaced symbol 'root'
include/net/sch_generic.h:225:2: warning: unreplaced symbol 'break'
include/net/sch_generic.h:225:2: warning: unreplaced symbol 'continue'
include/net/sch_generic.h:189:10: warning: unreplaced symbol 'qdisc'
include/net/sch_generic.h:189:2: warning: unreplaced symbol 'return'
include/net/sch_generic.h:226:19: warning: unreplaced symbol 'qdisc'
include/net/sch_generic.h:226:19: warning: unreplaced symbol 'return'
include/net/sch_generic.h:226:2: warning: unreplaced symbol 'return'
include/net/sch_generic.h:236:2: warning: unreplaced symbol 'qdisc'
include/net/sch_generic.h:236:2: warning: unreplaced symbol 'return'
include/net/sch_generic.h:223:2: warning: unreplaced symbol 'root'
include/net/sch_generic.h:225:2: warning: unreplaced symbol 'break'
include/net/sch_generic.h:225:2: warning: unreplaced symbol 'continue'
include/net/sch_generic.h:189:10: warning: unreplaced symbol 'qdisc'
include/net/sch_generic.h:189:2: warning: unreplaced symbol 'return'
include/net/sch_generic.h:226:19: warning: unreplaced symbol 'qdisc'
include/net/sch_generic.h:226:19: warning: unreplaced symbol 'return'
include/net/sch_generic.h:226:2: warning: unreplaced symbol 'return'
include/net/sch_generic.h:241:2: warning: unreplaced symbol 'qdisc'
include/net/sch_generic.h:241:2: warning: unreplaced symbol 'return'
include/net/sch_generic.h:225:2: warning: label 'continue' already bound
include/net/sch_generic.h:225:2: warning: label 'break' already bound
include/net/sch_generic.h:225:2: warning: label 'continue' already bound
include/net/sch_generic.h:225:2: warning: label 'break' already bound
sparse: simplify.c:82: if_convert_phi: Assertion `br->cond' failed.
/bin/sh: line 1:  1404 Aborted                 sparse -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ -Wbitwise -D__x86_64__ -m64 -nostdinc -isystem /usr/lib/gcc/x86_64-linux-gnu/4.3.2/include -Wp,-MD,net/sched/.sch_cbq.o.d -nostdinc -isystem /usr/lib/gcc/x86_64-linux-gnu/4.3.2/include -D__KERNEL__ -Iinclude -I/home/xl0/work/linux/linux-2.6/arch/x86/include -include include/linux/autoconf.h -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Os -m64 -mtune=generic -mno-red-zone -mcmodel=kernel -funit-at-a-time -maccumulate-outgoing-args -DCONFIG_AS_CFI=1 -DCONFIG_AS_CFI_SIGNAL_FRAME=1 -pipe -Wno-sign-compare -fno-asynchronous-unwind-tables -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -Iarch/x86/include/asm/mach-default -fno-st
 ack-protector -fno-omit-frame-pointer -fno-optimize-sibling-calls -g -pg -Wdeclaration-after-statement -Wno-pointer-sign -D"KBUILD_STR(s)=#s" -D"KBUILD_BASENAME=KBUILD_STR(sch_cbq)" -D"KBUILD_MODNAME=KBUILD_STR(sch_cbq)" -D"DEBUG_HASH=53" -D"DEBUG_HASH2=43" net/sched/sch_cbq.c
make[2]: *** [net/sched/sch_cbq.o] Error 134
make[1]: *** [net/sched] Error 2

So, I'm not sure what should be done about theese.
Johannes, is there any chance you could fix it?

---
 Makefile                              |    7 -
 cgcc                                  |   14 ++
 evaluate.c                            |   40 ++++-
 expand.c                              |    8 +
 expression.c                          |  274 +++++++++++++++++++++++++++++++++
 expression.h                          |    7 +
 ident-list.h                          |    2 
 inline.c                              |   23 ++-
 lib.c                                 |   30 +++-
 linearize.c                           |  165 ++++++++++++++++----
 linearize.h                           |    4 
 parse.c                               |  138 +++++++++--------
 parse.h                               |    8 +
 pre-process.c                         |   98 +++++++++---
 sparse.1                              |   21 +--
 sparse.c                              |  221 +++++++++++----------------
 symbol.c                              |    2 
 symbol.h                              |   13 +-
 validation/context-dynamic.c          |  171 ---------------------
 validation/context-exact.c            |   67 ++++++++
 validation/context-on-vars.c          |  219 ++++++++++++++++++++++++++
 validation/context-statement.c        |    6 -
 validation/context-vars.c             |  192 +++++++++++++++++++++++
 validation/context.c                  |   43 +++++
 validation/dubious-bitwise-with-not.c |   19 ++
 25 files changed, 1322 insertions(+), 470 deletions(-)
 delete mode 100644 validation/context-dynamic.c
 create mode 100644 validation/context-exact.c
 create mode 100644 validation/context-on-vars.c
 create mode 100644 validation/context-vars.c


From: =?ISO-8859-1?Q?Jan_Pokorn=FD?= <pokorny_jan@seznam.cz>
Subject: [PATCH] memops.c: fix load instruction simplification
Date: Fri, 08 Apr 2011 00:16:04 +0200
Message-ID: <4D9E37A4.8040902@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fep32.mx.upcmail.net ([62.179.121.50]:46476 "EHLO
	fep32.mx.upcmail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754565Ab1DGWQm (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 7 Apr 2011 18:16:42 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse@chrisli.org
Cc: linux-sparse@vger.kernel.org

Provided that patch by Nicolas Kaiser (commit 5ecad11 in Chris Li's repo)
is correct (I did some work of comparing resulting code with and without
this change and some unnecessary loads seem to be additionally eliminated
with that change applied [desirable]), another problem has shown up that
the always-true conditional used to mask.

This is an example case*) that is not proceeded correctly:

    static int test(void)
    {
        int x;
        int *px = &x;

        return *px;
    }

Original result:

    <entry-point>
    # symaddr.32 %r1 <- x
    # snop.32   VOID -> 0[px]
    # lnop.32   %r2 <- 0[px]
    # lnop.32   %r3 <- 0[x]
    # phisrc.32 %phi1(return) <- VOID
    # phi.32    %r4 <- VOID
    ret.32      $0

Result with this patch on:

    <entry-point>
    # symaddr.32 %r1 <- x
    # snop.32   VOID -> 0[px]
    # lnop.32   %r2 <- 0[px]
    # lnop.32   %r3 <- 0[x]
    # phisrc.32 %phi1(return) <- VOID
    # phi.32    %r4 <- VOID
    ret.32      x

Originally, I suspected that similar change should be made also
to flow.c (in `find_dominating_stores'), but my experiments made me
believe that this case is right as is -- it starts to do less optimizations
after such edit (encountered, e.g., on tokenize.c with bitfields handling
in `stream_pos').

My effort to check that nothing goes wrong with this patch (comparing against
0a782d3 commit in Chris Li's repo) was following:

1. checking both the warnings and linearized codes**) for C sources
   in linux-2.6.35.12/kernel dir
   - warnings: the same (the same also with Nikola Kaiser's change removed)
   - linearized codes: the same
     (compared with the state without Kaiser's patch, there was a few
      differencies: compat.c, exit.c, mutex-debug.c, sys.c, time.c, tsacct.c;
      these seem to be unnecessary loads as mentioned at the beginning)

2. checking linearized codes of sparse itself -- contrary to 1.,
   this was a bit difficult because sparse generates different in-code
   addresses (at least it did for me) so I had to find out the way
   how to "similarify" them before comparison***)
   - the only change I encountered is a "strange" instructions swap which
     I currently have no explanation for (maybe it is due to some sorting
     involved; the only thing I know is that the order of instructions is
     the same as it is without Nikola Kaiser's change):

        --- orig/sort.c.log 2011-04-07 17:12:47.000000000 +0200
        +++ with_patch/sort.c.log   2011-04-07 17:15:36.000000000 +0200
        @@ -477,8 +477,8 @@ sort.c:152
            # phisrc.32 %phi50(b2) <- %r155(b2)
            # phisrc.32 %phi68(i1) <- %r90(i1)
            # phisrc.32 %phi72(i2) <- %r99(i2)
        -   add.32      %r114(nbuf) <- %r201, $1
            muls.32     %r115 <- %r201, $4
        +   add.32      %r114(nbuf) <- %r201, $1
            add.32      %r116 <- %r115, buffer
            br          %r110, .L0xb76fe764, .L0xb76fec8c

*)  the other thing is that no warning about a use of uninitialized value is
    emitted (neither by library nor by sparse binary); the same applies
    to case when there is plain "int x; return x;"

**) using commands like this:
    $ cd linux-2.6.35.12 && mkdir sparse_out
    $ for i in $(find kernel -name *.c); do make C=1 CHECK=<path to sparse> \
      CF="-ventry -vv > sparse_out/$i.log" $(echo $i | sed "s/\.c/\.o/"); done

***) I wrote a small, stupid and slow Python script for this purpose,
    you can find it at
    https://github.com/jpokorny/thesis/blob/master/cl_sparse/addr_reg_adj
    (if there is an interest, I am not against including it into sparse
    repo, maybe anyone else would use it for smooth linearized code
    comparison, or maybe I am missing something about how to test unwanted
    changes in linearized code?)

Signed-off-by: Jan Pokorny <pokorny_jan@seznam.cz>
---
 memops.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/memops.c b/memops.c
index 45bd340..328edec 100644
--- a/memops.c
+++ b/memops.c
@@ -126,7 +126,7 @@ static void simplify_loads(struct basic_block *bb)
 				if (!dominators) {
 					if (local) {
 						assert(pseudo->type != PSEUDO_ARG);
-						convert_load_instruction(insn, value_pseudo(0));
+						convert_load_instruction(insn, insn->src);
 					}
 					goto next_load;
 				}
-- 
1.7.1

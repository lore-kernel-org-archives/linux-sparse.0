From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/2] Fix cast instruction generation
Date: Thu, 24 Apr 2008 14:52:12 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0804241443460.2779@woody.linux-foundation.org>
References: <20080424193856.14737.16718.stgit@warthog.procyon.org.uk> <alpine.LFD.1.10.0804241248290.2779@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56278 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753355AbYDXVwi (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 24 Apr 2008 17:52:38 -0400
In-Reply-To: <alpine.LFD.1.10.0804241248290.2779@woody.linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-sparse@vger.kernel.org, Josh Triplett <josh@freedesktop.org>



From: Linus Torvalds <torvalds@woody.linux-foundation.org>
Date: Thu, 24 Apr 2008 14:45:43 -0700

Whether it's a sign-extending cast or not depends on the source
of the cast, not destination. The final size of the cast depends
on the destination, of course.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
In thread "[PATCH] RxRPC: Fix a regression in the RXKAD security module"

On Thu, 24 Apr 2008, Linus Torvalds wrote:
> 
> Ok, that looks stupid, and should even have had a warning (shifting a u16 
> right by 16 should warn about it being pointless, but doesn't, because the 
> compiler quietly expands it to "int" in the meantime).
> 
> Hmm. I could do something to sparse that warns about that too. 

Something along the lines of this?

Almost totally untested. This first patch is just preparatory to get the 
next patch working.

 linearize.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/linearize.c b/linearize.c
index 45bb168..ec48dac 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1097,10 +1097,10 @@ static pseudo_t linearize_postop(struct entrypoint *ep, struct expression *expr)
  * case, since you can't access through it anyway without another
  * cast.
  */
-static struct instruction *alloc_cast_instruction(struct symbol *ctype)
+static struct instruction *alloc_cast_instruction(struct symbol *src, struct symbol *ctype)
 {
 	int opcode = OP_CAST;
-	struct symbol *base = ctype;
+	struct symbol *base = src;
 
 	if (base->ctype.modifiers & MOD_SIGNED)
 		opcode = OP_SCAST;
@@ -1127,7 +1127,7 @@ static pseudo_t cast_pseudo(struct entrypoint *ep, pseudo_t src, struct symbol *
 		return VOID;
 	if (from->bit_size < 0 || to->bit_size < 0)
 		return VOID;
-	insn = alloc_cast_instruction(to);
+	insn = alloc_cast_instruction(from, to);
 	result = alloc_pseudo(insn);
 	insn->target = result;
 	insn->orig_type = from;
-- 
1.5.5.1.92.ga5bdc


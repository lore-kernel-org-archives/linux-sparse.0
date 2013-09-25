From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [tip:sched/core 16/27] fs/jbd/commit.c:105:12: sparse: context
 imbalance in 'inverted_lock' - wrong count at exit
Date: Wed, 25 Sep 2013 14:58:05 -0700
Message-ID: <20130925215805.GB7716@jtriplet-mobl1>
References: <52432bed.WfPoNUw4qxmYeQy4%fengguang.wu@intel.com>
 <20130925185925.GD3657@laptop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:50538 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754133Ab3IYV6M (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 25 Sep 2013 17:58:12 -0400
Content-Disposition: inline
In-Reply-To: <20130925185925.GD3657@laptop.programming.kicks-ass.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: kbuild test robot <fengguang.wu@intel.com>, Ingo Molnar <mingo@kernel.org>, kbuild-all@01.org, linux-sparse@vger.kernel.org, sparse@chrisli.org

On Wed, Sep 25, 2013 at 08:59:25PM +0200, Peter Zijlstra wrote:
> On Thu, Sep 26, 2013 at 02:31:09AM +0800, kbuild test robot wrote:
> > tree:   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
> > head:   1a338ac32ca630f67df25b4a16436cccc314e997
> > commit: 0c44c2d0f459cd7e275242b72f500137c4fa834d [16/27] x86: Use asm goto to implement better modify_and_test() functions
> > reproduce: make C=1 CF=-D__CHECK_ENDIAN__
> > 
> > 
> > sparse warnings: (new ones prefixed by >>)
> > 
> > >> drivers/infiniband/hw/qib/qib_verbs.h:1061:36: sparse: crazy programmer

This one, by the way, seems like a sparse internal error, which ought to
have a better message.  The patch below does that; Chris, does this
patch seem reasonable to you?  (The message itself might need accuracy
improvements; it's still pretty vague about what went wrong.)

---8<---
From: Josh Triplett <josh@joshtriplett.org>
Date: Wed, 25 Sep 2013 14:55:44 -0700
Subject: [PATCH] Change "crazy programmer" into a proper internal error message

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---
 ident-list.h | 1 +
 simplify.c   | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/ident-list.h b/ident-list.h
index e93aae7..5f1da5e 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -91,6 +91,7 @@ IDENT(artificial); IDENT(__artificial__);
 IDENT(leaf); IDENT(__leaf__);
 IDENT(vector_size); IDENT(__vector_size__);
 IDENT(error); IDENT(__error__);
+IDENT(cleanup); IDENT(__cleanup__);
 
 
 /* Preprocessor idents.  Direct use of __IDENT avoids mentioning the keyword
diff --git a/simplify.c b/simplify.c
index bda4a5b..2c266f9 100644
--- a/simplify.c
+++ b/simplify.c
@@ -619,7 +619,7 @@ offset:
 		if (new == VOID)
 			return 0;
 		new = VOID;
-		warning(insn->pos, "crazy programmer");
+		sparse_error(insn->pos, "internal error: failed to simplify a memory operation");
 	}
 	insn->offset += off->value;
 	use_pseudo(insn, new, &insn->src);
-- 
1.8.4.rc3


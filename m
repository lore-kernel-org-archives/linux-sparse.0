From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH 16/16] fix handling of integer constant expressions
Date: Wed, 27 Jun 2007 14:18:23 +0100
Message-ID: <20070627131823.GR21478@ftp.linux.org.uk>
References: <20070624183547.GA21478@ftp.linux.org.uk> <alpine.LFD.0.98.0706241203530.3593@woody.linux-foundation.org> <1a25667a20e43a072f733a3ec2b8e79d@kernel.crashing.org> <20070624203837.GE21478@ftp.linux.org.uk> <467F531A.3030702@freedesktop.org> <20070626221040.GI21478@ftp.linux.org.uk> <20070626221134.GA21350@ftp.linux.org.uk> <20070627121021.GQ7590@daikokuya.co.uk> <20070627123031.GO21478@ftp.linux.org.uk> <20070627125958.GA16758@daikokuya.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:44343 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757690AbXF0NS0 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 27 Jun 2007 09:18:26 -0400
Content-Disposition: inline
In-Reply-To: <20070627125958.GA16758@daikokuya.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Neil Booth <neil@daikokuya.co.uk>
Cc: Josh Triplett <josh@freedesktop.org>, Segher Boessenkool <segher@kernel.crashing.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org

On Wed, Jun 27, 2007 at 09:59:58PM +0900, Neil Booth wrote:
> Al Viro wrote:-
> 
> > If you want to test ICE recognition, right now only the following places
> > are checking for it:
> > 	* bitfield width
> > 	* __attribute__((aligned(<number>)))
> > 	* __attribute__((address_space(<number>)))
> > 	* [<index>] in designators within initializer list
> > 	* [<index> ... <index>] - ditto, gccism
> > 
> > That's it.  We can use it elsewhere too, but that's a separate bunch of
> > patches (trivial to do now).
> 
> Bah.  You don't escape that easily :)
> 
> extern int a;
> struct b { unsigned int b1:(1,2); };

Son of a...  expand_comma() cannibalizes the node, should restore ->flags
to 0 (same as other similar suckers).

> struct c { unsigned int c1: 1 ? 2: a++; };

Ditto for expand_conditional, but there we should preserve the original
->flags instead - might be non-zero and we ought to do that after
expanding the taken branch...

From: Al Viro <viro@zeniv.linux.org.uk>
Date: Wed, 27 Jun 2007 09:10:54 -0400
Subject: [PATCH] fix the missed cannibalizing simplifications

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 expand.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/expand.c b/expand.c
index f945518..9a536d5 100644
--- a/expand.c
+++ b/expand.c
@@ -429,8 +429,10 @@ static int expand_comma(struct expression *expr)
 
 	cost = expand_expression(expr->left);
 	cost += expand_expression(expr->right);
-	if (expr->left->type == EXPR_VALUE || expr->left->type == EXPR_FVALUE)
+	if (expr->left->type == EXPR_VALUE || expr->left->type == EXPR_FVALUE) {
 		*expr = *expr->right;
+		expr->flags = 0;
+	}
 	return cost;
 }
 
@@ -488,12 +490,15 @@ static int expand_conditional(struct expression *expr)
 
 	cond_cost = expand_expression(cond);
 	if (cond->type == EXPR_VALUE) {
+		unsigned flags = expr->flags;
 		if (!cond->value)
 			true = false;
 		if (!true)
 			true = cond;
+		cost = expand_expression(*true);
 		*expr = *true;
-		return expand_expression(expr);
+		expr->flags = flags;
+		return cost;
 	}
 
 	cost = expand_expression(true);
-- 
1.5.0-rc2.GIT

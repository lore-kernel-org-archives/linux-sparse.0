From: Kamil Dudka <kdudka@redhat.com>
Subject: Re: linearize bug?
Date: Sat, 27 Aug 2011 18:54:40 +0200
Message-ID: <201108271854.40694.kdudka@redhat.com>
References: <4E588EB8.80808@garzik.org> <4E590F22.6030800@garzik.org> <CA+55aFxGwAXRWVcv_Qx6C4B_PKqzVVbc8O_znwUt_D6g1iDJvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_QFSWOnoXu3Sg1zu"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51250 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751161Ab1H0Q6R (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sat, 27 Aug 2011 12:58:17 -0400
In-Reply-To: <CA+55aFxGwAXRWVcv_Qx6C4B_PKqzVVbc8O_znwUt_D6g1iDJvQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff Garzik <jeff@garzik.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Pekka J Enberg <penberg@cs.helsinki.fi>

--Boundary-00=_QFSWOnoXu3Sg1zu
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday 27 August 2011 17:53:23 Linus Torvalds wrote:
> The attached patch is ENTIRELY UNTESTED. The only thing I tested it on
> is your test-case. Running "make test" requires stuff that I don't
> even have installed, and I'm lazy ;^o

It seems to break loops with no conditions.  The following piece of code:

#include <stdio.h>

int main()
{
    for(;;)
        printf("");
}

... translates into:

main:
.L0x7f233ed67010:
        <entry-point>
        call.32     %r2 <- printf, ""
        ret.32

... which is obviously wrong.  I am not sure if handling that special case 
separately (as done in the attached patch) is a correct way to fix it.

Kamil

--Boundary-00=_QFSWOnoXu3Sg1zu
Content-Type: text/x-diff;
  charset="iso 8859-15";
  name="follow-up.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="follow-up.diff"

 linearize.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/linearize.c b/linearize.c
index 30e0c9d..9e4b6a4 100644
--- a/linearize.c
+++ b/linearize.c
@@ -2055,7 +2055,7 @@ pseudo_t linearize_statement(struct entrypoint *ep, struct statement *stmt)
 		struct statement  *statement = stmt->iterator_statement;
 		struct statement  *post_statement = stmt->iterator_post_statement;
 		struct expression *post_condition = stmt->iterator_post_condition;
-		struct basic_block *loop_top, *loop_body, *loop_continue, *loop_end;
+		struct basic_block *loop_body, *loop_continue, *loop_end;
 
 		concat_symbol_list(stmt->iterator_syms, &ep->syms);
 		linearize_statement(ep, pre_statement);
@@ -2078,9 +2078,12 @@ pseudo_t linearize_statement(struct entrypoint *ep, struct statement *stmt)
 		linearize_statement(ep, post_statement);
 
 		/* No post-condition means that it's the same as the pre-condition */
-		if (!post_condition)
-			linearize_cond_branch(ep, pre_condition, loop_body, loop_end);
-		else
+		if (!post_condition) {
+			if (pre_condition)
+				linearize_cond_branch(ep, pre_condition, loop_body, loop_end);
+			else
+				add_goto(ep, loop_body);
+		} else
 			linearize_cond_branch(ep, post_condition, loop_body, loop_end);
 		set_activeblock(ep, loop_end);
 		break;

--Boundary-00=_QFSWOnoXu3Sg1zu--

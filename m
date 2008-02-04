From: "sylvain nahas" <sylvain.nahas@googlemail.com>
Subject: [PATCH] activate context checking when context input and output values in __attribute__() are the same and different of zero
Date: Mon, 4 Feb 2008 21:42:19 +0100
Message-ID: <b98a45740802041242h35874d1fr563b92a122d30139@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:36000 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756441AbYBDUmX (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 4 Feb 2008 15:42:23 -0500
Received: by nf-out-0910.google.com with SMTP id g13so400029nfb.21
        for <linux-sparse@vger.kernel.org>; Mon, 04 Feb 2008 12:42:19 -0800 (PST)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi,
the following patch activates context checking when context input and
output values are the same and different of zero in
__attribute__((context())), by making the parser generate a OP_CONTEXT
pseudo instruction.

Use case: specify that a function needs to be called in locked context.

Below is a sample case.
---
#define __needlock      __attribute__((context(lock,1,1)))
#define __acquire(x)	__context__(1)
#define __release(x)    __context__(-1)

static int __needlock test1(void)
{
	return 0;
}

static int __needlock test2(void)
{
	return test1(); /* OK */
}

static int test3(void)
{
        return test1(); /* should generate a warning */
}

int main(void)
{
	test1(); /* should generate a warning */
	test2(); /* should generate a warning */
	test3(); /* OK */
	__acquire();
	test1(); /* OK */
	__release();
	return -1;
}
---

I have used it on a relative big bunch of code and I believe it works well.
Thanks,

signed-off-by: Sylvain Nahas <sylvain.nahas@googlemailcom>
---
--- a/linearize.c
+++ b/linearize.c
@@ -1244,6 +1244,12 @@ static pseudo_t
linearize_call_expression(struct entrypoint *ep, struct expressi
                                out = 0;
                        }
                        context_diff = out - in;
+
+                       if( !context_diff && (in>0) ){
+                               check = 1;
+                               context_diff = in;
+                       }
+
                        if (check || context_diff) {
                                insn = alloc_instruction(OP_CONTEXT, 0);
                                insn->increment = context_diff;

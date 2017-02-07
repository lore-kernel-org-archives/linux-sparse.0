From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [RFC/PATCH] arm64: Rename macro arguments to silence sparse
Date: Tue, 7 Feb 2017 02:50:48 +0100
Message-ID: <20170207015047.4ffc3xzrqsuuzo54@macpro.local>
References: <20170207010143.22371-1-sboyd@codeaurora.org>
 <d5bb9d5a-5b02-ffab-d404-bbda532b6c76@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35402 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751606AbdBGBuv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 6 Feb 2017 20:50:51 -0500
Content-Disposition: inline
In-Reply-To: <d5bb9d5a-5b02-ffab-d404-bbda532b6c76@codeaurora.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Christopher Li <sparse@chrisli.org>

On Mon, Feb 06, 2017 at 05:08:17PM -0800, Stephen Boyd wrote:
> On 02/06/2017 05:01 PM, Stephen Boyd wrote:
> > When I compile files with sparse, I get these sorts of warnings:
> >
> > arch/arm64/include/asm/lse.h:14:28: warning: Unknown escape 'l'
> > arch/arm64/include/asm/lse.h:14:37: warning: Unknown escape 'l'
> > arch/arm64/include/asm/alternative.h:172:28: warning: Unknown escape 'o'
> >
> > This is because sparse is trying to tokenize these files and sees
> > a line like this:
> >
> >  alternative_insn "\llsc", "\lse", ARM64_HAS_LSE_ATOMICS
> >
> > It gets past alternative_insn part and then sees the start of a
> > string with the double quote character. So sparse starts to parse
> > the string (eat_string() in the sparse code) but the string has
> > an escape character '\' in it. Sparse sees the escape character,
> > so it checks to see if it's an escape sequence, but '\l' isn't.
> > This causes sparse to spit out this warning of an unknown escape
> > sequence 'l'.
> >
> > In reality, sparse isn't going to use these macros anyway because
> > this whole thing is inside an __ASSEMBLER__ ifdef.

Yes, annoying. Conversion of escaped characters is supposed to be
done just after preprocessing. It's definitively a bug.

Luc


From 786877f6fa5a3b49c92ef08b28c19e58b75ba8e8 Mon Sep 17 00:00:00 2001
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Date: Tue, 7 Feb 2017 02:37:00 +0100
Subject: [PATCH] add testcase for wrong early escape conversion

Reported-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/preprocessor/early-escape.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 validation/preprocessor/early-escape.c

diff --git a/validation/preprocessor/early-escape.c b/validation/preprocessor/early-escape.c
new file mode 100644
index 000000000..c7beba5d8
--- /dev/null
+++ b/validation/preprocessor/early-escape.c
@@ -0,0 +1,23 @@
+#if 0
+"\l"
+#endif
+
+/*
+ * check-description:
+ *	Following the C standard, escape conversion must be
+ *	done in phase 5, just after preprocessing and just
+ *	before string concatenation. So we're not supposed
+ *	to receive a diagnostic for an unknown escape char
+ *	for a token which is excluded by the preprocessor.
+ * check-name: early-escape
+ * check-command: sparse -E $file
+ * check-known-to-fail
+ *
+ * check-output-start
+
+
+ * check-output-end
+ *
+ * check-error-start
+ * check-error-end
+ */
-- 
2.11.0


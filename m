Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD2E286883
	for <linux-sparse@vger.kernel.org>; Sun, 21 Sep 2025 06:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758435228; cv=none; b=EL92r0swsnSzJ//SM1HNFb3On8+KyqCUtr+CHIOh9TT4rs5UQrSb6Gh6HXU1E+3jvNBC5r7mP2tBIvJZfEuEmfW5mNKtgyUL57wRUbofudY+MiBunGLpW6d/wVaKe+C/wLRtq52YRC4PIS0NVtEBm5QAZBEw8glnrYQ1kMxpf3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758435228; c=relaxed/simple;
	bh=WgcD3E5SXyFgrHC+XdnoitxzWNciNbPbH83SKd5NepU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IUOLw8qYsgvsye6x+F8jU0onc/wfpnx3gydNqmT1vSaWUS6rSPJdInfmVpbS1fRuP3aytKe6Uc7WzENeo4cdt9Fe2Qust64eAol8Nkr+6UzUqzRMQX4flr+7acvf2yi92GuxOdO2L2CF74RiZfE1bkfAgn52TQ1XZ1KP8nRJe2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/lTL/iv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/lTL/iv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6AB1C4CEE7;
	Sun, 21 Sep 2025 06:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758435227;
	bh=WgcD3E5SXyFgrHC+XdnoitxzWNciNbPbH83SKd5NepU=;
	h=From:To:Cc:Subject:Date:From;
	b=h/lTL/ivfEt5IzNJnNMnbpyeOAUtfXStvH2VRCHSsB9hMV7EW6niUpnDK6YhpuPAA
	 dlRPdPKM+CTXmP6OVaIfR6eA/QDao4jWieJiRfdEQ0yuduXO2M6JzK2g7hSLQGwgDL
	 BDU18oOkqrmIBy55hKHMyIQr1Y4+KAqYI4p+ZBQuOvZuPC46c6Z12iauit0EGEx8rz
	 hpDtBIFR0a0mw3/JCuUI9fEk4AgZdJQjEprcORN98GdNX75fWxpgxZTwoe0uFE1cWB
	 s1+IkPzvfHr+7wx+78UQH6PiJ4xMD1Y6bt2ZLrW95Fc3DoEHKJTnxVlfxrE2ILpPwc
	 N4cN7dEYbgp4w==
From: Vincent Mailhol <mailhol@kernel.org>
To: linux-sparse@vger.kernel.org,
	Chris Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincent Mailhol <mailhol@kernel.org>
Subject: [PATCH] Warn about "unsigned value that used to be signed against zero"
Date: Sun, 21 Sep 2025 15:12:30 +0900
Message-ID: <20250921061337.3047616-1-mailhol@kernel.org>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5334; i=mailhol@kernel.org; h=from:subject; bh=WgcD3E5SXyFgrHC+XdnoitxzWNciNbPbH83SKd5NepU=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDBnnp9tnXjfqPymm3yotpyk0L+ROwmROs9Veq5POsz1NF bpQ1e/ZUcrCIMbFICumyLKsnJNboaPQO+zQX0uYOaxMIEMYuDgFYCI7dzD80zf8+t1+vu6GtkWc /X2LWo93TzXQ/f7kYIflx8Z3S3RsEhgZWqyk4hnuOTy29mxNecCXo3yEw9dVZHbFhY+OL774nDn OBwA=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

Consider this first pattern:

  void error(void);
  int check(void);

  void foo (void)
  {
  	unsigned int ret;

  	ret = check();
  	if (ret < 0)
  		error();
  }

Here, the comparison against zero is a tautology: ret, which is
unsigned, can never be negative. Thus the compiler will remove the
error branch causing a bug.

This pattern is caught by clang and gcc's -Wtype-limits. *However*,
that diagnostic has many lost bullets. It will also complain on some
legitimate things such as in this second pattern:

  void error(void);

  void bar (unsigned int val)
  {
  	if (val < 0 || val > 42)
  		error();
  }

Here, the author just want to do a range check. Yes, the

  val < 0

comparison is a tautology, but that time, it does not result in faulty
code when optimised out by the compiler.

There is thus a need for a check that will catch the first pattern but
that will let the second one go through. The difference between the
two patterns is that in the first one the value returned by the
check() function used to be signed whereas in the second one val was
always unsigned to begin with.

Add a check in sparse to warn if a value which used to be signed gets
assigned to an unsigned and then gets compared against zero, either
val < 0 or val >= 0.

As pointed out by Linus in his original message, a few false positives
remain, especially when many inline functions and macros get involved,
but the level of noise is nothing in comparison to the -Wtype-limits.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/all/CAHk-=wjQCbRA1UEag-1-9yn08KNNqerTj++SCbbW80At=rg5RQ@mail.gmail.com/
Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
Hi Chris,

I saw your email in which you announced your comeback. First of all,
I wish you a warm welcome back!

Second, I would like to inaugurate your comeback with this patch. It
was posted by Linus in the middle of the huge thread about the Rust
kernel policy, so I guess it did not catch the attention it
deserved. I have been using this locally for the last half year and it
works fine.

So, aside from a minor change as listed in below Changelog, this is
basically a resend.

As for the tags, I tagged Linus as Suggested-by and myself as the
author. Not sure if this is the most appropriate tag, but adding
Linus's Signed-off tag seems wrong, so this is the best tag I could
think of. Let me know if there is any more appropriate tag.

Changelog:

Linus's patch -> v2:

  - Add a patch description

  - Change warning message from

      unsigned value that used to be signed checked for negative?

    to

      unsigned value that used to be signed checked against zero?

    because the check catches both unsigned < 0 and unsigned >= 0
    tautologies.

Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/sparse.git/commit/?id=46ee49478660
Link: https://lore.kernel.org/all/CAHk-=wjQCbRA1UEag-1-9yn08KNNqerTj++SCbbW80At=rg5RQ@mail.gmail.com/
---
 simplify.c | 41 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/simplify.c b/simplify.c
index 3c4ace3c..68c5f9c7 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1167,6 +1167,43 @@ static int simplify_seteq_setne(struct instruction *insn, long long value)
 	return 0;
 }
 
+static struct instruction *used_to_be_signed(struct instruction *insn)
+{
+	pseudo_t pseudo = insn->src1;
+	struct instruction *def;
+	struct symbol *sym;
+
+	if (pseudo->type != PSEUDO_REG)
+		return NULL;
+	def = pseudo->def;
+	if (!def)
+		return NULL;
+
+	// Did the value come from a sign-extension?
+	// If so, the source was clearly signed
+	if (def->opcode == OP_SEXT)
+		return def;
+
+	// Or was the op that generated the value signed?
+	sym = def->type;
+	if (sym && !(sym->ctype.modifiers & MOD_UNSIGNED))
+		return def;
+
+	return NULL;
+}
+
+static int simplify_unsigned_zero_compare(struct instruction *insn, int result)
+{
+	struct instruction *def = used_to_be_signed(insn);
+
+	if (def) {
+		warning(insn->pos, "unsigned value that used to be signed checked against zero?");
+		info(def->pos, "signed value source");
+	}
+
+	return replace_with_pseudo(insn, value_pseudo(result));
+}
+
 static int simplify_compare_constant(struct instruction *insn, long long value)
 {
 	unsigned size = insn->itype->bit_size;
@@ -1228,7 +1265,7 @@ static int simplify_compare_constant(struct instruction *insn, long long value)
 
 	case OP_SET_B:
 		if (!value)			// (x < 0) --> 0
-			return replace_with_pseudo(insn, value_pseudo(0));
+			return simplify_unsigned_zero_compare(insn, 0);
 		if (value == 1)			// (x < 1) --> (x == 0)
 			return replace_binop_value(insn, OP_SET_EQ, 0);
 		else if (value == bits)		// (x < ~0) --> (x != ~0)
@@ -1238,7 +1275,7 @@ static int simplify_compare_constant(struct instruction *insn, long long value)
 		break;
 	case OP_SET_AE:
 		if (!value)			// (x >= 0) --> 1
-			return replace_with_pseudo(insn, value_pseudo(1));
+			return simplify_unsigned_zero_compare(insn, 1);
 		if (value == 1)			// (x >= 1) --> (x != 0)
 			return replace_binop_value(insn, OP_SET_NE, 0);
 		else if (value == bits)		// (x >= ~0) --> (x == ~0)
-- 
2.49.1


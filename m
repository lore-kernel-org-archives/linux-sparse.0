Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3107BC2BB9A
	for <linux-sparse@archiver.kernel.org>; Wed, 16 Dec 2020 22:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0AAB235FD
	for <linux-sparse@archiver.kernel.org>; Wed, 16 Dec 2020 22:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbgLPWZm (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 16 Dec 2020 17:25:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730175AbgLPWZm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Dec 2020 17:25:42 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51EDC061794
        for <linux-sparse@vger.kernel.org>; Wed, 16 Dec 2020 14:25:01 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id t16so24662725wra.3
        for <linux-sparse@vger.kernel.org>; Wed, 16 Dec 2020 14:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8SV33IJyVlsuRasBWKWNg8V9ZIvVjNaPBLAUF8xm82s=;
        b=kqyerSbDprwlORvBX8vRRdE/Bp2lCVj/5Blt04jUngJp1rmCYvzcQvrJ07a1iG/6QL
         Aq4D3+nX1wXCTFeumu4a5KhvhkbX0UdCQ/MoIXADblAnE6LDlD9UfclfeTkhJZfIT9Zy
         vylXNLxd2XIB36fBQB7m9mya5QjImQF8S3F2ZToHQo6QhZhaf0bC95kVNAkbad0xqHUK
         7tLFfMDWWHyThiXprPnehKXffBDZKee5eKD+++UwIiAOCIOHTwcZwCCXojh5clGkijLd
         oK2Ml9CAUJhZqMhMe3VUpDIh2I0H5u/NyHAxWt3iw4r0z6CxXJBk2ENLWGVrjnDh4k+C
         zsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8SV33IJyVlsuRasBWKWNg8V9ZIvVjNaPBLAUF8xm82s=;
        b=B0h7yvCUqdhKELOWae9nAH3ykwtjKsrQeQqdhUfEir/152ClLRILxjSoWl+wnbh3L0
         DqtfsHivYfkDvE11ZyIonPYw3uxl5kfD0X/abZI6EtOF5Mjshfl0vUaqnoVMds6Qkcp0
         t9iV0BFFtnPmI95Y+uNcJdSUU8I3d2ubGjd2RguOc1qGxY7jJvW60de3ZxdEob5cD2fd
         iaR3j1XPbY+Pv8XAI0Gt0bNyYNAPLrVS56Ils7+Dp2a84+JD8+InX2LCd7NJRSWyl5uD
         t4Karg1zpn+8FIS6HpcM7dx1nzhp7fRu5xOxbwNLft4QVynENBoLjyfrFh8eewqHT0En
         Rvqw==
X-Gm-Message-State: AOAM532emvqvVtak67qUIaR/T9t8NpRvYVoFq8ZmmYyy2unSf2pau7M2
        xJFMuufkP2ySRbFx2Li988A=
X-Google-Smtp-Source: ABdhPJybdozLCABiLl5rBhHtAHO6qCSeDPnPGnm3c7CKAyEnB2cTGurqenNqvI8jmYc129ma8qU7WA==
X-Received: by 2002:adf:902d:: with SMTP id h42mr39468917wrh.175.1608157500574;
        Wed, 16 Dec 2020 14:25:00 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:30ac:ec9a:2892:f5b7])
        by smtp.gmail.com with ESMTPSA id j9sm5129817wrm.14.2020.12.16.14.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 14:24:59 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-sparse@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] warn when zero-extending a negation
Date:   Wed, 16 Dec 2020 23:24:48 +0100
Message-Id: <20201216222448.2054-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <CAHk-=wjiC6UejP6xob9BMQy98O6OLGDhy-qDfaFcOJxo90iOFg@mail.gmail.com>
References: <CAHk-=wjiC6UejP6xob9BMQy98O6OLGDhy-qDfaFcOJxo90iOFg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

When an unsigned value is negated (logical or arithmetical) and
then converted to a wider type, this value will be zero-extended,
not sign-extended. In other words, upper bits won't be negated.

This may be the intention but may also be a source of errors.

So, add a warning for this. Also, because this warning may be too
noise because most catches will possibly be false-positives, add a
specific warning flag to disable it: -Wno-zero-extend-negation.

Link: https://lore.kernel.org/r/CAHk-=wjiC6UejP6xob9BMQy98O6OLGDhy-qDfaFcOJxo90iOFg@mail.gmail.com
Originally-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---

On my usual test setup (defconfig + allyesconfig) this gives 199 warnings.
I only checked a couple of them, they we're false positives but somehow
error-prone if some definitions are changed. For example:
* struct super_block::s_flags is defined as 'unsigned long', all flags
  are hold in 32-bits but struct fs_context::sb_flags_mask is defined
  as 'unsigned int'.
* struct inode::i_stat is defined as 'unsigned long', all I_* are defined
  as (signed) 'int' but some code do 'unsigned dirty = I_DIRTY;'

For the moment, I've left the warning enabled by default but it should
probably only be enabled at W=1.


@Linus,

I suppose that it is fine for you that I your SoB instead of the
'Originally-by' I used here?

-- Luc


 linearize.c | 25 +++++++++++++++++++++++++
 options.c   |  2 ++
 options.h   |  1 +
 sparse.1    |  8 ++++++++
 4 files changed, 36 insertions(+)

diff --git a/linearize.c b/linearize.c
index 0250c6bb17ef..b9faac78ebb7 100644
--- a/linearize.c
+++ b/linearize.c
@@ -2520,6 +2520,27 @@ static void check_tainted_insn(struct instruction *insn)
 	}
 }
 
+static void check_zero_extend(struct instruction *insn)
+{
+	struct instruction *def;
+	pseudo_t src = insn->src1;
+
+	if (!Wzero_extend_negation)
+		return;
+	if (src->type != PSEUDO_REG)
+		return;
+	def = src->def;
+	if (!def)
+		return;
+	switch (def->opcode) {
+	case OP_NEG: case OP_NOT:
+		warning(insn->pos, "zero-extending a negation - upper bits not negated");
+		break;
+	default:
+		break;
+	}
+}
+
 ///
 // issue warnings after all possible DCE
 static void late_warnings(struct entrypoint *ep)
@@ -2537,6 +2558,10 @@ static void late_warnings(struct entrypoint *ep)
 				// Check for illegal offsets.
 				check_access(insn);
 				break;
+			case OP_ZEXT:
+				// Check for missing sign extension..
+				check_zero_extend(insn);
+				break;
 			}
 		} END_FOR_EACH_PTR(insn);
 	} END_FOR_EACH_PTR(bb);
diff --git a/options.c b/options.c
index 17da5f367e24..5323ddc05861 100644
--- a/options.c
+++ b/options.c
@@ -139,6 +139,7 @@ int Wunion_cast = 0;
 int Wuniversal_initializer = 0;
 int Wunknown_attribute = 0;
 int Wvla = 1;
+int Wzero_extend_negation = 1;
 
 ////////////////////////////////////////////////////////////////////////////////
 // Helpers for option parsing
@@ -884,6 +885,7 @@ static const struct flag warnings[] = {
 	{ "universal-initializer", &Wuniversal_initializer },
 	{ "unknown-attribute", &Wunknown_attribute },
 	{ "vla", &Wvla },
+	{ "zero-extend-negation", &Wzero_extend_negation },
 	{ }
 };
 
diff --git a/options.h b/options.h
index 0aec8764d27d..3403c9518ead 100644
--- a/options.h
+++ b/options.h
@@ -138,6 +138,7 @@ extern int Wunion_cast;
 extern int Wuniversal_initializer;
 extern int Wunknown_attribute;
 extern int Wvla;
+extern int Wzero_extend_negation;
 
 extern char **handle_switch(char *arg, char **next);
 extern void handle_switch_finalize(void);
diff --git a/sparse.1 b/sparse.1
index 430b3710b260..928e3513b9b6 100644
--- a/sparse.1
+++ b/sparse.1
@@ -494,6 +494,14 @@ Warn on casts to union types.
 
 Sparse does not issues these warnings by default.
 .
+.TP
+.B -Wzero-extend-negation
+Warn when an unsigned value is first negated (logical or arithmetical)
+and then converted to a wider type.
+
+Sparse issues these warnings by default.
+To turn them off, use \fB-Wno-zero-extend-negation\fR.
+.
 .SH MISC OPTIONS
 .TP
 .B \-\-arch=\fIARCH\fR
-- 
2.29.2


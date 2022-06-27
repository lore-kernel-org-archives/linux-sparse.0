Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3600BC433EF
	for <linux-sparse@archiver.kernel.org>; Mon, 27 Jun 2022 19:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbiF0TFw (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 27 Jun 2022 15:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbiF0TFv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Jun 2022 15:05:51 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370BF25C7
        for <linux-sparse@vger.kernel.org>; Mon, 27 Jun 2022 12:05:50 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ge10so21109930ejb.7
        for <linux-sparse@vger.kernel.org>; Mon, 27 Jun 2022 12:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9k6J9hkLR2Zl8PfPRX09C48/fSb3eQ2WsroE1G/XK7Y=;
        b=jdI//FTt0jH+kOdIJwHvTUxGnhaaFPRnJDgOsxfWrglGGsLc4AlWyQA6+c0wBdrDf7
         FTGaNJXMgjGStLwvScFEsHz1u3JLWzuSS/uZARTFX/Iu/nAlZkh/rrlZIFCZJzlZENFW
         jVWGvxjvLzjXMtmRSBOup+ztDXJ5dW6FrWGyY23INgqXABgHtgVuXlq3PgM03r9L1u5p
         MpgiTbboKQu4B5w/a15aaOYIdlnEWK4OCiVoWS1RT36AJDivz2Hl17eHPGuO1oOK5WT4
         DA0EtvogtugqwLq4F+fucLWsbZ8LXLOQKTY0tJaRJ7FlGXmquO2MpB02SyPUhYsU9rJ3
         d1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9k6J9hkLR2Zl8PfPRX09C48/fSb3eQ2WsroE1G/XK7Y=;
        b=27N2gOfPMAJijgDtUrV0F6xsdZo36iMQb25KQPf4J1te24+d5SOY8GkK/bSK2Qewtq
         wAivrYRzdsBEC5ZhDCXln7WrTTmZJ3/62Hvpw9rDNdGt6sc/wKwL91w6GsuIBBTw1iJe
         lQTt64S64qaP7BLO0DG4xJr42TRaAKbd2fC8HnCdhVr7y0I0s+bO8gVtKmHA32r6HO6B
         dWkP4npFe1BVwl1OYp+DUmOBEzQ7y2n+n2eLKR13iOrHv3L25E/sugADJ9q53btnMsSi
         pkGMy4vBSya1s5VhKx4eyX2ydXJxClYIAQYFVvJ6N/wl2b97kRCUnK7erSx7NaNALblC
         /K7Q==
X-Gm-Message-State: AJIora8NvH9EmDN2cSDKlzuFaC6Yr/aC9JL/9fMymaJSllQZWjmMgBpe
        DAoJOBFEnig19IM+90Pt7Fv49sjlgT0=
X-Google-Smtp-Source: AGRyM1vYdAWa551Xa0odmRlBr78NGQ0cVWKRrUEztGHM3n3MzfV4SqcAthfqliU5wt6RtyRL1AofcQ==
X-Received: by 2002:a17:906:79ca:b0:705:111f:12dc with SMTP id m10-20020a17090679ca00b00705111f12dcmr13794757ejo.602.1656356748759;
        Mon, 27 Jun 2022 12:05:48 -0700 (PDT)
Received: from localhost.localdomain (239.125-180-91.adsl-dyn.isp.belgacom.be. [91.180.125.239])
        by smtp.gmail.com with ESMTPSA id p24-20020a170906615800b00709343c0017sm5456776ejl.98.2022.06.27.12.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 12:05:48 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/5] bitwise: add testcases
Date:   Mon, 27 Jun 2022 21:05:36 +0200
Message-Id: <20220627190540.13358-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220627190540.13358-1-luc.vanoostenryck@gmail.com>
References: <CAHk-=wj8gM8q04v2jS5JGjEdoE2d+B4_nm74xrFjZ77f9YRsbA@mail.gmail.com>
 <20220627190540.13358-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Currently bitwise types only support bitwise operations
(&, |, ^ and ~) and the constant 0 (since this value is
invariant for all bitwise operations and endianness conversion).

But the incoming series will relax this a little bit.
So, add a few testcases for it.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/bitwise-cmp.c         | 32 ++++++++++++++++++++++++++++++++
 validation/bitwise-is-signed.c   | 22 ++++++++++++++++++++++
 validation/linear/bitwise-cmps.c | 18 ++++++++++++++++++
 validation/linear/bitwise-cmpu.c | 18 ++++++++++++++++++
 4 files changed, 90 insertions(+)
 create mode 100644 validation/bitwise-cmp.c
 create mode 100644 validation/bitwise-is-signed.c
 create mode 100644 validation/linear/bitwise-cmps.c
 create mode 100644 validation/linear/bitwise-cmpu.c

diff --git a/validation/bitwise-cmp.c b/validation/bitwise-cmp.c
new file mode 100644
index 000000000000..ca12b5e51e8e
--- /dev/null
+++ b/validation/bitwise-cmp.c
@@ -0,0 +1,32 @@
+#define M 0xffffffff
+
+typedef int __attribute__((bitwise)) b32;
+
+static int eq0(b32 x, b32 y)  { return (x == 0); }
+static int eqm(b32 x, b32 y)  { return (x == M); }
+static int eqx(b32 x, b32 y)  { return (x == y); }
+
+static int ne0(b32 x, b32 y)  { return (x != 0); }
+static int nem(b32 x, b32 y)  { return (x != M); }
+static int nex(b32 x, b32 y)  { return (x != y); }
+
+static int lt0(b32 x, b32 y)  { return (x <  0); }
+static int ltm(b32 x, b32 y)  { return (x <  M); }
+static int ltx(b32 x, b32 y)  { return (x <  y); }
+
+static int lte0(b32 x, b32 y) { return (x <= 0); }
+static int ltem(b32 x, b32 y) { return (x <= M); }
+static int ltex(b32 x, b32 y) { return (x <= y); }
+
+static int gte0(b32 x, b32 y) { return (x >= 0); }
+static int gtem(b32 x, b32 y) { return (x >= M); }
+static int gtex(b32 x, b32 y) { return (x >= y); }
+
+static int gt0(b32 x, b32 y)  { return (x >  0); }
+static int gtm(b32 x, b32 y)  { return (x >  M); }
+static int gtx(b32 x, b32 y)  { return (x >  y); }
+
+/*
+ * check-name: bitwise-cmp
+ * check-known-to-fail
+ */
diff --git a/validation/bitwise-is-signed.c b/validation/bitwise-is-signed.c
new file mode 100644
index 000000000000..dd9c147173cd
--- /dev/null
+++ b/validation/bitwise-is-signed.c
@@ -0,0 +1,22 @@
+#define __bitwise __attribute__((bitwise))
+
+#define is_signed_type(type)  (((type)-1) <= 0)
+
+typedef   signed int __bitwise s;
+typedef unsigned int __bitwise u;
+
+int fos(void);
+int fou(void);
+
+
+int fos(void) { return  is_signed_type(s); }
+int fou(void) { return !is_signed_type(u); }
+
+/*
+ * check-name: bitwise-is-signed
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
diff --git a/validation/linear/bitwise-cmps.c b/validation/linear/bitwise-cmps.c
new file mode 100644
index 000000000000..6122944a42c6
--- /dev/null
+++ b/validation/linear/bitwise-cmps.c
@@ -0,0 +1,18 @@
+typedef   signed int __attribute__((bitwise)) bs32;
+
+static int ltu(bs32 x, bs32 y)  { return (x <  y); }
+static int lteu(bs32 x, bs32 y) { return (x <= y); }
+static int gteu(bs32 x, bs32 y) { return (x >= y); }
+static int gtu(bs32 x, bs32 y)  { return (x >  y); }
+
+/*
+ * check-name: bitwise-cmps
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-excludes: setb\\.
+ * check-output-excludes: setbe\\.
+ * check-output-excludes: setae\\.
+ * check-output-excludes: seta\\.
+ */
diff --git a/validation/linear/bitwise-cmpu.c b/validation/linear/bitwise-cmpu.c
new file mode 100644
index 000000000000..8932436a7764
--- /dev/null
+++ b/validation/linear/bitwise-cmpu.c
@@ -0,0 +1,18 @@
+typedef unsigned int __attribute__((bitwise)) bu32;
+
+static int ltu(bu32 x, bu32 y)  { return (x <  y); }
+static int lteu(bu32 x, bu32 y) { return (x <= y); }
+static int gteu(bu32 x, bu32 y) { return (x >= y); }
+static int gtu(bu32 x, bu32 y)  { return (x >  y); }
+
+/*
+ * check-name: bitwise-cmpu
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-excludes: setlt\\.
+ * check-output-excludes: setlte\\.
+ * check-output-excludes: setgte\\.
+ * check-output-excludes: setgt\\.
+ */
-- 
2.36.1


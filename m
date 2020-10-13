Return-Path: <SRS0=XrIr=DV=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851D5C433E7
	for <linux-sparse@archiver.kernel.org>; Wed, 14 Oct 2020 09:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DEC4206DD
	for <linux-sparse@archiver.kernel.org>; Wed, 14 Oct 2020 09:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IweAzX9m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730257AbgJNJXG (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 14 Oct 2020 05:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731219AbgJNJWy (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 14 Oct 2020 05:22:54 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0BEC0613B9
        for <linux-sparse@vger.kernel.org>; Tue, 13 Oct 2020 15:16:40 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id c22so2035532ejx.0
        for <linux-sparse@vger.kernel.org>; Tue, 13 Oct 2020 15:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZXP8KGBq3TnsOhyvBmE8YVLJhxM4G+TmkIEo8IsEkpA=;
        b=IweAzX9mrcrY4mU7ZfzkGAQhT8POg8n9S0Qi+6aeykDsHKYvt0BdDj5TuUNKSu9JjI
         m00Ys23Wa4EODAnUEDXlV/dYqauG/XqkU6waEsUXvKR3bEyLakEJr6czkPQbbZg9RGQX
         BcrAA0OnGgEMsnNFxOmVnLzm4yYbZ1sMiMh199XzFaff0mjUUz+ayoqIU2fvFSD+95FT
         sbQ6NohWCRXmDEMFNKlnwsw1OHnaBnMFSyXkzX2I6GmHONqDly2LOi4gaAiu+jIz35Jo
         jgW6YvY9vRIRFrms53Bl/3imgQgc9AIOmJWXgToGo4KxBLPiVtO2uEti6IoUWPvuUECd
         q7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZXP8KGBq3TnsOhyvBmE8YVLJhxM4G+TmkIEo8IsEkpA=;
        b=jBdUo+7mD2cK0she6g5ACQTq6BYHxT3Dk1hCmwbavAWmcYwKF/c9aFGUWO1zx05HPG
         2o/XzakG9Dg1KBRhIqU8dBBHSyRCz9CzgMmBTz/wfX8LakuqPqqQci/kK7brT6Tx1Tek
         CQNTSme53z/QD+rxYv3Yr/UgBZ60YCrrO0bdkc6qnDVFeQpTBItTeH3vVZDxa2AwsL12
         kmAf4AX60n7zmUvH76YiF2eXrib0umTUIbMQUffOlT1OAZikW/ngGjacf0RUf3aBQm7d
         fAfLsjiKC+hi8AOVZRxIy3gCQcIKpF1puK/A2LT1+RJvkzjQUzJmHLpp91BihA1T1+Wr
         9ZUA==
X-Gm-Message-State: AOAM532IeqbZYxttB0Ysc6MVsqlZ0hLIZxnQoRxXzxO4Pi6Er0vLWBa6
        u9YjAiTWVzkmQ4T5IwVYjy5/mwvAyLA=
X-Google-Smtp-Source: ABdhPJzOglFX2tyzxrc1SIVCrFYb9Qa9UgtefwGXSj8d+AEMs2rndCXVgOY7PR4YtNLjJ2R/jEcuoQ==
X-Received: by 2002:a17:906:3541:: with SMTP id s1mr2053701eja.413.1602627399082;
        Tue, 13 Oct 2020 15:16:39 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:5515:f93d:cc48:6a5f])
        by smtp.gmail.com with ESMTPSA id o11sm596087ejd.60.2020.10.13.15.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 15:16:38 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] update TODOs
Date:   Wed, 14 Oct 2020 00:16:36 +0200
Message-Id: <20201013221636.7664-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

A few things are now done: remove them from the TODO.
A few things need to be done: add them to the TODO.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/TODO.md | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/Documentation/TODO.md b/Documentation/TODO.md
index e2043e481f99..4dc9e63ab207 100644
--- a/Documentation/TODO.md
+++ b/Documentation/TODO.md
@@ -4,13 +4,13 @@ TODO
 Essential
 ---------
 * SSA is broken by simplify_loads() & branches rewriting/simplification
-* attributes of struct, union & enums are ignored (and possibly in other
-  cases too).
-* add support for bitwise enums
+* attributes of struct, union & enums are ignored (and maybe others too).
+  This requires correct support for __packed which itself needs partial
+  and unaligned loads & stores (wip)
+* add support for bitwise enums (wip)
 
 Documentation
 -------------
-* document the extensions
 * document the API
 * document the limitations of modifying ptrlists during list walking
 * document the data structures
@@ -27,7 +27,7 @@ Core
 
 Testsuite
 ---------
-* there are more than 50 failing tests. They should be fixed
+* there are 60 failing tests. They should be fixed
   (but most are non-trivial to fix).
 
 Misc
@@ -36,15 +36,26 @@ Misc
 * parse __attribute_((fallthrough))
 * add support for format(printf())  (WIP by Ben Dooks)
 * make use of UNDEFs (issues warnings, simplification, ... ?)
-* add a pass to inline small functions during simplification.
+* make memory accesses more explicit: add EXPR_ACCESS (wip)
+* it would be nice to do our own parsing of floating point (wip)
+* some header files needed for crypto/ need __vector or __fp16
+* some even need __complex
 
 Optimization
 ------------
+* a lot of small simplifications are waiting to be upstreamed
+* the domtree need to be rebuilt (or updated)
+* critical edges need to be split
 * the current way of doing CSE uses a lot of time
 * add SSA based DCE
 * add SSA based PRE
 * Add SSA based SCCP
+* add a pass to inline small functions during simplification.
 * use better/more systematic use of internal verification framework
+* tracking of operands size should be improved (WIP)
+* OP_INLINE is sometimes in the way
+* would be nice to strictly separate phases that don't changes the
+  CFG and thus the dominance tree.
 
 IR
 --
@@ -60,13 +71,15 @@ LLVM
 
 Internal backends
 -----------------
-* add some basic register allocation
+* it would be nice the upstream the code generator
 * add a pass to transform 3-addresses code to 2-addresses
+* add some basic register allocation
+* add a pass to order the BBs and changes 2-ways CBR into one-way branches
 * what can be done for x86?
+* add support to add constraints in the MD rules
 
 Longer term/to investigate
 --------------------------
-* better architecture handling than current machine.h + target.c
 * attributes are represented as ctypes's alignment, modifiers & contexts
   but plenty of attributes doesn't fit, for example they need arguments.
   * format(printf, ...),
-- 
2.28.0


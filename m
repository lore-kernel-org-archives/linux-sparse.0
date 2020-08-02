Return-Path: <SRS0=4hY4=BM=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C134C433E0
	for <linux-sparse@archiver.kernel.org>; Sun,  2 Aug 2020 22:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 558272087C
	for <linux-sparse@archiver.kernel.org>; Sun,  2 Aug 2020 22:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJjoB/xv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgHBWPL (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 2 Aug 2020 18:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbgHBWPK (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 2 Aug 2020 18:15:10 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A4DC06174A
        for <linux-sparse@vger.kernel.org>; Sun,  2 Aug 2020 15:15:10 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id i6so279345edy.5
        for <linux-sparse@vger.kernel.org>; Sun, 02 Aug 2020 15:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3fwO3WopG+X3ZUeUmylDbM6UGnQzGKTG8i+6ZND/CE4=;
        b=ZJjoB/xvUllgNqZR8970TIM+/nAqxodKPMSsBMEF+GRgivKn5jCsyBwP7KWmn6g6Dk
         +nGThwPP3FpiPtTi4hKctTzf7AuOZ+UgV5D1dm3DiBgcDAQbWFG2/bIChmn+YaRV3kyz
         KPd7ARCb6ZKKfNTDNvW3hcrAMIjhTSDHU1RFRVvUdgNSj+niNbool7Y14O2WK3E5rGp+
         K09sWAfT+aKRQL21gbks9Csli06djmCopNHbIswYwgkc3iWVPMtJEezOcFkf484sn39m
         ccQiSEvjGPF/17xk9qZ9vnU889CfWzNXbbqmrs0+bbTIwgbo/C1rTotqMFVfzbM65Wqn
         FhNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3fwO3WopG+X3ZUeUmylDbM6UGnQzGKTG8i+6ZND/CE4=;
        b=GL6jBg21VG+lk72IEEJwyscY8K98SA1oUumLpRRJZUqCFroynry87BrVs/BgjMrtRB
         5JNcwUBAB025lwxKOvI0fxbDntWJ9dEV3wW92/4c811LjKduYsaSp4UIe8S6UMvvuEbl
         TFsgHIbnczvaYcGQy9iqxRABeurTzOPxYP0+VszqBxb81NTr9AB+qGpVC7/biGrpt/Wf
         N0E3uJBDuJ4uO4o0ze9PN4qvofC5vtU3JMPFJLhQxsiiGVO3/4kfCpsX5Z5togfopGMc
         D2P3Iiojo7rP8w1P99rwtGckmtFCxgNnnCDw9w4dMQRfq584+18ogh2fuTkm4OeRapKy
         w5SA==
X-Gm-Message-State: AOAM532+Ci8XRbJ4l5Id7Nfm+L/csrrot6qdwK7+sN2xOnU2ZnE3ef0f
        WvR+EDoDiZWSXkaMg0Khvkka03Q2
X-Google-Smtp-Source: ABdhPJwpOcIC2J0cIyJV5C9coInJropXJpJXoZl0Xh2GQit999s9sO+QcCYn3tcUDZKEYJoO2A+LIA==
X-Received: by 2002:a50:d80f:: with SMTP id o15mr13267026edj.156.1596406508583;
        Sun, 02 Aug 2020 15:15:08 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:4c03:fcaa:281b:6f77])
        by smtp.gmail.com with ESMTPSA id l3sm5254030edv.3.2020.08.02.15.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 15:15:07 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] doc: document the sparse's extensions
Date:   Mon,  3 Aug 2020 00:14:51 +0200
Message-Id: <20200802221451.70311-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

First try at documenting sparse's extensions to C's type system.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/annotations.rst | 85 +++++++++++++++++++++++++++++++++++
 Documentation/index.rst       |  1 +
 2 files changed, 86 insertions(+)
 create mode 100644 Documentation/annotations.rst

diff --git a/Documentation/annotations.rst b/Documentation/annotations.rst
new file mode 100644
index 000000000000..d4b5546f6e50
--- /dev/null
+++ b/Documentation/annotations.rst
@@ -0,0 +1,85 @@
+Annotations
+===========
+
+Sparse extends C's type system with a number of extra type qualifiers
+which add restrictions on what you can do on objects annotated with them.
+These qualifiers are specified with GCC's ``__attribute__`` syntax.
+
+address_space(*name*)
+---------------------
+This attribute is to be used on pointers to specify that its target is
+in address space *name* (an identifier or a constant integer).
+
+Sparse treats pointers with different address spaces as distinct types
+and will warn on casts (implicit or explicit) mixing the address spaces.
+An exception to this is when the destination type is ``uintptr_t`` or
+``unsigned long`` since the resulting integer value is independent
+of the address space and can't be dereferenced without first casting
+it back to a pointer type.
+
+bitwise
+-------
+This attribute is to be used to define new, unique integer types that
+cannot be mixed with other types. In particular, you can't mix a
+"bitwise" integer with a normal integer expression, and you can't even
+mix it with another bitwise expression of a different type.
+The integer 0 is special, though, and can be mixed with any bitwise type
+since it's safe for all bitwise operations.
+
+Since this qualifier defines new types, it only makes sense to use
+it in typedefs, which effectively makes each of these typedefs
+a single "bitwise class", incompatible with any other types.
+
+context(*ctxt*, *entry*, *exit*)
+--------------------------------
+This attribute is to be used on function declarations to specify
+the function's entry and exit count for a given context. This
+context can be pretty much anything that can be counted.
+
+Sparse will check that the function's entry and exit contexts match, and
+that no path through a function is ever entered with conflicting contexts.
+In particular, it is designed for doing things like matching up a "lock"
+with the pairing "unlock". For example, a function doing a lock should be
+annotated with an entry value of 0 and an exit value of 1, the corresponding
+unlock function should use the values 1 and 0, and a function that should
+only be called on some locked data, release the lock but which doesn't exit
+without reacquiring the lock being, should use entry and exit values of 1.
+
+The first argument, *ctxt*, is an expression only used as documentation
+to identify the context. Usually, what is used is a pointer to the structure
+containing the context, for example, the structure protected by the lock.
+
+See also https://lwn.net/Articles/109066/.
+
+noderef
+-------
+This attribute is to be used on a r-value to specify it cannot be
+dereferenced. A pointer so annotated is in all other aspects exactly
+like a pointer  but trying to actually access anything through it will
+cause a warning.
+
+nocast
+------
+This attribute is similar to ``bitwise`` but in a much weaker form.
+It warns about explicit or implicit casting to different types.
+However, it doesn't warn about the mixing with other types and it easily
+gets lost: you can add plain integers to __nocast integer types and the
+result will be plain integers.
+So, it ends to be more useful for big integers that still need to act
+like integers, but you want to make it much less likely that they get
+truncated by mistake. For example, a 64-bit integer that you don't want
+to mistakenly/silently be returned as int.
+
+See also `Linus' e-mail about __nocast vs __bitwise
+<https://lore.kernel.org/linux-mm/CA+55aFzbhYvw7Am9EYgatpjTknBFm9eq+3jBWQHkSCUpnb3HRQ@mail.gmail.com/>`_.
+
+safe
+----
+This attribute specifies that the object, which should be a pointer,
+is defined to never be NULL or nontrapping.
+It causes a warning if the object is tested in a conditional.
+
+force
+-----
+This attribute is to be used in casts to suppress warnings that would
+otherwise be caused by the presence of one of these extra qualifiers.
diff --git a/Documentation/index.rst b/Documentation/index.rst
index 737f442323b5..9c76419ba5dd 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -68,6 +68,7 @@ User documentation
 .. toctree::
    :maxdepth: 1
 
+   annotations
    nocast-vs-bitwise
 
 Developer documentation
-- 
2.28.0


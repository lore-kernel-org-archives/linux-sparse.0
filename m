Return-Path: <SRS0=1LG9=AT=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C81C433E0
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 00:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F25120771
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 00:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5ToQjsL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgGHAG4 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 7 Jul 2020 20:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbgGHAGz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Jul 2020 20:06:55 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B16EC061755;
        Tue,  7 Jul 2020 17:06:55 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id by13so30298453edb.11;
        Tue, 07 Jul 2020 17:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=5u59B3j/I1X4s0AMR7GmGfqCIPTDy7Yx0A6CGhS03ZI=;
        b=N5ToQjsLjnK6wZEzcaRPU9Y+knUc86dCs8SeQPKdRgGWdPboUoOi7UORyDTXadYsv3
         7CBYkyUD3dX+4gQB1KGXwZtWQ2kfEaVqfTHwc60UpDuqAyor4ABFEINpckUFoOILizJe
         oQBv6Iji5JFNf9QSLlW/vq7fHjjr/EwMN5JyZWwuTpMZJz5JKbc/lPROdiUJlJGHauGi
         RD7u21Eye++Fiol+bUJQB66ufveXulVlmvGzcKAFamYgjiZfRM1bhaMKNmSVf9y3e1B7
         OdvnD5pc5Egb/oSEu7hgwK5d3NXv/a1YbpoydVt7Uk5QFjk/7Oa2DygHQGntW5m8QnbY
         g+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=5u59B3j/I1X4s0AMR7GmGfqCIPTDy7Yx0A6CGhS03ZI=;
        b=pSmbUYBDKLwdMHabuTv1SJ6s0f7N8CVq3n/myiJ3ZmeG8PTQTNGwLNI4nJNW+3tshI
         ogAXZGe65sVfGZGC54dt1sUWqV2KiaNtUDwo/rI6YNrJuCNXZW8BIxGaXYc1e0PYWa61
         wm8s2BGXKGxS/Avsx70gCPPzUwYvkrCqekwKpV5hTEq1VGbMswvkNk2sQaqr8QGF+wiM
         TjRNM/Q/C5okfOW8g0ptRGIyEsNJbhVmY1ieZK6N7CqW8tQ5K3v5G/2NJ14ZyodMXve8
         wKgmAxjB/CI4+fH6Lj/7cO+hyKut6vLPjRQKb55cSMfmnmJfJ+PdTaAFDHqGtqQhyFQi
         hKFg==
X-Gm-Message-State: AOAM530uOwwSg7T98veBvequFT28PSybxr3aIWlhZGtF5oGByAVVLW+o
        9zqY7EZAb4tHg1wgEDcZXYxHVvPI
X-Google-Smtp-Source: ABdhPJywQjpe6f713ksCWGGvOeROqfyqL4v3zrI5FFbi60qlBQjl58fYLu+MK5Y/LYkh0q8yk8Nraw==
X-Received: by 2002:aa7:c24d:: with SMTP id y13mr66898293edo.123.1594166813826;
        Tue, 07 Jul 2020 17:06:53 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7f9:7600:9501:ad60:97b5:4cc9])
        by smtp.gmail.com with ESMTPSA id j19sm27123807edt.44.2020.07.07.17.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 17:06:52 -0700 (PDT)
Date:   Wed, 8 Jul 2020 02:06:51 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Sparse improvements & regressions for Linux v5.7-rc1 -> v5.8-rc1
Message-ID: <20200708000651.f5bykhd3mhgsbvk7@ltop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

I've finally written a silly script to easily compare my tests
of Sparse on the kernel. So, it's now easy to share those results.

It's a comparison of Sparse's unique warnings between v5.7-rc1 &
v5.8-rc1 on x86-64 (defconfig + allyesconfig). The results are
quite similar on other architectures.

Note that the differences can be caused by changes in the kernel
code or in Sparse code.

Have fun.

- 20114 19249 Total

+    95   161 Initializer entry defined twice
-   152    98 Using plain integer as NULL pointer
    394   394 advancing past deep designator
      4     4 arithmetics on pointers to functions
+    15    16 bad assignment to restricted type
      4     4 cast between address spaces (<asn:3> -> <asn:4>)
+     0    38 cast from non-scalar
-   288   276 cast from restricted type
-    43    41 cast removes address space '<asn:1>' of expression
    142   142 cast removes address space '<asn:2>' of expression
      1     1 cast removes address space '<asn:3>' of expression
+    10    15 cast removes address space '<asn:4>' of expression
+    13    51 cast to non-scalar
-  4796  4512 cast to restricted type
+   595   609 cast truncates bits from constant value
+   335   349 context imbalance - different lock contexts for basic block
-   463   453 context imbalance - unexpected unlock
-   198   189 context imbalance - wrong count at exit
+   117   118 dereference of noderef expression
+    10    13 dubious: !x & y
+     0     1 dubious: !x | !y
      6     6 dubious: !x | y
+    56    57 dubious: x & !y
     21    21 dubious: x | !y
+    17    21 function with external linkage has definition
      2     2 implicit cast from nocast type
+   497   500 incompatible types in comparison expression (different address spaces)
      3     3 incompatible types in comparison expression (different base types)
      1     1 incompatible types in comparison expression (different type sizes)
+     5     6 incompatible types in conditional expression (different base types)
+  1216  1225 incorrect type in argument (different address spaces)
-   528   515 incorrect type in argument (different base types)
+     0     5 incorrect type in argument (different modifiers)
-    11    10 incorrect type in argument (different type sizes)
+     0     1 incorrect type in argument (incompatible argument (different address spaces))
      1     1 incorrect type in argument (incompatible argument (different base types))
+   369   388 incorrect type in assignment (different address spaces)
-  5607  4945 incorrect type in assignment (different base types)
      1     1 incorrect type in assignment (different modifiers)
+   139   141 incorrect type in initializer (different address spaces)
-   141   132 incorrect type in initializer (different base types)
+     4     7 incorrect type in initializer (incompatible argument (different address spaces))
-    27    26 incorrect type in return expression (different address spaces)
-    30    26 incorrect type in return expression (different base types)
-   516   451 invalid assignement
     37    37 invalid bitfield specifier for type restricted type.
     13    13 invalid initializer
      1     1 marked inline, but without a definition
      1     1 memcpy with byte count of ...
      5     5 memset with byte count of ...
-    10     0 missing braces around initializer
      7     7 mixed bitwiseness
     10    10 mixing different enum types:
      1     1 multiple address spaces given
-     2     1 no newline at end of file
      1     1 non-scalar type in conditional:
-     1     0 preprocessor token offsetof redefined
+   948   959 restricted type degrades to integer
+    42    43 return expression in void function
      3     3 shift count is (-1)
      5     5 shift too big for type
     12    12 static assertion failed
      5     5 subtraction of different types can't work (different address spaces)
+    23    24 subtraction of functions? Share your drugs
      1     1 switch with no cases
+     0     5 symbol redeclared with different type (incompatible argument (different address spaces))
+  2109  2135 symbol was not declared. Should it be static?
      1     1 too long token expansion
      3     3 trying to concatenate long character string (8191 bytes max)

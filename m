Return-Path: <SRS0=Hj1m=EC=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7724C388F9
	for <linux-sparse@archiver.kernel.org>; Tue, 27 Oct 2020 21:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 664FF20738
	for <linux-sparse@archiver.kernel.org>; Tue, 27 Oct 2020 21:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWhxNujT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1831886AbgJ0VDt (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 27 Oct 2020 17:03:49 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:43022 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1830508AbgJ0VDt (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 27 Oct 2020 17:03:49 -0400
Received: by mail-ed1-f52.google.com with SMTP id dn5so2908301edb.10;
        Tue, 27 Oct 2020 14:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=MRHwpH162vRxJWjqj9O5WBo0P2xuR+MBOoVYL38uDGA=;
        b=aWhxNujTl6QVa0Aq0eHESJ1qM8q9kaxOmrCiDd+9Zskh8wpz11e0ExZ7PYfQZzHiZ4
         nYnXum5J6yJUMABY4XgIeobpk3AmZN5yINYDm9kpZW/XgBr4tqBGr3FufjikHDIDx0yQ
         ueVNAW2KuryWKt0uqE51ByPFkTYzp3Hqleo3RZH7Zwcu24ALoD9PPI79y/yCKw7jQwIs
         4mTDJCuPhNNgJq6RILGwpPOS7BPzm3Q9tymmJm/GDV1hVxkP07rfpx9f7MOvfsWXnQgi
         86zf8OqA4sWId6UuEKKUSV7a1aEz0+hLcaLSrIUvSGW3UuHHmzhNBI+rrKNhM4XcvVwz
         /iXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=MRHwpH162vRxJWjqj9O5WBo0P2xuR+MBOoVYL38uDGA=;
        b=b4zsACoGBezMYUa2PEp3hXH5jL9uo06PqAZkP2OFgJE/f0USrvphtvS6Q3l5LOtDVe
         76B9Pdy7JTUlqedBBxYF7GpI6C/rPcbaRVp7YJL6WnVXr3jgbcrlRD6sNAiBgMsIl4Q1
         hTvMpWRFnP4y9iL+WyRn2QKnE7MQ9cCW4ww3rDPwADjBYkdSQYuAZeH71I/chqDbwrl9
         YMFUyrHpIJOoe0t+xx01ADCcYb3v1VX9ZlcOnEY25WXsb8o3JDsgV6sX7IfOv/LhXL7B
         lOQV2C/vro42Q6Pucj9T0E56LI7EWBReaV7wsmmmpSFQqh5IIzsbxgu8XfqhggIaAYvy
         +Evg==
X-Gm-Message-State: AOAM533D6TuwzpzQyakiJhIE5+S/yMu+ws5kTgsPu1+c8qe6VUJNQV2m
        4JkOjdzYo8MQL6wphemY4qHK+U6jqhw=
X-Google-Smtp-Source: ABdhPJw/rNHAmxTYG8/fZLnJXg7AHQfBUN+6w/Bh/xEdvP9okcGOviz4Bf1I5Tsi0bJWKpnNAYTd4A==
X-Received: by 2002:a05:6402:cac:: with SMTP id cn12mr4282750edb.326.1603832626617;
        Tue, 27 Oct 2020 14:03:46 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7fe:f700:14ec:85cd:eb33:2a5c])
        by smtp.gmail.com with ESMTPSA id m16sm1664990edj.37.2020.10.27.14.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 14:03:45 -0700 (PDT)
Date:   Tue, 27 Oct 2020 22:03:44 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Sparse improvements & regressions for Linux v5.9-rc1 -> v5.10-rc1
Message-ID: <20201027210344.e6rwboxcktgh5vyc@ltop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Hi,

Here is a comparison of Sparse's unique warnings between v5.9-rc1 &
v5.10-rc1 on x86-64 (defconfig + allyesconfig).

This time, there is a VERY significant decrease in the number of
warnings, almost 20% less. On ppc64, the difference is 31%. This big
difference is mainly but not only caused by "cast to restricted type"
warnings or related, like "different base types".

Some of these differences come from changes in Sparse, but most come
from changes in the kernel itself.

The raw logs as well as the result of the processing giving the
'unique warnings' are available at:
        git://github.com/lucvoo/sparse-logs.git


- 18621 14983 Total
+   191   210 Initializer entry defined twice
-   105    92 Using plain integer as NULL pointer
-   394     0 advancing past deep designator
      4     4 arithmetics on pointers to functions
+     0    88 array of flexible structures
-    12    10 bad assignment to restricted type
      4     4 cast between address spaces (__percpu -> __rcu)
-   261   257 cast from restricted type
-   473   468 cast removes address space '__iomem' of expression
      1     1 cast removes address space '__percpu' of expression
     15    15 cast removes address space '__rcu' of expression
-    43    20 cast removes address space '__user' of expression
-    13     0 cast to non-scalar
-  4550  2862 cast to restricted type
-   609   548 cast truncates bits from constant value
+   332   359 context imbalance - different lock contexts for basic block
+   467   472 context imbalance - unexpected unlock
+   189   191 context imbalance - wrong count at exit
-   109   106 dereference of noderef expression
+     0     1 division by zero
+     0     1 dubious one-bit signed bitfield
     16    16 dubious: !x & y
      1     1 dubious: !x | !y
      6     6 dubious: !x | y
     56    56 dubious: x & !y
-    20    19 dubious: x | !y
-     1     0 duplicate [noderef]
-    21    18 function with external linkage has definition
      2     2 implicit cast from nocast type
-   490   458 incompatible types in comparison expression (different address spaces)
+     3     4 incompatible types in comparison expression (different base types)
-     1     0 incompatible types in comparison expression (different type sizes)
      7     7 incompatible types in conditional expression (different base types)
-  1087  1031 incorrect type in argument (different address spaces)
-   494   477 incorrect type in argument (different base types)
-     1     0 incorrect type in argument (incompatible argument (different address spaces))
-   382   336 incorrect type in assignment (different address spaces)
-  4762  3513 incorrect type in assignment (different base types)
      1     1 incorrect type in assignment (different modifiers)
+   120   130 incorrect type in initializer (different address spaces)
-   131   124 incorrect type in initializer (different base types)
-     7     4 incorrect type in initializer (incompatible argument (different address spaces))
-    25    24 incorrect type in return expression (different address spaces)
-    30    25 incorrect type in return expression (different base types)
-   285   282 invalid assignment
     37    37 invalid bitfield specifier for type restricted type.
      7     7 invalid initializer
+     1     2 marked inline, but without a definition
-     1     0 memcpy with byte count of ...
-     5     4 memset with byte count of ...
      7     7 mixed bitwiseness
      8     8 mixing different enum types:
-     2     1 multiple address spaces given
     12    12 multiple definitions for ...
+     0     2 no generic selection for ...
-   918   902 restricted type degrades to integer
+     0     1 statement expected after label
+    12    16 static assertion failed
      5     5 subtraction of different types can't work (different address spaces)
     23    23 subtraction of functions? Share your drugs
      1     1 switch with no cases
+     0     1 symbol redeclared with different type (different address spaces)
-     5     2 symbol redeclared with different type (incompatible argument (different address spaces))
-  1852  1705 symbol was not declared. Should it be static?
      1     1 too long token expansion
      3     3 trying to concatenate long character string (8191 bytes max)

Return-Path: <SRS0=ZUDq=DO=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D43C4363D
	for <linux-sparse@archiver.kernel.org>; Wed,  7 Oct 2020 23:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1452B20872
	for <linux-sparse@archiver.kernel.org>; Wed,  7 Oct 2020 23:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qe3P+kBt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgJGXJZ (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 7 Oct 2020 19:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbgJGXJZ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 7 Oct 2020 19:09:25 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCFDC061755
        for <linux-sparse@vger.kernel.org>; Wed,  7 Oct 2020 16:09:23 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id p13so3919986edi.7
        for <linux-sparse@vger.kernel.org>; Wed, 07 Oct 2020 16:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wbZzfTE30dcrU58fSjhu/AklKYqgHma0oSMrDM+MIKY=;
        b=qe3P+kBttvDjCh27EZlC3EjEFh38I132bCxt/RieP5EBFwtABlBDCG/DNmm09qmTGX
         XwCRDwXkS127dF8Tx0DZFcvcALAdioyUfleWXBpt6v1kyYsgCvxEca0uchE1edRBvBOQ
         HYWsSZ3HJDAmbYlmibAWEqjZ5DhbjjNZb2eEysHOt7kEiQXyg77wdt3+QRMh5l0ZhnV/
         +Ji/h5RNZgAIyVChN+gr0VoyHrSNtgAInzysq5K1lsKW4RuSDZbubPZCODfC7cMR8Z89
         07BS8YWmqg+R9tCfC3+Wp9F3R+CKOM4sXNKcuoDA5pdcNFXqU07BnpMfYdRPrOicQ4eR
         B4qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wbZzfTE30dcrU58fSjhu/AklKYqgHma0oSMrDM+MIKY=;
        b=uloYKxBZdsRUxcxDpnouP3UN5Wu44pHMsQwIih1D0LICekX7xd6n9r0bIJ9bKwu9pl
         dWoN0xbheuwxoQwGLLLvLePo59mZqLRBSWAkjb2yJxqwxEOAkF/4XahsG0C7U3+OH2OV
         zwGQoQeBcx94uZ8y0FjCCtvc9EjzZcOhQD0XA8nLilouXc1cXsSNWb7ul1ly54yAAr6u
         P8cxosQr7AXtIswaBVS4J0d40YXgFsrlUa+1l8RYCVRW/LmoOAon0hbNgMrjoMavvxWR
         mXWkUFd8SbdFmNQnLuqZvoph3bzHrQhPRMW3TbBOi/UI1rTB3uY1NCGpjIymAUx9ddFB
         BIZA==
X-Gm-Message-State: AOAM530A2npntpo3a5IS3M1Cw/d5SG5nIbvApQgQKlmxYYoIRXJ4yf4P
        fojcI//00Dw9Lt065a00omiSsD+L0SI=
X-Google-Smtp-Source: ABdhPJw8Aj3KmQlTneKMzU8mNlQSKfIChQONP82d29iSJ57hEhyAwmZG67i7T6XElqWWPYSuKp7A1A==
X-Received: by 2002:a05:6402:359:: with SMTP id r25mr6194408edw.308.1602112162167;
        Wed, 07 Oct 2020 16:09:22 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7fe:f700:48d7:7240:c96a:4414])
        by smtp.gmail.com with ESMTPSA id oa19sm2508269ejb.95.2020.10.07.16.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 16:09:21 -0700 (PDT)
Date:   Thu, 8 Oct 2020 01:09:20 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Ilya Maximets <i.maximets@ovn.org>
Cc:     linux-sparse@vger.kernel.org, ovs-dev@openvswitch.org,
        Ian Stokes <ian.stokes@intel.com>,
        Aaron Conole <aconole@redhat.com>
Subject: Re: [PATCH] flex-array: allow arrays of unions with flexible members.
Message-ID: <20201007230920.lsclffcffqeywpev@ltop.local>
References: <20201007115234.1482603-1-i.maximets@ovn.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007115234.1482603-1-i.maximets@ovn.org>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Wed, Oct 07, 2020 at 01:52:34PM +0200, Ilya Maximets wrote:
> There is a common pattern on how to allocate memory for a flexible-size
> structure, e.g.
> 
>   union {
>       struct flex f;  /* Structure that contains a flexible array. */
>       char buf[MAX_SIZE];  /* Memeory buffer for structure 'flex' and
>                               its flexible array. */
>   };
> 
> There is another exmaple of such thing in CMSG manpage with the
> alignment purposes:
> 
>   union {         /* Ancillary data buffer, wrapped in a union
>                      in order to ensure it is suitably aligned */
>       char buf[CMSG_SPACE(sizeof(myfds))];
>       struct cmsghdr align;
>   } u;
> 
> Such unions could form an array in case user wants multiple
> instances of them.  For example, if you want receive up to
> 32 network packets via recvmmsg(), you will need 32 unions like 'u'.
> Open vSwitch does exactly that and fails the check.
> 
> Disabling this check by default for unions.  Adding new option
> -Wflex-union-array to enable it back.  This option works only
> if -Wflex-array-array enabled (which is default behavior).
> 
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---
> 
> Not sure if this is a best way to fix the issue, but it works fine for
> openvswitch project. The actual code in question that makes sparse fail
> OVS build could be found here:
>   https://github.com/openvswitch/ovs/blob/39fbd2c3f0392811689ec780f09baf90faceb877/lib/netdev-linux.c#L1238

This fixes your problem for -Wflexible-array-array but the same
will happen with -Wflexible-array-sizeof (and you're using sizeof()
on such flexible unions) and -Wflexible-array-nested.

So, what I'm proposing is a flag to simply disable all warnings
concerning flexible arrays with union types. I've also changed
the flag to -Wflexible-array-union to make it clear it's closely
related to -Wflexible-array-{array,nested,union}. I've also make
it to be enabled by default (but I haven't made my mind on it).


From 286903619edce5e723b3467e82bd6f09d4ae0031 Mon Sep 17 00:00:00 2001
From: Ilya Maximets <i.maximets@ovn.org>
Date: Wed, 7 Oct 2020 13:52:34 +0200
Subject: [PATCH] flex-array: allow arrays of unions with flexible members.

There is a common pattern on how to allocate memory for a flexible-size
structure, e.g.

  union {
      struct flex f;  /* Structure that contains a flexible array. */
      char buf[MAX_SIZE];  /* Memory buffer for structure 'flex' and
                              its flexible array. */
  };

There is another example of such thing in CMSG manpage with the
alignment purposes:

  union {         /* Ancillary data buffer, wrapped in a union
                     in order to ensure it is suitably aligned */
      char buf[CMSG_SPACE(sizeof(myfds))];
      struct cmsghdr align;
  } u;

Such unions could form an array in case user wants multiple
instances of them.  For example, if you want receive up to
32 network packets via recvmmsg(), you will need 32 unions like 'u'.
Open vSwitch does exactly that and fails the check.

So, add a new option, -W[no-]flex-array-union, to enable or disable
any warning concerning flexible arrays and unions. This option needs
at least one of -Wflex-array-{array,nested,union} to be enabled in
order to have any effect.

Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 options.c                         |  2 ++
 options.h                         |  1 +
 sparse.1                          |  9 +++++++++
 symbol.c                          |  2 +-
 validation/flex-union-array-no.c  |  9 +++++++++
 validation/flex-union-array-yes.c | 11 +++++++++++
 validation/flex-union-array.h     | 11 +++++++++++
 7 files changed, 44 insertions(+), 1 deletion(-)
 create mode 100644 validation/flex-union-array-no.c
 create mode 100644 validation/flex-union-array-yes.c
 create mode 100644 validation/flex-union-array.h

diff --git a/options.c b/options.c
index b46900b973a6..2736d38c0d4e 100644
--- a/options.c
+++ b/options.c
@@ -103,6 +103,7 @@ int Wexternal_function_has_definition = 1;
 int Wflexible_array_array = 1;
 int Wflexible_array_nested = 0;
 int Wflexible_array_sizeof = 0;
+int Wflexible_array_union = 1;
 int Wimplicit_int = 1;
 int Winit_cstring = 0;
 int Wint_to_pointer_cast = 1;
@@ -846,6 +847,7 @@ static const struct flag warnings[] = {
 	{ "flexible-array-array", &Wflexible_array_array },
 	{ "flexible-array-nested", &Wflexible_array_nested },
 	{ "flexible-array-sizeof", &Wflexible_array_sizeof },
+	{ "flexible-array-union", &Wflexible_array_union },
 	{ "implicit-int", &Wimplicit_int },
 	{ "init-cstring", &Winit_cstring },
 	{ "int-to-pointer-cast", &Wint_to_pointer_cast },
diff --git a/options.h b/options.h
index d23ed472eaac..70c6ce9bec37 100644
--- a/options.h
+++ b/options.h
@@ -102,6 +102,7 @@ extern int Wexternal_function_has_definition;
 extern int Wflexible_array_array;
 extern int Wflexible_array_nested;
 extern int Wflexible_array_sizeof;
+extern int Wflexible_array_union;
 extern int Wimplicit_int;
 extern int Winit_cstring;
 extern int Wint_to_pointer_cast;
diff --git a/sparse.1 b/sparse.1
index 9b1a59c6b9d4..ed528fd19dde 100644
--- a/sparse.1
+++ b/sparse.1
@@ -278,6 +278,15 @@ possibly recursively.
 Sparse does not issue these warnings by default.
 .
 .TP
+.B -Wflexible-array-union
+Enable the warnings regarding flexible arrays and unions.
+To have any effect, at least one of \fB-Wflexible-array-array\fR,
+\fB-Wflexible-array-nested\fR or \fB-Wflexible-array-sizeof\fR must also
+be enabled.
+
+Sparse does issue these warnings by default.
+.
+.TP
 .B \-Winit\-cstring
 Warn about initialization of a char array with a too long constant C string.
 
diff --git a/symbol.c b/symbol.c
index 97c2e35d3570..9ae827c1d764 100644
--- a/symbol.c
+++ b/symbol.c
@@ -214,7 +214,7 @@ static struct symbol * examine_struct_union_type(struct symbol *sym, int advance
 	if (info.flex_array) {
 		info.has_flex_array = 1;
 	}
-	if (info.has_flex_array)
+	if (info.has_flex_array && (!is_union_type(sym) || Wflexible_array_union))
 		sym->has_flex_array = 1;
 	sym->bit_size = bit_size;
 	return sym;
diff --git a/validation/flex-union-array-no.c b/validation/flex-union-array-no.c
new file mode 100644
index 000000000000..2857fd9b91a0
--- /dev/null
+++ b/validation/flex-union-array-no.c
@@ -0,0 +1,9 @@
+#include "flex-union-array.h"
+
+/*
+ * check-name: flex-array-union-no
+ * check-command: sparse -Wflexible-array-array -Wno-flexible-array-union $file
+ *
+ * check-error-start
+ * check-error-end
+ */
diff --git a/validation/flex-union-array-yes.c b/validation/flex-union-array-yes.c
new file mode 100644
index 000000000000..c8aa7966c811
--- /dev/null
+++ b/validation/flex-union-array-yes.c
@@ -0,0 +1,11 @@
+#include "flex-union-array.h"
+
+/*
+ * check-name: flex-array-union-yes
+ * check-command: sparse -Wflexible-array-array -Wflexible-array-union $file
+ *
+ * check-error-start
+flex-union-array-yes.c: note: in included file:
+flex-union-array.h:11:17: warning: array of flexible structures
+ * check-error-end
+ */
diff --git a/validation/flex-union-array.h b/validation/flex-union-array.h
new file mode 100644
index 000000000000..b2a74d1a06ea
--- /dev/null
+++ b/validation/flex-union-array.h
@@ -0,0 +1,11 @@
+struct s_flex {
+	int i;
+	long f[];
+};
+
+union s {
+	struct s_flex flex;
+	char buf[200];
+};
+
+static union s a[2];
-- 
2.28.0


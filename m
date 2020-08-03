Return-Path: <SRS0=lxW+=BN=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E74BC433DF
	for <linux-sparse@archiver.kernel.org>; Mon,  3 Aug 2020 14:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AB57206D4
	for <linux-sparse@archiver.kernel.org>; Mon,  3 Aug 2020 14:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlZ2CySh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgHCO3I (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 3 Aug 2020 10:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbgHCO3I (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 3 Aug 2020 10:29:08 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A0DC06174A
        for <linux-sparse@vger.kernel.org>; Mon,  3 Aug 2020 07:29:08 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id e4so7731591pjd.0
        for <linux-sparse@vger.kernel.org>; Mon, 03 Aug 2020 07:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=MqJh2LnViJ30CZNBJLko/MDIyLNqKueaQXfb3Y1bwTc=;
        b=HlZ2CyShgD9xEM/+wFv0NmN0oJG9gYgc9ugvwwWzqGByJ7zctYkxMSgr+BvRojfrK1
         KokCewrtW1OpW7dzWaVnEcAicfaBXGLHQuPXCKTyy2aTsfgCP6U4cjcv9tuG07AwTObE
         u7/2sE/sbbgmYwc9v4OSYUqSVHl78q73eEQYAppXXaWtonvwMgHmbopc3jESLary1ltT
         o5/Wm1o43qMEv1eFG+n5c5fT11iLdtsLGoXj+4zva+nrGb4QDlxFvDZSKQ4BDMtoRKcW
         S1MywhWW0PEB/AMxLA54RQcYYE65A4ecDbMDFj9ogIbPkC7gQHbXqBGxYe3I8awpEZmk
         ygxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=MqJh2LnViJ30CZNBJLko/MDIyLNqKueaQXfb3Y1bwTc=;
        b=IlYDZP+smMpiNMWIKtQ4lzft6XA2pAN0BOtcNankr5KwA5cCUvxpYc/UNNX6kc/akQ
         6rbsSReqy3gGfG4tPsm/hTJlCHmYbtKUzDUGnIyVKI5ckVj/bPDcUJIYgokvR7OEoFud
         bXXigUOvXXVhR6ahQy6zQWxOBbCYCk7PXA6gtzjtJgxyGVJH562KdwieIY0tBpt2XMwN
         b1rpuUSDlHhag9Z5LE+XazK7tWmMjyFcm12184hNVvF6C03rQ5idN5qfEBnDniABir43
         KV1sd2TiwPTR8Z3R6CtOOkoyGjFWrH5VRsLagLhSKHQv7NJvursFwIAU3Vp95CX74rwj
         nIVg==
X-Gm-Message-State: AOAM530rbdJnLvSeBGzirehTGMYKbj9x0TfKL5Szlva0GBIFy470lty1
        1ir1Pv8o81gYiM0QhFM3dSPFNedq
X-Google-Smtp-Source: ABdhPJyL9aZeiuzWAuxVzqGipU6/EELX04wEmdWJTMogK1OorvpV33/u1Aq0UaqN+/yRTkFrtPcxgw==
X-Received: by 2002:a17:90b:885:: with SMTP id bj5mr16363569pjb.133.1596464947451;
        Mon, 03 Aug 2020 07:29:07 -0700 (PDT)
Received: from localhost (g223.115-65-55.ppp.wakwak.ne.jp. [115.65.55.223])
        by smtp.gmail.com with ESMTPSA id n25sm20044365pff.51.2020.08.03.07.29.05
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 07:29:06 -0700 (PDT)
Date:   Mon, 3 Aug 2020 23:29:03 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     linux-sparse@vger.kernel.org
Subject: Issue with inline functions and switch statements
Message-ID: <20200803142903.GK80756@lianli.shorne-pla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Hello,

I am the maintainer of the OpenRISC architecture linux port, and recently have
started to look at the kbuild sparse errors.

The Linux kernel kbuild process is reporting sparse error:

   net/dccp/proto.c: note: in included file (through include/asm-generic/atomic.h, arch/openrisc/include/asm/atomic.h, include/linux/atomic.h, ...):
   arch/openrisc/include/asm/cmpxchg.h:101:29: sparse: sparse: shift too big (32) for type int

Example: https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2256733.html

I have traced this down to the case like the below.

It reports an unexpected warning:

   simple_test.c:7:18: warning: shift too big (32) for type int

This is not pssible because size = 4 should never call shift_small.

I have debugged sparse when this is running and it seems that when checking the switch
cases it evaluates all cases, and thinks size = 4 is possible.  I am not sure if this
is a problem with the sparse front end of the check logic.

Can you help?

-Stafford

--

/* From: https://github.com/stffrdhrn/junk/tree/master/sparse-shift
 * Run with : sparse -O2 --arch=openrisc -m32 simple_test.c
 */
#include <stdio.h>

typedef unsigned long int u32;

static inline u32 shift_small(int size)
{
	return 1 << (size * 8);
}

static inline u32 test(int size) {
	printf ("Test size=%d: ", size);
	switch (size) {
	case 1:
	case 2:
		return shift_small(size);
	case 4:
		printf ("not small\n");
		return 99;
	default:
		return 9999;
	}
}

int main(int argc, char ** argv) {
	test(1);

	test(2);

	test(4); // simple_test.c:7:18: warning: shift too big (32) for type int

	return 0;
}

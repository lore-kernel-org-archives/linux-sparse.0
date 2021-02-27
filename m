Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87893C433DB
	for <linux-sparse@archiver.kernel.org>; Sat, 27 Feb 2021 17:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5406664E46
	for <linux-sparse@archiver.kernel.org>; Sat, 27 Feb 2021 17:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhB0RtD (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 27 Feb 2021 12:49:03 -0500
Received: from avasout01.plus.net ([84.93.230.227]:55270 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbhB0Rqu (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 27 Feb 2021 12:46:50 -0500
Received: from [10.0.2.15] ([147.147.167.73])
        by smtp with ESMTPA
        id G3BXlRDCRg7CTG3BYlwMVv; Sat, 27 Feb 2021 17:15:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1614446121; bh=MjFTDsiFEDHmc4m51tubLBNKMLgHqJNDCRs9N407e7I=;
        h=To:Cc:From:Subject:Date;
        b=rdj+QRJsLQVofE+VrEt9sDosN1/ADbgSx8gCkGL+PRslfSJmqwzFUS7gSWD/CRvQd
         /rDtlMs1hzD+p68weLGdF3uth49OXvyWPdbiTzkeKNlU1hvup2WF+UO1kVkJaqwPop
         5vrccFjlUcqbLSYWV6ucdfDn6hG8ZBUbOIjnbIkobGZ0wHfjyaH6WKMQbNdR9fqGhJ
         jDeH9LW3inqXpMO/q//w5t9tMgScf1R7xO6X0RJkdgSe1FqJWGZ6eRob4WjRVFPmMB
         MTwciUTDA1ua1f6uAU8HYZVin8R59pH7iyck3moRrlSJkb9htPwk7HTevwZJPM5MUk
         sxFhwfbO6mV0w==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=cYFJUkLM c=1 sm=1 tr=0
 a=nK5asC+3lBOC3EoKtwbYYg==:117 a=nK5asC+3lBOC3EoKtwbYYg==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=mQv2aIotB2r71X3VWRQA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] asm-out0: fix a test failure on 32-bit systems
Message-ID: <4626bf8c-6079-976a-f579-f76ed1d2792d@ramsayjones.plus.com>
Date:   Sat, 27 Feb 2021 17:15:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfDQAmw8fA7Z+HiREazRExedpIWc9oM8LiV4Ay72QDydROVoc70x2rwCShLF3cKCSGS/BImcCDNQKrCOgKVLLgnymBdfOJpwkVjqZUG2bBZdWxPOWhWIO
 nGS3QpZQ0J18m50lT4FJsAUWEUlZJKwJzrxwghKwqjAJkQuY5dFkd7TIEbsGnCYdUwcUt+WFJ8rzpg==
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Luc,

So, I did some 32-bit testing this afternoon ... ;-)

The problem here being s/symaddr.64/symaddr.32/, of course. I did the
minimum necessary to get it to work (adding the -m64), so no creative
solutions here (not that I could think of any)!

[I suppose that I could also have created asm-out1.c as a copy and then
done s/symaddr.64/symaddr.32/, s/-m64/-m32/, but I didn't.]

ATB,
Ramsay Jones

 validation/linear/asm-out0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/validation/linear/asm-out0.c b/validation/linear/asm-out0.c
index a8e0be69..8b0907b3 100644
--- a/validation/linear/asm-out0.c
+++ b/validation/linear/asm-out0.c
@@ -6,7 +6,7 @@ static void asm_out0(void)
 
 /*
  * check-name: asm-out0
- * check-command: test-linearize -fdump-ir $file
+ * check-command: test-linearize -m64 -fdump-ir $file
  *
  * check-output-start
 asm_out0:
-- 
2.30.0

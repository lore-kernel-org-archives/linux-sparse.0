Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7B8C433E6
	for <linux-sparse@archiver.kernel.org>; Fri, 26 Feb 2021 23:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F93364E83
	for <linux-sparse@archiver.kernel.org>; Fri, 26 Feb 2021 23:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhBZX3b (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 26 Feb 2021 18:29:31 -0500
Received: from avasout03.plus.net ([84.93.230.244]:47893 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhBZX3b (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 26 Feb 2021 18:29:31 -0500
Received: from [10.0.2.15] ([147.147.167.73])
        by smtp with ESMTPA
        id FmXLl8aFIEfgXFmXMlwzvr; Fri, 26 Feb 2021 23:28:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1614382124; bh=ARXRUEFTAeQsAJ5ebuQfefB93dg/EIVLiD92IVpKXuY=;
        h=To:Cc:From:Subject:Date;
        b=jaOwJaAmEcCFZfi7Awf7paVCm0VIM8ziYAtUn+3zCdZIxLM6Iz6fUy+i4sXEhKy4D
         2DngrhKsnkiZ+Vdo/2d3pM7JWW6TRYKv9GCHVMJlK8DOt9P8hLgfbJbHACRxNVcbt/
         3P5O7XSKukDVvE21sLnDdWnlUKyCCoQqmve86yGRGOUvoOpkhb066Xj6iejBT2gzPR
         m+jg3FY4czba0jUoVWawpl4bm5pXUF7BZbhM2GeonOmrFC94b/CA3OCabIr/DGJS2M
         Zv6wepME1edd1Fn8q6Oj8rLZ7QdofUloHhZVrEWB2zYPHUrDKVZxWQLNn3VduUymuQ
         j5/00XrbYR6tA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=WomwzeXv c=1 sm=1 tr=0
 a=nK5asC+3lBOC3EoKtwbYYg==:117 a=nK5asC+3lBOC3EoKtwbYYg==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=w2lMRmTRfH--k1LY2AMA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] linearize.h: fix some 'selfcheck' warnings
Message-ID: <89a7aecb-1a5c-0a43-c9a9-ccee0b12fca6@ramsayjones.plus.com>
Date:   Fri, 26 Feb 2021 23:28:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfI9dGVR0yt8/beyZ0451F29re1bfgzB7azxEtIVmDPmLM9DX3eReoUuOcY4kjXW13yD+jbfwLQ3kbKL5ZHg6w9vY/9egNauuDkpplHTWJNStVEjmIhfb
 3mq9Gk4wpQAekTEBHnPR6zSifjuCLSvbxjLWWCJnd3tk6+5ItlNBvBv9g+src22XckoMP4zbXYePhg==
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org


Commits 34c57a7f ("asm-mem: does it clobber memory?", 2021-02-20) and
d6721b38 ("asm-mem: does it output to memory?", 2021-02-20) both add
a single bit bitfield to the 'struct asm' part of the union contained
within the 'struct instruction'. This causes the 'selfcheck' target
to issue several 'dubious one-bit signed bitfield' errors.

In order to suppress these errors, change the type of the bitfields to
an unsigned type.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 linearize.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linearize.h b/linearize.h
index cf0cf066..01ee656c 100644
--- a/linearize.h
+++ b/linearize.h
@@ -150,8 +150,8 @@ struct instruction {
 		struct /* asm */ {
 			const char *string;
 			struct asm_rules *asm_rules;
-			int clobber_memory:1;
-			int output_memory:1;
+			unsigned int clobber_memory:1;
+			unsigned int output_memory:1;
 		};
 	};
 };
-- 
2.30.0

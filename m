Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E304C433EF
	for <linux-sparse@archiver.kernel.org>; Sat, 15 Jan 2022 04:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbiAOEZi (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 14 Jan 2022 23:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiAOEZi (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 14 Jan 2022 23:25:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06D9C061574
        for <linux-sparse@vger.kernel.org>; Fri, 14 Jan 2022 20:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=MopXBAfcsAiO31pzhaChEkSes0k5YkHf4C6cl+bCAMs=; b=BNfE/4CaxffG7/gwHQ8wLeIDo4
        +tpdcdyD4jdpdl71+5sNeVXTnij1yTwEXb3vtDhQyCH8bH0b+5HpXsdk0+Ku5zJSsvj2JDvw35hEh
        YA3fbOhUp8brgnUXCLXKSaQarVtwxlwzTGqhT2nOZZJGIWoMQ/VueSotA7NOc9yJ8PT0HE8mVZFN7
        8b28HiVnk9z2Ya4j7RPaUEWH1Npf+YA5EXnUpaqN8Dpy3AW+5VJ9WWgRUzO7FDX/tVGkZjlVdKv72
        u9DWAgI4OclqYFm41FNg3lb2i36JBrvtXu9ooZvggjK/KfiJOFmH2cj7v0mwxwpAkLM3tM9al399N
        iryCRbsA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n8adB-006Kqb-Qs; Sat, 15 Jan 2022 04:25:34 +0000
Message-ID: <33a053bc-1d81-49f4-0c8a-879a5519c433@infradead.org>
Date:   Fri, 14 Jan 2022 20:25:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: sparse v0.6.4
Content-Language: en-US
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
References: <e9edc9f5-9b88-4a6a-17f8-544270ec2450@ramsayjones.plus.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <e9edc9f5-9b88-4a6a-17f8-544270ec2450@ramsayjones.plus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Hi Luc,

On 9/6/21 11:53, Ramsay Jones wrote:
> I have tested the new release, without issue, in the normal way on the
> usual platforms (32- & 64-bit Linux, 64-bit cygwin).
> 
> [Have you posted to the sparse mailing-list yet? I think my subscription
> has lapsed or something! I recently had to re-subscribe to the git
> mailing-list as well. :( ]

Odd, I didn't receive it either. No big deal, but I am just looking
at a kernel build issue when using sparse v0.6.4.

It seems that $subject version adds builtins for ATOMIC_ACQUIRE and
ATOMIC_RELEASE, but GCC has those too, so there are a few thousand
(OK, I didn't count them - I killed it quickly) of these: (e.g.)


..  CHECK   ../init/do_mounts_initrd.c
.command-line: note: in included file:
builtin:1:9: sparse: warning: preprocessor token __ATOMIC_ACQUIRE redefined
builtin:0:0: sparse: this was the original definition
builtin:1:9: sparse: warning: preprocessor token __ATOMIC_SEQ_CST redefined
builtin:0:0: sparse: this was the original definition
builtin:1:9: sparse: warning: preprocessor token __ATOMIC_ACQ_REL redefined
builtin:0:0: sparse: this was the original definition
builtin:1:9: sparse: warning: preprocessor token __ATOMIC_RELEASE redefined
builtin:0:0: sparse: this was the original definition

Any suggestions for how to avoid these warnings?

thanks.
-- 
~Randy

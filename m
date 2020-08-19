Return-Path: <SRS0=hg07=B5=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277ECC433DF
	for <linux-sparse@archiver.kernel.org>; Wed, 19 Aug 2020 21:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03269207DE
	for <linux-sparse@archiver.kernel.org>; Wed, 19 Aug 2020 21:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MkNtqNn9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgHSVsk (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 19 Aug 2020 17:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgHSVsk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 19 Aug 2020 17:48:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607FEC061757
        for <linux-sparse@vger.kernel.org>; Wed, 19 Aug 2020 14:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=XI931J5aWMaR2GzOayvEjRTTxUcZVkAksFuJEHSOgbI=; b=MkNtqNn9nrnMwXQTUr3FNLzfVh
        qbRyqGF/mz0jvRSZiUieeSSgLgFyhOD4N8E34SZ0VqqS8TPbpSeSIew+t6SDqQ4wdYDUiEtI0kMR3
        VYYc1YmRLviAby87cD8Sd87DnUODksrUGOubg2TBHq8wGfwqsIn4EGQLCRS0gzjRQjiKE29PNZjEf
        Kwe0LDZKXQ328vSKz9cAxhSAkXxkjkaWUfURExYp7qeH0SE4PkCLjpEpvgRcjfAdqHg51Cz5I/XIs
        lEoJTMkkGSYCGGWYPBKKiSuow+UM7yQFuNEuX5nuPVc6W80fJgsFliWM7RNCMmJ0EoaIZWbTR7+gg
        Udp+E12g==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8Vwk-0002Jy-6x; Wed, 19 Aug 2020 21:48:38 +0000
Subject: Re: sparse multiple address spaces?
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Linux-Sparse <linux-sparse@vger.kernel.org>
References: <e9deb689-e470-49e5-a339-252cb05ee119@infradead.org>
 <20200819200655.mqpjzfwlbyfxrksa@ltop.local>
 <20200819205234.ulgeccdi4fsidwou@ltop.local>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2bbeb226-8bd1-9e47-ecf1-ed69b4e5f08b@infradead.org>
Date:   Wed, 19 Aug 2020 14:48:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200819205234.ulgeccdi4fsidwou@ltop.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On 8/19/20 1:52 PM, Luc Van Oostenryck wrote:
> On Wed, Aug 19, 2020 at 10:06:55PM +0200, Luc Van Oostenryck wrote:
>> On Wed, Aug 19, 2020 at 12:15:46PM -0700, Randy Dunlap wrote:
>>> On Linux kernel tree v5.9-rc1, with sparse v0.6.2-180-g49f7e13a,
>>> I see this sparse warning which I don't grok:
>>>
>>> ../include/uapi/asm-generic/signal-defs.h:19:29: CK: error: multiple address spaces given
>>>
>>> for this source code:
>>>
>>> typedef void __signalfn_t(int);
>>> typedef __signalfn_t __user *__sighandler_t; <<<<< line 19
>>>
>>> Are there multiple address spaces there?  What are they?
>>>
>>>
>>>
>>> or: is the warning related to the other nearby warnings?  (e.g.:)
>>>
>>> ../kernel/signal.c:541:53: CK: warning: incorrect type in initializer (different address spaces)
>>> ../kernel/signal.c:541:53: CK:    expected struct k_sigaction *ka
>>> ../kernel/signal.c:541:53: CK:    got struct k_sigaction [noderef] __rcu *
>>> ../include/uapi/asm-generic/signal-defs.h:19:29: CK: error: multiple address spaces given
>>> ../kernel/signal.c:694:33: CK: warning: incorrect type in argument 1 (different address spaces)
>>> ../kernel/signal.c:694:33: CK:    expected struct spinlock [usertype] *lock
>>> ../kernel/signal.c:694:33: CK:    got struct spinlock [noderef] __rcu *
>>
>> I would guess that this __sighandler_t is used somewhere in a
>> struct which is itself accessed via a __rcu pointer.
>> But that would not explain the level of dereference.
>>
>> I'll need to check this one.
> 
> The location of the warning should be the assignment in kernel/signal.c:69
> 
> 	static void __user *sig_handler(struct task_struct *t, int sig) 
> 	{
> 		return t->sighand->action[sig - 1].sa.sa_handler;
> 	}
>  
> There is a lot of type abuses in this file, between 'void __user *' and
> __sighandler_t, but the root cause of the warning is the '__rcu' in 
> 
> 	struct task_struct {
> 		...
> 		struct sighand_struct __rcu *sighand;
> 		...
> 	}

OK, thanks for all of your excavation work. :)

-- 
~Randy


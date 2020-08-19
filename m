Return-Path: <SRS0=hg07=B5=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D64C433DF
	for <linux-sparse@archiver.kernel.org>; Wed, 19 Aug 2020 20:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 316B521734
	for <linux-sparse@archiver.kernel.org>; Wed, 19 Aug 2020 20:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ko65UR8E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgHSUwj (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 19 Aug 2020 16:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgHSUwh (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 19 Aug 2020 16:52:37 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82994C061757
        for <linux-sparse@vger.kernel.org>; Wed, 19 Aug 2020 13:52:37 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id c10so19226769edk.6
        for <linux-sparse@vger.kernel.org>; Wed, 19 Aug 2020 13:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mXabKFq+3N3jkGPCDpFmaq984Vgs7Wp/yowCohUodO8=;
        b=ko65UR8EfB7d5qbctOlukdjLTH9kwJB3An3nH4U7dtaRr3EnhgHHiif/8WcHc/HFA1
         ERMGbNSY+cooJNO8FyazJ8gO3mbqpFRWmu+CKMdA/g3s/zABEdw83d41omc8T2IgFBOI
         jQ0VSc1wF0/n6lySVFJJ6cIUDjLc0Ts9c/6nxv9JiETZAK2gX3KeRpA4IkLPBAGKUdfr
         4QnukCxyL7iilURUwNXU/weykMQByx23uevESsQpnNb9GjZGAR9hnG9TtBMes8+U015c
         Gspf6OBvzo76O9gi0kZxnAJyl6s9fSjbijU3mhqvW6aSY/U23H9M34XxeApor9/cdLDo
         PYbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mXabKFq+3N3jkGPCDpFmaq984Vgs7Wp/yowCohUodO8=;
        b=KUkshJqVSvZiV+VD0PjDI63NxMSHkzArCwUu9TNh3/dvWGAgyPDjXPRdQuKvu3Rs6Z
         cfEBEd+gUS/sa32PjoIYtnvfY/hSS8Ay6B1xiMeqfQKU3M2o5N4vpcZ/L1s0wtB48zxl
         Jf5bG+GWD+oSr6HE2VtyNr7NKL8g1iGTRGic+payoI8W5WlwfeODILcIkWyjDayH5oKW
         lqs0TAac/qmnZhXf/4uBwL8dAO1KIeW9h/IzsEn3Bp8WeCQEfN033m6LO2vzq23HAbRW
         mxZmIJjA34aq2nFAcgeznQEsxrYQC9pkfFODpFd56w8FeVIan2y7WYJTLss1QOoZzD97
         v5yQ==
X-Gm-Message-State: AOAM5314JEX1QLQWDDJYloVt/7Pew3XHbDGSVTGyxafR4s+cOmTQIdug
        FQpDaixi7HRTvV4St61Zt5s=
X-Google-Smtp-Source: ABdhPJwsePvNTGzEx0hTOsxIuNFSi46vrfvo2LHf1YqljbJcikGUgu/xD+IqsExs5Lnz8UFe6pNntg==
X-Received: by 2002:aa7:d9d7:: with SMTP id v23mr27525157eds.112.1597870356185;
        Wed, 19 Aug 2020 13:52:36 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:a7fb:e200:3df2:5395:4551:8abb])
        by smtp.gmail.com with ESMTPSA id re10sm19625211ejb.68.2020.08.19.13.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 13:52:35 -0700 (PDT)
Date:   Wed, 19 Aug 2020 22:52:34 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux-Sparse <linux-sparse@vger.kernel.org>
Subject: Re: sparse multiple address spaces?
Message-ID: <20200819205234.ulgeccdi4fsidwou@ltop.local>
References: <e9deb689-e470-49e5-a339-252cb05ee119@infradead.org>
 <20200819200655.mqpjzfwlbyfxrksa@ltop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819200655.mqpjzfwlbyfxrksa@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Wed, Aug 19, 2020 at 10:06:55PM +0200, Luc Van Oostenryck wrote:
> On Wed, Aug 19, 2020 at 12:15:46PM -0700, Randy Dunlap wrote:
> > On Linux kernel tree v5.9-rc1, with sparse v0.6.2-180-g49f7e13a,
> > I see this sparse warning which I don't grok:
> > 
> > ../include/uapi/asm-generic/signal-defs.h:19:29: CK: error: multiple address spaces given
> > 
> > for this source code:
> > 
> > typedef void __signalfn_t(int);
> > typedef __signalfn_t __user *__sighandler_t; <<<<< line 19
> > 
> > Are there multiple address spaces there?  What are they?
> > 
> > 
> > 
> > or: is the warning related to the other nearby warnings?  (e.g.:)
> > 
> > ../kernel/signal.c:541:53: CK: warning: incorrect type in initializer (different address spaces)
> > ../kernel/signal.c:541:53: CK:    expected struct k_sigaction *ka
> > ../kernel/signal.c:541:53: CK:    got struct k_sigaction [noderef] __rcu *
> > ../include/uapi/asm-generic/signal-defs.h:19:29: CK: error: multiple address spaces given
> > ../kernel/signal.c:694:33: CK: warning: incorrect type in argument 1 (different address spaces)
> > ../kernel/signal.c:694:33: CK:    expected struct spinlock [usertype] *lock
> > ../kernel/signal.c:694:33: CK:    got struct spinlock [noderef] __rcu *
> 
> I would guess that this __sighandler_t is used somewhere in a
> struct which is itself accessed via a __rcu pointer.
> But that would not explain the level of dereference.
> 
> I'll need to check this one.

The location of the warning should be the assignment in kernel/signal.c:69

	static void __user *sig_handler(struct task_struct *t, int sig) 
	{
		return t->sighand->action[sig - 1].sa.sa_handler;
	}
 
There is a lot of type abuses in this file, between 'void __user *' and
__sighandler_t, but the root cause of the warning is the '__rcu' in 

	struct task_struct {
		...
		struct sighand_struct __rcu *sighand;
		...
	}

Best regards,
-- Luc

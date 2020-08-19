Return-Path: <SRS0=hg07=B5=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A772C433E1
	for <linux-sparse@archiver.kernel.org>; Wed, 19 Aug 2020 19:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BDE72078D
	for <linux-sparse@archiver.kernel.org>; Wed, 19 Aug 2020 19:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G1clxrR/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgHSTPw (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 19 Aug 2020 15:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgHSTPv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 19 Aug 2020 15:15:51 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49116C061757
        for <linux-sparse@vger.kernel.org>; Wed, 19 Aug 2020 12:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=N4HKPEXbHWMcPINLqEuvP3OvhXWMBGf51pnbldo9huw=; b=G1clxrR/Yu70KLT9Cnw9SoEJb/
        lVxPWK1T4WRl9pfmPOW++TfcqJRhdnFnWKxWhm7AXyBvYe8vAOTG/irLVq7DwfEBQVVOjmNmbKAzx
        QcPpv1WCcQT3FOOjicnG6laAun44x8eNSi+ciOToNirz+wU8XwwShRzCa/CpJF6US99FOhcPaxkEW
        6uWLqTF8pDoikU8kdzerRAWQWygLMkihqJLubwW2Ss6ss2nKBscokkNiNJ/YsIy3h/75C59hatXFx
        VIEyFEvtxvMqKfw4/QyZ9dJo/JhJi4UgF2LmxlKASccSUwlFI3TS6o9qXGPdSYDe/Ub9LB0ZWqQSe
        sHWAEn1g==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8TYr-00044U-7r; Wed, 19 Aug 2020 19:15:49 +0000
To:     Linux-Sparse <linux-sparse@vger.kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: sparse multiple address spaces?
Message-ID: <e9deb689-e470-49e5-a339-252cb05ee119@infradead.org>
Date:   Wed, 19 Aug 2020 12:15:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Linux kernel tree v5.9-rc1, with sparse v0.6.2-180-g49f7e13a,
I see this sparse warning which I don't grok:

../include/uapi/asm-generic/signal-defs.h:19:29: CK: error: multiple address spaces given

for this source code:

typedef void __signalfn_t(int);
typedef __signalfn_t __user *__sighandler_t; <<<<< line 19

Are there multiple address spaces there?  What are they?



or: is the warning related to the other nearby warnings?  (e.g.:)

../kernel/signal.c:541:53: CK: warning: incorrect type in initializer (different address spaces)
../kernel/signal.c:541:53: CK:    expected struct k_sigaction *ka
../kernel/signal.c:541:53: CK:    got struct k_sigaction [noderef] __rcu *
../include/uapi/asm-generic/signal-defs.h:19:29: CK: error: multiple address spaces given
../kernel/signal.c:694:33: CK: warning: incorrect type in argument 1 (different address spaces)
../kernel/signal.c:694:33: CK:    expected struct spinlock [usertype] *lock
../kernel/signal.c:694:33: CK:    got struct spinlock [noderef] __rcu *


thanks.
-- 
~Randy


From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] cgcc: provide __ARM_PCS_VFP for armhf
Date: Tue, 26 Sep 2017 22:35:20 +0200
Message-ID: <20170926203518.3m3b2e4aeejkidq4@ltop.local>
References: <20170926071520.26507-1-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:44163 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964856AbdIZUfY (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 26 Sep 2017 16:35:24 -0400
Received: by mail-wm0-f42.google.com with SMTP id m127so17356666wmm.1
        for <linux-sparse@vger.kernel.org>; Tue, 26 Sep 2017 13:35:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170926071520.26507-1-uwe@kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc: linux-sparse@vger.kernel.org

On Tue, Sep 26, 2017 at 09:15:20AM +0200, Uwe Kleine-König wrote:
> This fixes:
> 
> 	$ uname -m
> 	armv8l
> 	$ env CHECK=./sparse ./cgcc -no-compile memops.c
> 	/usr/include/arm-linux-gnueabihf/gnu/stubs.h:7:12: error: unable to open 'gnu/stubs-soft.h'
> 
...
> 
> With that applied all Debian primary architectures work fine; see
> https://buildd.debian.org/status/package.php?p=sparse&suite=unstable

Nice!
 
-- Luc

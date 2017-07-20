From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 2/5] avoid crash when ep->active is NULL
Date: Wed, 19 Jul 2017 21:37:49 -0700
Message-ID: <CANeU7QnkroKeCbALvQ_VVjzDmiEhQhFtLB4wpiEUzXOhnHVoPg@mail.gmail.com>
References: <20170706191950.81268-1-luc.vanoostenryck@gmail.com>
 <20170706191950.81268-3-luc.vanoostenryck@gmail.com> <20170719222051.ssog4n5wd75lik5o@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48]:35398 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750915AbdGTEhu (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 20 Jul 2017 00:37:50 -0400
Received: by mail-pg0-f48.google.com with SMTP id v190so9251100pgv.2
        for <linux-sparse@vger.kernel.org>; Wed, 19 Jul 2017 21:37:50 -0700 (PDT)
In-Reply-To: <20170719222051.ssog4n5wd75lik5o@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Jul 19, 2017 at 3:20 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> This patch fixes a reproducible crash and have been ignored
> since it has been posted two weeks ago.
> Is there any reasons why?

Because you are away? We are discussing the different approach of the first
patch and all the sudden you stop response to email.

Those small patch are trivial to review. Just a ping would be good enough.

BTW, the check should happen before the allocation. Otherwise there is
memory leak.

Chris

        pseudo_t phi = __alloc_pseudo(0);
        static int nr = 0;

+       if (!source)
+               return VOID;
+

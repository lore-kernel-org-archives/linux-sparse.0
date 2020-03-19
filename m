From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 1/5] add testcases for OP_UNREACH
Date: Fri, 20 Mar 2020 00:54:48 +0100
Message-ID: <20200319235448.j4l72vgoo6sl64tn@ltop.local>
References: <20200318173120.63939-1-luc.vanoostenryck@gmail.com>
 <20200318173120.63939-2-luc.vanoostenryck@gmail.com>
 <48b264ee-c07f-9545-ba92-04934aca9752@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44350 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgCSXzV (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 19 Mar 2020 19:55:21 -0400
Received: by mail-wr1-f66.google.com with SMTP id o12so4923273wrh.11
        for <linux-sparse@vger.kernel.org>; Thu, 19 Mar 2020 16:55:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <48b264ee-c07f-9545-ba92-04934aca9752@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: linux-sparse@vger.kernel.org

On Thu, Mar 19, 2020 at 10:24:28PM +0000, Ramsay Jones wrote:
> On 18/03/2020 17:31, Luc Van Oostenryck wrote:
> > diff --git a/validation/linear/builtin_unreachable0.c b/validation/linear/builtin_unreachable0.c
> > new file mode 100644
> > index 000000000000..5da9d074ae5f
> > --- /dev/null
> > +++ b/validation/linear/builtin_unreachable0.c
> > @@ -0,0 +1,30 @@
> > +extern void die(void) __attribute__((noreturn));
> 
> Hmm, is this declaration intended?

Only before it was cut-and-pasted ;)
Thanks for noticing.

-- Luc 

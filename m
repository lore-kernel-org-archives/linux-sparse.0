From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 1/5] do not corrupt ptrlist while killing unreachable BBs
Date: Fri, 7 Jul 2017 07:44:59 +0200
Message-ID: <20170707054459.pkhqnmrz7yt3sppc@ltop.local>
References: <20170706191950.81268-1-luc.vanoostenryck@gmail.com>
 <20170706191950.81268-2-luc.vanoostenryck@gmail.com>
 <CANeU7QnbwqVcZdbarrj4OdpR9-TaG9=t5Q_CDFZXSuB+SN8zLw@mail.gmail.com>
 <CANeU7QnVNE38ODJ+cgUzD3Vz4XKogk-RL2v6-dS2aX9Oc4_0uQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f174.google.com ([209.85.128.174]:36390 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750911AbdGGFpD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 01:45:03 -0400
Received: by mail-wr0-f174.google.com with SMTP id c11so31005045wrc.3
        for <linux-sparse@vger.kernel.org>; Thu, 06 Jul 2017 22:45:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7QnVNE38ODJ+cgUzD3Vz4XKogk-RL2v6-dS2aX9Oc4_0uQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Jul 06, 2017 at 06:18:48PM -0700, Christopher Li wrote:
> On Thu, Jul 6, 2017 at 5:40 PM, Christopher Li <sparse@chrisli.org> wrote:
> >
> > Thanks for catching it. That is a very serious bug.
> > The release will be on hold until this bug has been fix.
> > It is actually more than one of them. I will send out a separate patch
> > catching this kind of behavior.
> >
> 
> Here is the patch. There is another offender in simplify.c
> 
> Chris
> 
> From: Christopher Li <sparse@chrisli.org>
> Date: Thu, 6 Jul 2017 16:25:38 -0700
> Subject: [PATCH 2/2] check on delete list entry while parent caller using it.
> 
> This is checking for type the bug Luc reported.
> Basiclly, the parent DO_FOR_EACH() has __nr caching the
> current ptr position. When the inner loop function delete
> one entry before the current position. The parent current
> position needs to be adjust, because the entry[] has been
> move forward.
> 
> This patch only check usage FOR_EACH_XXX macro. There is
> also PREPARE_PTR_LIST haven't cover by this patch.
> It is already catching bugs left and right.
> 
> Most noticablely remove_usage() inside of the  kill_use_list()
> loop.
> ---
>  ptrlist.h | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/ptrlist.h b/ptrlist.h
> index d09be2f..4f38a4e 100644
> --- a/ptrlist.h
> +++ b/ptrlist.h
> @@ -25,7 +25,8 @@
>  #define LIST_NODE_NR (29)
> 
>  struct ptr_list {
> - int nr;
> + unsigned int nr:16;
> + unsigned int active:16;

Mmmm ...

I really don't like this kind of solution.
The ptrlist is already fragile and now it would contains
yet another field that need to be taken care of *and* stay
coherent with other users. I doubt this will help to reduce bugs.

Also, I don't think the principle of this solution is sound.
In particular, these die() make me nervous. 
Can you explain a bit how it is working, how you can guarantee
that these die() won't be called?

-- Luc

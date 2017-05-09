From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] fix: kill unreachable BBs after killing a child
Date: Tue, 9 May 2017 03:38:43 -0700
Message-ID: <CANeU7Q=RU6PbRFFd7ZT4=bQh7-rHW=c9K+9bUPReSKuQmq8FqQ@mail.gmail.com>
References: <20170508185710.22021-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:32794 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750968AbdEIKio (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 9 May 2017 06:38:44 -0400
Received: by mail-it0-f65.google.com with SMTP id v135so9976597itv.0
        for <linux-sparse@vger.kernel.org>; Tue, 09 May 2017 03:38:44 -0700 (PDT)
In-Reply-To: <20170508185710.22021-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, May 8, 2017 at 11:57 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Fix this by calling kill_unreachable_bbs() after having
> simplified the switch into a branch. This will avoid to
> create a cycle with because of the removed phisrc in the
> header and as an added benefit will avoid to waste time
> trying to simplify BBs that are unreachable.
>
> In addition, it's now useless to call kill_bb() for each
> removed switch's children as kill_unreachable_bbs() will
> do that too.

I thin the fix is correct. Have some very minor comment.

>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  linearize.c                 |  3 +--
>  validation/crazy02-not-so.c | 22 ++++++++++++++++++++++
>  2 files changed, 23 insertions(+), 2 deletions(-)
>  create mode 100644 validation/crazy02-not-so.c
>
> diff --git a/linearize.c b/linearize.c
> index a9f36b823..ee9591897 100644
> --- a/linearize.c
> +++ b/linearize.c
> @@ -642,8 +642,6 @@ static void set_activeblock(struct entrypoint *ep, struct basic_block *bb)
>  static void remove_parent(struct basic_block *child, struct basic_block *parent)
>  {
>         remove_bb_from_list(&child->parents, parent, 1);
> -       if (!child->parents)
> -               kill_bb(child);

This makes every caller of remove_parent() need to clean up the
unreachable basic blocks. Currently there is only one caller  "insert_branch()"
which is fine. But if developer write a new code call this function, he might
forget to clean up the unreachable basic blocks. Kind of like a trap.


>  }
>
>  /* Change a "switch" into a branch */
> @@ -670,6 +668,7 @@ void insert_branch(struct basic_block *bb, struct instruction *jmp, struct basic
>                 remove_parent(child, bb);
>         } END_FOR_EACH_PTR(child);
>         PACK_PTR_LIST(&bb->children);
> +       kill_unreachable_bbs(bb->ep);

It is correct to do so. The kill unreachable is relative expensive.
Need to go through
all the basic block in a function. If there function has more than one
switch statement
get simplified, then each simplification will go through each basic block again.
Preferably  kill_unreachable() only run once at the finial stage.

I don't know how feasible to have remove_parent() mark the "ep" needs to clean.
Then at some later point kill off the dead basic block all together.

Currently simplify a switch statement should be relative rare. Have two switch
statement in same function get simplify at the same time should be
even rarer.
Might not worth the effort to optimize for that.

As it is, the patch is acceptable.

Chris

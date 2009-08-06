From: Hannes Eder <hannes@hanneseder.net>
Subject: Re: [PATCH] linearize.h: sanitize header
Date: Thu, 6 Aug 2009 11:23:26 +0200
Message-ID: <154e089b0908060223h6ae15b26q73360ee3658d6a82@mail.gmail.com>
References: <200908061102.14935.kdudka@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-fx0-f228.google.com ([209.85.220.228]:42730 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754340AbZHFJbI (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 6 Aug 2009 05:31:08 -0400
Received: by fxm28 with SMTP id 28so619659fxm.17
        for <linux-sparse@vger.kernel.org>; Thu, 06 Aug 2009 02:31:07 -0700 (PDT)
In-Reply-To: <200908061102.14935.kdudka@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Kamil Dudka <kdudka@redhat.com>
Cc: sparse <linux-sparse@vger.kernel.org>

On Thu, Aug 6, 2009 at 11:02, Kamil Dudka<kdudka@redhat.com> wrote:
> It's unfortunate to use 'true' and 'false' as identifiers in a system
> header. It clashes with corresponding macros from <stdbool.h> when
> included before <sparse/linearize.h>.
>
> Signed-off-by: Kamil Dudka <kdudka@redhat.com>
> ---
>  linearize.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/linearize.h b/linearize.h
> index 2205082..50b3601 100644
> --- a/linearize.h
> +++ b/linearize.h
> @@ -328,7 +328,7 @@ struct entrypoint {
>         struct instruction *entry;
>  };
>
> -extern void insert_select(struct basic_block *bb, struct instruction *br, struct instruction *phi, pseudo_t true, pseudo_t false);
> +extern void insert_select(struct basic_block *bb, struct instruction *br, struct instruction *phi, pseudo_t if_true, pseudo_t if_false);

I guess it is wise to change this in linearize.c as well.  Mind sending a patch?

>  extern void insert_branch(struct basic_block *bb, struct instruction *br, struct basic_block *target);
>
>  pseudo_t alloc_phi(struct basic_block *source, pseudo_t pseudo, int size);


Cheers,
-Hannes

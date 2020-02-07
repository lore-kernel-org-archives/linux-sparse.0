From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] dissect: introduce dissect_ctx
Date: Fri, 7 Feb 2020 11:01:50 +0100
Message-ID: <20200207100150.GB9260@redhat.com>
References: <20200206170132.GA8908@redhat.com>
 <20200206204518.qx5qtyl52al37njy@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26248 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726587AbgBGKB6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Feb 2020 05:01:58 -0500
In-Reply-To: <20200206204518.qx5qtyl52al37njy@ltop.local>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Alexey Gladkov <gladkov.alexey@gmail.com>, linux-sparse@vger.kernel.org

On 02/06, Luc Van Oostenryck wrote:
>
> On Thu, Feb 06, 2020 at 06:01:32PM +0100, Oleg Nesterov wrote:
> > Points to the current function or to the global variable in case of
> > compound initializer.
> >
> > Kill the ugly test-dissect.c:storage() and change print_usage() to
> > report dissect_ctx->ident instead.
>
> Having the ful ident will be good, I think, but the cost is to have
> to maintain this context. I suppose it would be too painful to
> propgate this context via an additional argument to all involved
> functions?

Oh, I'd prefer to not do this. This needs to add the additional "ctx"
arg to every do_.*() function in dissect.c, and for what? IMHO, this
will just complicate the code for no reason.

I can unexport the global "struct symbol *dissect_ctx" introduced by
this patch and pass it as the additional (new) argument to every to
every callback, but I'd like to do this later, along with other
"incompatible" changes for the new tool Alexey is working on.

Thanks,

Oleg.

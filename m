From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 15/17] scope: give a scope for labels & gotos
Date: Mon, 13 Apr 2020 22:00:43 +0200
Message-ID: <20200413200043.6mv4d67pioex52wb@ltop.local>
References: <20200413161605.95900-1-luc.vanoostenryck@gmail.com>
 <20200413161605.95900-16-luc.vanoostenryck@gmail.com>
 <CAHk-=wiy-BFXMpmm9-GNT_WtDKVLeR0ki4OTj83xPk=npuNSHA@mail.gmail.com>
 <20200413185452.pgj75pj5g7a42kik@ltop.local>
 <CAHk-=wjMSeVVQHZ23=HJ3V-yYPooeuHNHmZtexUVRKg_e5VMXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388135AbgDMUAq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Apr 2020 16:00:46 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B825FC0A3BDC
        for <linux-sparse@vger.kernel.org>; Mon, 13 Apr 2020 13:00:45 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h26so104730wrb.7
        for <linux-sparse@vger.kernel.org>; Mon, 13 Apr 2020 13:00:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAHk-=wjMSeVVQHZ23=HJ3V-yYPooeuHNHmZtexUVRKg_e5VMXA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Mon, Apr 13, 2020 at 12:32:41PM -0700, Linus Torvalds wrote:
> 
> I _feel_ like the fix to that should be that the only thing that
> creates the actual symbol is the label definition, and that the goto
> should only ever use the 'ident' and we'd tie the two together later.

Yes, I tried that too but it didn't worked because:
 
> But yeah, that "tie the two together later" may not work, simply
> because scoping is so tightly tied to parsing in sparse.
> 
> So maybe your approach is the best one.
> 
> It feels hacky and wrong, but maybe that just fundamentally comes from
> labels having that very special "use = implicit declaration" thing.

Yes, that and the way the symbol 'table' is done: very clever but
unusable for our problem here. But maybe there is something that can
be done there. Currently end_scope() sets scope->symbols to NULL but
as far as I can see, this is not really needed and, if left, the
"tie the two together later" could be done by doing a symbol lookup
via this list instead of the usual lookup via ident->symbols, much
like classical symbol tables are used. It should be quite easy.
I'll give it a try because I'm also not really satisfied with my
current solution giving a kind of secondary scope to the statements.

-- Luc

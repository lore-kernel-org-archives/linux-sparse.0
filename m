From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 0/2] list of gcc supported attribute name
Date: Tue, 4 Jul 2017 10:05:19 +0200
Message-ID: <20170704080518.3c2f6li274qikrcx@ltop.local>
References: <CANeU7QmC-mpubM+2T-50tqwXbXshpFoYzxg4cTw+t-jQDb-J=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37594 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752162AbdGDIFW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 4 Jul 2017 04:05:22 -0400
Received: by mail-wm0-f43.google.com with SMTP id i127so129625640wma.0
        for <linux-sparse@vger.kernel.org>; Tue, 04 Jul 2017 01:05:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7QmC-mpubM+2T-50tqwXbXshpFoYzxg4cTw+t-jQDb-J=g@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Jul 03, 2017 at 11:35:59AM -0700, Christopher Li wrote:
> This patch add full list of known gcc supported attributes.
> 
> So sparse should not give warning on the legit gcc attribute
> any more.
> 
> Test with full kernel allmodeconfig compile with the exact
> same output as before(master branch).
> 
> I want to include this two patches in the sparse release 0.5.1.
> 
> Git repository here:
> https://git.kernel.org/pub/scm/devel/sparse/sparse.git/log/?h=sparse-next-20170603

I think you meant -20170703 here, not -20170603.

On the mailing list, can you please send the patches inlined,
as, for review, attachements are kinda useless.

In patch 1, in the die() message, I think you meant:
	"created with different types"
               ^                    ^

In both patches, your signoff is supposed to contains your name.

Thanks,
-- Luc 

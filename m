From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 0/2] list of gcc supported attribute name
Date: Tue, 4 Jul 2017 08:07:54 -0700
Message-ID: <CANeU7QmCisOi35+YfDf93zhdu0O_dBkcr9BCh_z0iqUN_UEWVw@mail.gmail.com>
References: <CANeU7QmC-mpubM+2T-50tqwXbXshpFoYzxg4cTw+t-jQDb-J=g@mail.gmail.com>
 <20170704080518.3c2f6li274qikrcx@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47]:34813 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752159AbdGDPHz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 4 Jul 2017 11:07:55 -0400
Received: by mail-pg0-f47.google.com with SMTP id t186so111980584pgb.1
        for <linux-sparse@vger.kernel.org>; Tue, 04 Jul 2017 08:07:55 -0700 (PDT)
In-Reply-To: <20170704080518.3c2f6li274qikrcx@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Jul 4, 2017 at 1:05 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Mon, Jul 03, 2017 at 11:35:59AM -0700, Christopher Li wrote:
>
> I think you meant -20170703 here, not -20170603.

Right.

>
> On the mailing list, can you please send the patches inlined,
> as, for review, attachements are kinda useless.

Will do.

>
> In patch 1, in the die() message, I think you meant:
>         "created with different types"
>                ^                    ^
>
> In both patches, your signoff is supposed to contains your name.

Thanks you very much for catching that.
I correct both of them. The branch has refreshed as

https://git.kernel.org/pub/scm/devel/sparse/sparse.git/log/?h=sparse-next-20170704

Chris

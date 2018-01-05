From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 1/2] give a type to builtin functions
Date: Sat, 6 Jan 2018 01:21:36 +0800
Message-ID: <CANeU7QmFF3EWzWX6zQ-PW1SzdFguA9pAm8v9pdX_mg6LKgTj6w@mail.gmail.com>
References: <20180101225817.3cb135dc04ea0195f28d8512@redchan.it>
 <20180102151116.22060-1-luc.vanoostenryck@gmail.com> <20180102151116.22060-2-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yb0-f170.google.com ([209.85.213.170]:37590 "EHLO
        mail-yb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752162AbeAERVh (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 5 Jan 2018 12:21:37 -0500
Received: by mail-yb0-f170.google.com with SMTP id 5so2115759ybp.4
        for <linux-sparse@vger.kernel.org>; Fri, 05 Jan 2018 09:21:37 -0800 (PST)
In-Reply-To: <20180102151116.22060-2-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, foobar <foobar@redchan.it>

On Tue, Jan 2, 2018 at 11:11 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> When creating builtin functions via init-builtins(), it shouldn't
> really be needed to give them a type because their purpose is only
> as a placeholder for the symbol->op->{evaluate,expand,..}. Also,
> they should be part of the builtin_scope and never be visible.
>
> However, currently the global scope is the same as the builtin_scope
> and these symbols are thus visible via global_scope->symbols where
> the missing type can be a problem.
>
> Fix this to giving to the builtin functions which hadn't a type
> the same phony type as the other functions had.

My casual look this seem fine to me.

Thanks for the fix.

Chris

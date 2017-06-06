From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 0/3] -Wmemcpy-max-count & friends
Date: Mon, 5 Jun 2017 18:39:26 -0700
Message-ID: <CANeU7QkUZY9mKc_sXyu8snPw2rgudCJ8sHh-m82srv1PVpLqLw@mail.gmail.com>
References: <20170603074727.66945-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:36998 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751213AbdFFBj1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 5 Jun 2017 21:39:27 -0400
Received: by mail-it0-f46.google.com with SMTP id m47so94769689iti.0
        for <linux-sparse@vger.kernel.org>; Mon, 05 Jun 2017 18:39:27 -0700 (PDT)
In-Reply-To: <20170603074727.66945-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>

On Sat, Jun 3, 2017 at 12:47 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> sparse will warn if memcpy() (and some others memcpy-like
> functions) is called with a very large static byte count.
> But this warning cannot be disabled and the limit is arbitrary
> fixed at 100000.
>
> The goal of this series is to allow to disable this warning if
> found too bothersome or to allow to configure its limit.
>
>
> Changes since v1:
> - take in account Ramsay's remarks and suggestion:
>   - fix some name mixups in the man page & commit message
>   - use a limit of 0 as being equivalent to an infinite
>     limit, effectively disabling the warning.
> - somewhat rewrote the man page for -fmemcpy-max-count
> - extend the limit's range
>
> The series can also be found on the tree:
>         git://github.com/lucvoo/sparse.git memcpy-max-count-v2

This V2 version of the series looks perfectly fine to me.

Signed-off-By: Chris Li <sparse@chrisli.org>

Chris

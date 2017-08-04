From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] fix: give a type to bad conditionnal expressions
Date: Fri, 4 Aug 2017 10:52:13 -0400
Message-ID: <CANeU7Qkny6RjKWmmy5X0gUbchBcWxEXrZ5HMvbzKEUAsdanXEw@mail.gmail.com>
References: <20170804001122.4ivc2sktypvg2w3i@ltop.local> <20170804001639.4823-1-luc.vanoostenryck@gmail.com>
 <CAExDi1SD=F=4Uyr2x5NeMn46M=c-3iMwosLUrVu-343r-u_yPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:38396 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751921AbdHDOwO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 4 Aug 2017 10:52:14 -0400
Received: by mail-pf0-f194.google.com with SMTP id h75so2085362pfh.5
        for <linux-sparse@vger.kernel.org>; Fri, 04 Aug 2017 07:52:13 -0700 (PDT)
In-Reply-To: <CAExDi1SD=F=4Uyr2x5NeMn46M=c-3iMwosLUrVu-343r-u_yPQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Aug 4, 2017 at 8:31 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Please ignore this patch as I must have forgot to recompile the last change.
> The problem is there and the solution too but bad_ctype won't solve
> the issue here.
>
> I'll send another version which will effectively solve the issue but
> I'm far from sure
> we'll want it.
>
> -- Luc
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

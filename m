From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 06/29] topasm: top-level asm is special
Date: Fri, 18 Aug 2017 11:13:37 -0400
Message-ID: <CANeU7Q=kH-PhEbJ8O-MT5yJH6PHipo6KGHQr8sAReGXgL6Y5nQ@mail.gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
 <20170816153455.97693-7-luc.vanoostenryck@gmail.com> <CANeU7QkxQJ7aWiduHT1anBAU+_rhgjwbfXi+wVjXE=ib9hW-0A@mail.gmail.com>
 <CAExDi1QdaVuJdTEh_uM9tA=UE0COH8jvM5jCigrBp2HS+4r-JQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.161.176]:33013 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750987AbdHRPNi (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 18 Aug 2017 11:13:38 -0400
Received: by mail-yw0-f176.google.com with SMTP id p68so60627181ywg.0
        for <linux-sparse@vger.kernel.org>; Fri, 18 Aug 2017 08:13:37 -0700 (PDT)
In-Reply-To: <CAExDi1QdaVuJdTEh_uM9tA=UE0COH8jvM5jCigrBp2HS+4r-JQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, Aug 17, 2017 at 3:22 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> Sure but it's currently how they must be detected.
>
> In fact (like the name may suggest) this patch is part of a series
> that better deal with top-level asm (they are not really statement!').
> For example, top-level asm must be parsed as basic asm and not
> extended asm.
>
> So yes, I totally agree, but not now.

Yes. I haven't finish looking at your series yet.  Still working on it.

Chris

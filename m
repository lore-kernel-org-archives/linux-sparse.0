From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2] ignore VOID when trying to if-convert phi-nodes
Date: Thu, 11 May 2017 23:06:46 +0200
Message-ID: <CAMHZB6E2_0nFpkYKTJtq1RQZ1yX2Uxk1987gWpGYfOdHV9mJzA@mail.gmail.com>
References: <CANeU7QmM5Rd6o8keZMHL-N2=_dKZg4iPg=M-FAYjqRpEavrj3Q@mail.gmail.com>
 <20170511204617.58622-1-luc.vanoostenryck@gmail.com> <CANeU7QmNC3LQxE5_5n1Ab1DKVpBC+0zWD6NLn6j6CQB7qR7E=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:34601 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755544AbdEKVGr (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 11 May 2017 17:06:47 -0400
Received: by mail-qk0-f177.google.com with SMTP id k74so33513855qke.1
        for <linux-sparse@vger.kernel.org>; Thu, 11 May 2017 14:06:47 -0700 (PDT)
In-Reply-To: <CANeU7QmNC3LQxE5_5n1Ab1DKVpBC+0zWD6NLn6j6CQB7qR7E=A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, May 11, 2017 at 10:57 PM, Christopher Li <sparse@chrisli.org> wrote:

>> +       return nbr - i;
>
> Here if you want to return negative value it should be i - nbr.
> Of course if you only care about return zero or not then it does
> not matter. The call in this patch does only compare to zero
> any way.

You're right, I wanted a negative number and the comment says
so. v3 is coming. Must be tired today.

Thanks for noticing this.

-- Luc

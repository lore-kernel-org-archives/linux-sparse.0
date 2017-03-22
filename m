From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Another potential issue with linearized output
Date: Wed, 22 Mar 2017 10:08:29 +0100
Message-ID: <CAExDi1TXPDBYp3YMvX=tEwUcyXmBuSGDvWDmy9tWsTwTyamsuA@mail.gmail.com>
References: <CACXZuxetXE1QQ2jK5Pc5+FQB-vN3pguUNm8FuJ5hZ23C845KKA@mail.gmail.com>
 <CACXZuxfdKn-x_-nVbLy4PGMpmVDk-_7RESOQcfPT8FLa7JDEzQ@mail.gmail.com>
 <CACXZuxc9eMUN1HVVUCTG82qMe_ZkzjhJzivdMNN_nhDzi-j3OA@mail.gmail.com> <CACXZuxfcG62TpXyrvnsfmPZFYmHHhrasXR7OxMMuEnJETn3ZgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f169.google.com ([209.85.216.169]:36546 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758945AbdCVJPQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 22 Mar 2017 05:15:16 -0400
Received: by mail-qt0-f169.google.com with SMTP id r45so149052666qte.3
        for <linux-sparse@vger.kernel.org>; Wed, 22 Mar 2017 02:15:15 -0700 (PDT)
In-Reply-To: <CACXZuxfcG62TpXyrvnsfmPZFYmHHhrasXR7OxMMuEnJETn3ZgQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Mar 22, 2017 at 1:12 AM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> On 21 March 2017 at 22:21, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
>> I have tracked this down to the treatment of variable n2.
>
> Here is a small program that reproduces the issue:
>
> static int regc(void)
> {
>   char r00, r01, r02;
>   int s, n1, n2, j, d[2];
>   r00 = 0;
>   r01 = 1;
>   r02 = 2;
>   d[0] = &r01 - &r00;
>   d[1] = &r02 - &r01;
>
>   n1 = d[0];
>   s = 1;
>
>   for (j = 0; j < 2; j++)
>     switch (s) {
>     case 1:
>       n2 = d[j];
>       break;
>     case 2:
>       if (d[j] == n2) {
>         break;
>       }
>       s = 4;
>       break;
>     };
>   return s;
> }

Interesting case.
It seems that is closely related to the fact that there is some code paths where
n2 is undefined (not yet stored) even if these paths can't happen at execution
time (like j == 0, s == 2).
The memops/symbol simplification then wrongly simplify away the store.

I'll look for a solution.

-- Luc

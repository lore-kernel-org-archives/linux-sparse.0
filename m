From: Christopher Li <sparse@chrisli.org>
Subject: Re: [GIT PULL] debug build of sparse v4
Date: Thu, 19 Oct 2017 09:50:31 -0700
Message-ID: <CANeU7Qk8-YwH77roYfHf2++wbRY72AY5nqL8P+C7VF2JJ30J1g@mail.gmail.com>
References: <CANeU7QmUzmvhTVpiKmET76qgoZf60yxM3_URAt-auiR12trh4A@mail.gmail.com>
 <8f1174fe-6d7c-e640-d0cf-db7000658570@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:54432 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753915AbdJSQuc (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 19 Oct 2017 12:50:32 -0400
Received: by mail-yw0-f195.google.com with SMTP id w5so4053098ywg.11
        for <linux-sparse@vger.kernel.org>; Thu, 19 Oct 2017 09:50:32 -0700 (PDT)
In-Reply-To: <8f1174fe-6d7c-e640-d0cf-db7000658570@kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Jeff Layton <jlayton@redhat.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

On Thu, Oct 19, 2017 at 5:42 AM, Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.o=
rg> wrote:
>
> I wonder about the name. From a debug build (in contrast to a release
> build) I would expect that it allows to debug sparse itself (Think: add
> -g to gcc, or (not) -DNODEBUG for assert(3)), but I understand you use
> that term differently here.

The name if mechanical. You can suggest better names. I am
more focus on allowing two version of sparse can be compile
at the same time.

>
> Why not do the the extra tests when called as (say)
>
>         sparse --aggressive
>

Yes, actually that is what I have in mind. When "--aggressive"
is turn on, sparse will execute "dbg-sparse" to enable those aggressive
code path. The optional name is subject to change.

> . Then there is no need for an extra binary at all keeping the build
> system simple and that also makes it it easier to understand for users
> (but I might judge others by my own standards here?) For gcc this flag
> is -Wall, there isn't an extra binary either.

There is still need for extra binary because some verification can be
slow sparse and hard to turn off without impact the sparse performance.
For example the ptr list ref count patch. It is execute at every ptrlist
bucket iteration.

If there is no performance impact on when those verification
is turn off. Then yes, there is no need for a separate binary.
I haven't done concrete measurement of the slow down.
I just assume that there will be some.

Chris

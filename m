From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [GIT PULL] debug build of sparse v4
Date: Thu, 19 Oct 2017 21:17:15 +0200
Message-ID: <CAMHZB6GA3jGm7n6bsoZzhEz0CaiTVzhKfJ7EwnUwZBDzoTMqpQ@mail.gmail.com>
References: <CANeU7QmUzmvhTVpiKmET76qgoZf60yxM3_URAt-auiR12trh4A@mail.gmail.com>
 <8f1174fe-6d7c-e640-d0cf-db7000658570@kleine-koenig.org> <CANeU7Qk8-YwH77roYfHf2++wbRY72AY5nqL8P+C7VF2JJ30J1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f181.google.com ([209.85.217.181]:51401 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751558AbdJSTRQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 19 Oct 2017 15:17:16 -0400
Received: by mail-ua0-f181.google.com with SMTP id 47so6760248uas.8
        for <linux-sparse@vger.kernel.org>; Thu, 19 Oct 2017 12:17:15 -0700 (PDT)
In-Reply-To: <CANeU7Qk8-YwH77roYfHf2++wbRY72AY5nqL8P+C7VF2JJ30J1g@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Jeff Layton <jlayton@redhat.com>

On Thu, Oct 19, 2017 at 6:50 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Thu, Oct 19, 2017 at 5:42 AM, Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig=
.org> wrote:
>
> Yes, actually that is what I have in mind. When "--aggressive"
> is turn on, sparse will execute "dbg-sparse" to enable those aggressive
> code path. The optional name is subject to change.
>
>> . Then there is no need for an extra binary at all keeping the build
>> system simple and that also makes it it easier to understand for users
>> (but I might judge others by my own standards here?) For gcc this flag
>> is -Wall, there isn't an extra binary either.
>
> There is still need for extra binary because some verification can be
> slow sparse and hard to turn off without impact the sparse performance.
> For example the ptr list ref count patch. It is execute at every ptrlist
> bucket iteration.
>
> If there is no performance impact on when those verification
> is turn off. Then yes, there is no need for a separate binary.

The questions that really matter are:
- who will use these extra binaries?
- in which circonstances?

-- Luc

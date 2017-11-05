From: Christopher Li <sparse@chrisli.org>
Subject: Re: [GIT PULL] debug build of sparse v4
Date: Sun, 5 Nov 2017 15:27:50 +0800
Message-ID: <CANeU7QmYnrzW7nyOYXvgv9ahKN14tF5aXMd+DvRU42mXWCTWJQ@mail.gmail.com>
References: <CANeU7QmUzmvhTVpiKmET76qgoZf60yxM3_URAt-auiR12trh4A@mail.gmail.com>
 <8f1174fe-6d7c-e640-d0cf-db7000658570@kleine-koenig.org> <CANeU7Qk8-YwH77roYfHf2++wbRY72AY5nqL8P+C7VF2JJ30J1g@mail.gmail.com>
 <39fa7788-cfba-eee5-9085-41f08b42f0a8@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.161.173]:56932 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750916AbdKEH1v (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 02:27:51 -0500
Received: by mail-yw0-f173.google.com with SMTP id l32so5536549ywh.13
        for <linux-sparse@vger.kernel.org>; Sun, 05 Nov 2017 00:27:51 -0700 (PDT)
In-Reply-To: <39fa7788-cfba-eee5-9085-41f08b42f0a8@kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Jeff Layton <jlayton@redhat.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

On Sun, Oct 22, 2017 at 9:09 PM, Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.o=
rg> wrote:
> I would first implement doing everything in a single binary and only
> think about the complicated split in a "normal" and an "aggressive"
> sparse binary if the overhead is too high and people start wailing.

I think some thing like detect the ptrlist nest modify is on a hot path
does not belong to release version of sparse. I usually will not wait
until it has some performance problem.

Chris

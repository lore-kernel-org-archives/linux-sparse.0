From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 3/6] build: drop BASIC_CFLAGS and ALL_CFLAGS
Date: Wed, 1 Nov 2017 18:05:11 +0100
Message-ID: <CAExDi1TH6RuJX32wnWavx84ndwsmvwWdFG__SJeCjFPeSOMUoA@mail.gmail.com>
References: <20171004132605.24734-1-uwe@kleine-koenig.org> <20171004132605.24734-4-uwe@kleine-koenig.org>
 <CANeU7QmRzBJde5t4_tJ6pog3uAz8aP34NX6ozZnno638w_Ahug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:44726 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752395AbdKARFN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 1 Nov 2017 13:05:13 -0400
Received: by mail-io0-f194.google.com with SMTP id m16so7577382iod.1
        for <linux-sparse@vger.kernel.org>; Wed, 01 Nov 2017 10:05:12 -0700 (PDT)
In-Reply-To: <CANeU7QmRzBJde5t4_tJ6pog3uAz8aP34NX6ozZnno638w_Ahug@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Oct 6, 2017 at 9:09 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Wed, Oct 4, 2017 at 6:26 AM, Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.=
org> wrote:
>> There is no good reason to not use plain CFLAGS for all usages.
>> This simplifies understanding the Makefile for the casual reader.
>
> Have more fine grain variable allow partial overwrite some
> part of the CFLAG in some specific locations. For example
> some flags have order over other flags etc.

And having several names make possible to use the wrong name.

> I don't see a strong reason to change it. The change did not gain
> any function.

Your version of the patch has (at least) two bugs that aren't present in th=
is
version *because* this version (or mine) use the plain CFLAGS for everythin=
g.

-- Luc

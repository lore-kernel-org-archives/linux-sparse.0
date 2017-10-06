From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 3/6] build: drop BASIC_CFLAGS and ALL_CFLAGS
Date: Fri, 6 Oct 2017 12:09:23 -0700
Message-ID: <CANeU7QmRzBJde5t4_tJ6pog3uAz8aP34NX6ozZnno638w_Ahug@mail.gmail.com>
References: <20171004132605.24734-1-uwe@kleine-koenig.org> <20171004132605.24734-4-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f169.google.com ([209.85.216.169]:54710 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752545AbdJFTJY (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 6 Oct 2017 15:09:24 -0400
Received: by mail-qt0-f169.google.com with SMTP id i13so33259707qtc.11
        for <linux-sparse@vger.kernel.org>; Fri, 06 Oct 2017 12:09:24 -0700 (PDT)
In-Reply-To: <20171004132605.24734-4-uwe@kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Oct 4, 2017 at 6:26 AM, Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.or=
g> wrote:
> There is no good reason to not use plain CFLAGS for all usages.
> This simplifies understanding the Makefile for the casual reader.

Have more fine grain variable allow partial overwrite some
part of the CFLAG in some specific locations. For example
some flags have order over other flags etc.

I don't see a strong reason to change it. The change did not gain
any function.

Chris

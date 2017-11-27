From: Christopher Li <sparse@chrisli.org>
Subject: Re: function designators & function pointers
Date: Tue, 28 Nov 2017 02:23:03 +0800
Message-ID: <CANeU7QkxM7q50J4k6gz3C6OD0xv7Rp1tacZCOWjku4O2FR4J-w@mail.gmail.com>
References: <20171126215812.iswufpk3cssq2hdf@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.161.173]:33803 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753189AbdK0SXE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Nov 2017 13:23:04 -0500
Received: by mail-yw0-f173.google.com with SMTP id k191so12237924ywe.1
        for <linux-sparse@vger.kernel.org>; Mon, 27 Nov 2017 10:23:03 -0800 (PST)
In-Reply-To: <20171126215812.iswufpk3cssq2hdf@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>

On Mon, Nov 27, 2017 at 5:58 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> Currently, sparse doesn't like those 'unneeded dereferences'.
> Do we want to accept them?

I think so. It is valid C after all.

> Do we want to warn on them (because they're really weird, unneeded
> and thus maybe the sign of some errors)?

Unneeded, yes.

Warning about it. I don't feel strongly either way. I guess we
can have a warning default to off.

Chris

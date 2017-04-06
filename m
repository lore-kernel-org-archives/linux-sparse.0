From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 0/6] dump macros definitions
Date: Thu, 6 Apr 2017 01:05:47 -0700
Message-ID: <CANeU7QmfECS8w2o4M-aESz+FDU4R3ycNq0s2bzb65Zd+=XHD1g@mail.gmail.com>
References: <20170404214955.47926-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:38007 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933100AbdDFIFt (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 6 Apr 2017 04:05:49 -0400
Received: by mail-it0-f42.google.com with SMTP id y18so22000180itc.1
        for <linux-sparse@vger.kernel.org>; Thu, 06 Apr 2017 01:05:48 -0700 (PDT)
In-Reply-To: <20170404214955.47926-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Apr 4, 2017 at 2:49 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> The goal of this series is to add support for GCC's -dD.
>
> This implementation is quite straightforward:
> - record all macro's name
> - dump the tokens corresponding to each macros
>   without argument expansion.
>
> This series is available at:
>         git://github.com/lucvoo/sparse.git dump-macros
> based on commit:
>         14964df5373292af78b29529d4fc7e1a26b67a97 (sparse-next @ 2017-03-31)
> up to commit:
>         9a01ec7d42d6013ead12cb111b1a1879d0c856ab

Just a heads up this week I am very occupied, don't have much
time for sparse at all. I will resume sparse hacking in the week
end. Hopefully make some progress on sparse-next.

Sorry for the delay guys.

Chris

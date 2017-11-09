From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v2 0/7] restricted pointers
Date: Fri, 10 Nov 2017 02:55:01 +0800
Message-ID: <CANeU7Qm-QOpvhRyYsqcG4-f3-H=KS0bMH2B43wE_H1YHt=hGiA@mail.gmail.com>
References: <20171108210613.14252-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f180.google.com ([209.85.161.180]:44688 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752790AbdKISzC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Nov 2017 13:55:02 -0500
Received: by mail-yw0-f180.google.com with SMTP id k11so6189350ywh.1
        for <linux-sparse@vger.kernel.org>; Thu, 09 Nov 2017 10:55:02 -0800 (PST)
In-Reply-To: <20171108210613.14252-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Nov 9, 2017 at 5:06 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> The goal of this series is to prepare for a real support
> for C99's 'restrict' type qualifier.
> As preliminary steps this series also contains a
> cleanup of the #define MOD_XYZ and as bonus it teaches
> sparse about C11's '_Atomic' as type *qualifier*
>
> Change since v1:
> - remove patches related to error vs. warnings which
>   have already been integrated.
> - improve commit messages
>
> This series is available for review & testing at:
>         git://github.com/lucvoo/sparse.git restricted-pointers-v2

Thanks for the series.

I very briefly go over the series. Nothing particularly bad stand out.
I don't have the chance to do the normal process of apply each
patch individually. Will go back to it at more detail
level after catch up with the backlogs.

Chris

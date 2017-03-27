From: Christopher Li <sparse@chrisli.org>
Subject: Re: extra 'make check' failures on 32bit Linux
Date: Mon, 27 Mar 2017 00:51:05 -0700
Message-ID: <CANeU7Qk+Qk0LNFM+_X24eEC6A9wvLt7FxWTPK0eoS3TObbap6g@mail.gmail.com>
References: <806988fb-6e3c-872b-d7ab-282336f67f73@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:38027 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751564AbdC0Hvb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 03:51:31 -0400
Received: by mail-it0-f48.google.com with SMTP id y18so43613604itc.1
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 00:51:25 -0700 (PDT)
In-Reply-To: <806988fb-6e3c-872b-d7ab-282336f67f73@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Sun, Mar 26, 2017 at 3:21 PM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
> Hi Christopher, Luc,
>
> On occasion I build sparse on 32-bit Linux and I have noticed, for some
> weeks now, unexpected test failures. I have been meaning to take a look
> at fixing these failures, but I just haven't had the time ... :(

Thanks for the report. I haven't test sparse on 32 bit platform.
It seems some byte code test case assuming the result from 64 bit platform.

Chris

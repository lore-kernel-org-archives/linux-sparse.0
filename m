From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 5/5] ignore whole-range overlapping initializer
Date: Mon, 27 Feb 2017 22:38:10 +0100
Message-ID: <CAExDi1RXUp6veajoGvBWhP_8LruamcPsuYO1Spx+8XgvHPLucw@mail.gmail.com>
References: <20170221110355.GD300@arm.com> <20170222153006.3035-1-luc.vanoostenryck@gmail.com>
 <20170222153006.3035-6-luc.vanoostenryck@gmail.com> <CANeU7QnMB+0-BQmrTar02p5pEtG9TL2ADzqqY3WDrRkJKW57FQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:35930 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751548AbdB0WFp (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Feb 2017 17:05:45 -0500
Received: by mail-qk0-f193.google.com with SMTP id r90so20380024qki.3
        for <linux-sparse@vger.kernel.org>; Mon, 27 Feb 2017 14:04:29 -0800 (PST)
In-Reply-To: <CANeU7QnMB+0-BQmrTar02p5pEtG9TL2ADzqqY3WDrRkJKW57FQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Stephen Boyd <stephen.boyd@linaro.org>, Will Deacon <will.deacon@arm.com>

>> +               if (!a && !Woverride_init_whole_range) {
>> +                       // If first entry is the whole range, do not let
>> +                       // any warning about it (this allow to initialize
>> +                       // an array with some default value and then override
>> +                       // some specific entries).
>
> You might want to use some C style multi line comment /* ... */
> Using // for multiple line is a bit strange.
>
> Applied to sparse-next, but if you have update version I will
> apply that as well.

Yes, I tend to always use the C++ style because I'm a lazy typer :)

I'll change it since I've others changes for this serie.

Luc

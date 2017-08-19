From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 00/29] Simple & Efficient SSA construction.
Date: Fri, 18 Aug 2017 22:08:16 -0400
Message-ID: <CANeU7QnWMAVuv2WynS5VOo+hDmoCT0qm87r73QvTmmv92ngUzQ@mail.gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
 <CANeU7Q=+Jeuz41pDMVwqDNoCVj8C8bk=nx6+LY8uXcdP5pRiPw@mail.gmail.com>
 <20170817051607.7tydij5q4zny3zxo@ltop.local> <CANeU7Qn1FN3YfQ5fh3qgHqY3xDL=TKFgS9-F2OD2Qt5iSA9BXQ@mail.gmail.com>
 <CAExDi1TbBManpQHZ8+RXD0GnAtGeM8GJWtmPmUw7ig-Wfxm38w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f181.google.com ([209.85.161.181]:34431 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbdHSCIS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 18 Aug 2017 22:08:18 -0400
Received: by mail-yw0-f181.google.com with SMTP id s143so68157135ywg.1
        for <linux-sparse@vger.kernel.org>; Fri, 18 Aug 2017 19:08:18 -0700 (PDT)
In-Reply-To: <CAExDi1TbBManpQHZ8+RXD0GnAtGeM8GJWtmPmUw7ig-Wfxm38w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, Aug 17, 2017 at 4:04 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> Interesting and strange.
> This doesn't really correspond to the numbers I have here.
> Not at all, in fact, but I have only some rough measurements.
>
Just let me know if you need to get more number.
My new server is itchy to compile stuff :-)

The good thing about this server is that it does not do
CPU frequency scale due to CPU over heating.
So the number is very consistent.

I can kind of see why your patch is slightly slow
now. It allocate more phi nodes and remove them later.
Also there is the overhead of the ptrmap. Both of
those cause extra memory allocation, as we learn in the
ptrlist node size case, it can slow things down a bit.


Chris

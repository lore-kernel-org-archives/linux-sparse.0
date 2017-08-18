From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 22/29] sssa: add seal_gotos() needed to seal BBs targeted
 by gotos
Date: Fri, 18 Aug 2017 23:46:10 +0200
Message-ID: <CAExDi1TP8G18mjmTyseH4yO_6iNVDUanvTOydaP+ZyU-=18=XA@mail.gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
 <20170816153455.97693-23-luc.vanoostenryck@gmail.com> <CANeU7Q=ZKeodQSv9AJd=Je-9+WMNn0yaNMzSciKQ5Rkb7ogjZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:35131 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751807AbdHRVqL (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 18 Aug 2017 17:46:11 -0400
Received: by mail-oi0-f43.google.com with SMTP id e124so109486003oig.2
        for <linux-sparse@vger.kernel.org>; Fri, 18 Aug 2017 14:46:11 -0700 (PDT)
In-Reply-To: <CANeU7Q=ZKeodQSv9AJd=Je-9+WMNn0yaNMzSciKQ5Rkb7ogjZw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Fri, Aug 18, 2017 at 11:26 PM, Christopher Li <sparse@chrisli.org> wrote:

> I think if you want bb->needs and bb->define to zero.
> Best directly assign bb->needs && bb->defines to zero;
>
> I am not sure C stander how to deal with the unused bit field
> parts. If I recall correctly a lot of bit-field related stuff are implementation
> define. So setting bb->sealed and bb->unsealable might not be enough
> to make bb->needs zero.

You're right.
I'm planning to move them away anyway with .nr & a new field.

-- Luc

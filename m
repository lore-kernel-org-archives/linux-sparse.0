From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Sparse 0.5.1 RC5 released.
Date: Mon, 14 Aug 2017 18:15:25 +0200
Message-ID: <CAExDi1Qh_T89GkTAXtS9ZXiAk9J0Y-b7ohwCjg=K3FPX4qjQOw@mail.gmail.com>
References: <CANeU7Qkr5CPe2uEHx3-gR+dPc5C9_kKYCB=AHVLrPw+JXZ8=yw@mail.gmail.com>
 <CACXZuxeoO0Udx41Qk4JJjM9fXTa4ta2X-yAyKsY+1SkOrxQE-A@mail.gmail.com>
 <CANeU7QmkJjxr_AmBTrDhVz6VP3oZcs-8xAL3kXegrWozqkvZGA@mail.gmail.com>
 <CACXZuxfaPNCWx1+Oy08ZqfRY+eNtZ5rWpLjyHaXnK3kuvur3LQ@mail.gmail.com>
 <CAExDi1R1mQvth6OcWBZP-ur_xLfPztfaAtZWW0U8Sz=QSuW1Rw@mail.gmail.com> <CACXZuxfitdon6pOKxwNH2uSv2CR_-4UxzfbgsJx0TqwkP=VgPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:36467 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752199AbdHNQP1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 14 Aug 2017 12:15:27 -0400
Received: by mail-oi0-f42.google.com with SMTP id g131so88258273oic.3
        for <linux-sparse@vger.kernel.org>; Mon, 14 Aug 2017 09:15:26 -0700 (PDT)
In-Reply-To: <CACXZuxfitdon6pOKxwNH2uSv2CR_-4UxzfbgsJx0TqwkP=VgPA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Lance Richardson <lrichard@redhat.com>, Michael Stefaniuc <mstefani@mykolab.com>

On Sun, Aug 13, 2017 at 10:20 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>> Care to send some examples you have problems with?
>
> Sure - you already know this one:
>
> https://github.com/dibyendumajumdar/dmr_c/blob/master/tests/bugs/simplifybug.c
>
> https://github.com/dibyendumajumdar/dmr_c/blob/master/tests/minilua/minilua.c
>

OK, I just checked on the paranoia.c and once the global initializations
are removed sparse-llvm has not more problems when using all the
needed fixes. An updated tree can be found as usual at:
        git://github.com/lucvoo/sparse.git sssa-next

-- Luc

From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 1/5] do not corrupt ptrlist while killing unreachable BBs
Date: Fri, 7 Jul 2017 12:00:06 +0200
Message-ID: <CAExDi1R97m1WE_USjYr-fdXWdLEVxoq0ZUDYdt0tGQ9uU9w1iQ@mail.gmail.com>
References: <20170706191950.81268-1-luc.vanoostenryck@gmail.com>
 <20170706191950.81268-2-luc.vanoostenryck@gmail.com> <CANeU7QnbwqVcZdbarrj4OdpR9-TaG9=t5Q_CDFZXSuB+SN8zLw@mail.gmail.com>
 <CANeU7QnVNE38ODJ+cgUzD3Vz4XKogk-RL2v6-dS2aX9Oc4_0uQ@mail.gmail.com>
 <20170707054459.pkhqnmrz7yt3sppc@ltop.local> <CANeU7Q=6MZSn2Lm_+xhqrR1mU95Fq-j6oox8jEYqW+zW=UYTEA@mail.gmail.com>
 <CACXZuxfoPyT65p46wZBN8=FMEgTwCeh3Y2P3Rc5KbYO39OK_xg@mail.gmail.com>
 <CANeU7QnVC=8tf2USfVf0hQex-uBpjWHXarQ44sUUtnVKg-jy_A@mail.gmail.com> <CACXZuxd+uEx0yy=3fUjUPeJny56jR2M2w1H43=CQ3Gfm4iNqmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f175.google.com ([209.85.216.175]:33057 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbdGGKAM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 06:00:12 -0400
Received: by mail-qt0-f175.google.com with SMTP id r30so22994452qtc.0
        for <linux-sparse@vger.kernel.org>; Fri, 07 Jul 2017 03:00:12 -0700 (PDT)
In-Reply-To: <CACXZuxd+uEx0yy=3fUjUPeJny56jR2M2w1H43=CQ3Gfm4iNqmw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Jul 7, 2017 at 11:46 AM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> I am using this without problems in dmr_C so not sure I understand why
> it did not work.

It may be related to the amount of testing.
The problem we have here is not exactly frequent, on the contrary.
I have tested sparse in all sort of conditions, during hours with a lot of
code, normal and less normal, without any problems.
It's only after I did some fuzzing that I got these, and I only had a few tens
of crashes after more than 150 hours of fuzzing and more than 600GB
of generated code (which was then sometimes purposely corrupted).

-- Luc

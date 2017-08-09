From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Best way to inspect the parse tree from Sparse
Date: Wed, 9 Aug 2017 12:46:15 -0700
Message-ID: <CACXZuxddPW-gr+eRLqVTyJmKhVKAB2xEkzEfBbmLKHGK4h_twg@mail.gmail.com>
References: <CACXZuxdB3HKmTvh8Xa41OD+3-R4_Hx5g8OqS_D6H093Etb0y2Q@mail.gmail.com>
 <20170807184653.a6xtjfbutnsnecnf@ltop.local> <CANeU7Qm3JuMq_0OMiNxgcLKMkO8rhLNcWF3yeXqORZPpbvLUmg@mail.gmail.com>
 <CACXZuxeTzEGNME0WV8S9Gbe-Vbu--pq6XF4sH4YEKPD_gysiNA@mail.gmail.com>
 <CACXZuxfrgT1Q9X5B7iw=+zYA7bO4uchBo8txqsqnBw-xf+2C_A@mail.gmail.com>
 <CANeU7QmpT1-zEXmxtesaicD+W_dwMMxODno7og+5C6tuBFimpQ@mail.gmail.com>
 <CACXZuxcWQBtjH=szWHOzjU9D1+t3E+Bd-2XK=+e_Fx9rO29jvg@mail.gmail.com> <CANeU7Qk37J8WTVmzDhzjCbpmJ6cf59LNB6sX6ncRFHP=wvJFQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f171.google.com ([209.85.217.171]:33466 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753049AbdHITqR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 9 Aug 2017 15:46:17 -0400
Received: by mail-ua0-f171.google.com with SMTP id 80so32912709uas.0
        for <linux-sparse@vger.kernel.org>; Wed, 09 Aug 2017 12:46:16 -0700 (PDT)
In-Reply-To: <CANeU7Qk37J8WTVmzDhzjCbpmJ6cf59LNB6sX6ncRFHP=wvJFQw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Chris,

I am getting a different crash after making the change:

Starting program: /home/dylan/github/linux-sparse/test-inspect parse.c
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
[New Thread 0x7fffede40700 (LWP 19684)]
[New Thread 0x7fffed63f700 (LWP 19685)]
[New Thread 0x7fffece3e700 (LWP 19686)]

Thread 1 "test-inspect" received signal SIGSEGV, Segmentation fault.
0x00007ffff6ed963b in __GI__IO_default_xsputn (f=0x7fffff7ff590,
    data=0x42aaf3, n=16) at genops.c:422
422    genops.c: No such file or directory.

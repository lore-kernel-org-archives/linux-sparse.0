From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Best way to inspect the parse tree from Sparse
Date: Wed, 9 Aug 2017 11:47:57 -0700
Message-ID: <CACXZuxcWQBtjH=szWHOzjU9D1+t3E+Bd-2XK=+e_Fx9rO29jvg@mail.gmail.com>
References: <CACXZuxdB3HKmTvh8Xa41OD+3-R4_Hx5g8OqS_D6H093Etb0y2Q@mail.gmail.com>
 <20170807184653.a6xtjfbutnsnecnf@ltop.local> <CANeU7Qm3JuMq_0OMiNxgcLKMkO8rhLNcWF3yeXqORZPpbvLUmg@mail.gmail.com>
 <CACXZuxeTzEGNME0WV8S9Gbe-Vbu--pq6XF4sH4YEKPD_gysiNA@mail.gmail.com>
 <CACXZuxfrgT1Q9X5B7iw=+zYA7bO4uchBo8txqsqnBw-xf+2C_A@mail.gmail.com> <CANeU7QmpT1-zEXmxtesaicD+W_dwMMxODno7og+5C6tuBFimpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f172.google.com ([209.85.217.172]:34260 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750873AbdHISr6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 9 Aug 2017 14:47:58 -0400
Received: by mail-ua0-f172.google.com with SMTP id q25so32288369uah.1
        for <linux-sparse@vger.kernel.org>; Wed, 09 Aug 2017 11:47:58 -0700 (PDT)
In-Reply-To: <CANeU7QmpT1-zEXmxtesaicD+W_dwMMxODno7og+5C6tuBFimpQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Chris,

Yes I do have libgtk-2.0-dev installed as otherwise it would not build.

On 9 August 2017 at 19:41, Christopher Li <sparse@chrisli.org> wrote:
> You can also do a gdb on the test-inspect and report back what
> back trace do you get. My wild guess is that, it is got some incomparable
> library or some thing.
>

Here is the back trace from gdb:

Starting program: /home/dylan/github/linux-sparse/test-inspect parse.c
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
[New Thread 0x7fffede40700 (LWP 19249)]
[New Thread 0x7fffed63f700 (LWP 19250)]
[New Thread 0x7fffece3e700 (LWP 19251)]

Thread 1 "test-inspect" received signal SIGSEGV, Segmentation fault.
ast_iter_n_children (tree_model=0x725400, iter=0x0) at ast-model.c:404
404        AstNode  *node = iter->user_data;

Regards
Dibyendu

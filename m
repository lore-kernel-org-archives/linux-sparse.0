From: Christopher Li <sparse@chrisli.org>
Subject: Re: Best way to inspect the parse tree from Sparse
Date: Wed, 9 Aug 2017 14:41:02 -0400
Message-ID: <CANeU7QmpT1-zEXmxtesaicD+W_dwMMxODno7og+5C6tuBFimpQ@mail.gmail.com>
References: <CACXZuxdB3HKmTvh8Xa41OD+3-R4_Hx5g8OqS_D6H093Etb0y2Q@mail.gmail.com>
 <20170807184653.a6xtjfbutnsnecnf@ltop.local> <CANeU7Qm3JuMq_0OMiNxgcLKMkO8rhLNcWF3yeXqORZPpbvLUmg@mail.gmail.com>
 <CACXZuxeTzEGNME0WV8S9Gbe-Vbu--pq6XF4sH4YEKPD_gysiNA@mail.gmail.com> <CACXZuxfrgT1Q9X5B7iw=+zYA7bO4uchBo8txqsqnBw-xf+2C_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36496 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751602AbdHISlD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 9 Aug 2017 14:41:03 -0400
Received: by mail-pf0-f182.google.com with SMTP id c28so31206282pfe.3
        for <linux-sparse@vger.kernel.org>; Wed, 09 Aug 2017 11:41:03 -0700 (PDT)
In-Reply-To: <CACXZuxfrgT1Q9X5B7iw=+zYA7bO4uchBo8txqsqnBw-xf+2C_A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Aug 9, 2017 at 1:42 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> I built the latest version (master branch) - and tried to run it. It
> immediately crashes with core dump as soon as I click on anything.

Hmm, works for me on Fedora 26.

Do you have gtk2-devel installed? In Ubuntu it should be libgtk2.0-dev.
Did you give it a C file to parse. e.g. ./test-inspect parse.c

You can also do a gdb on the test-inspect and report back what
back trace do you get. My wild guess is that, it is got some incomparable
library or some thing.

Too bad it is not working for you, otherwise it should be the better one
that show the AST tree nodes.

Chris

From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Interesting (?) failure case
Date: Wed, 8 Apr 2020 21:02:59 -0700
Message-ID: <CAHk-=wg=Fs=EecQCNNzofn8+QXuB-sYy9m+YVPAmzDesmqFsbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf1-f51.google.com ([209.85.167.51]:32867 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725271AbgDIEDU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Apr 2020 00:03:20 -0400
Received: by mail-lf1-f51.google.com with SMTP id h6so6886834lfc.0
        for <linux-sparse@vger.kernel.org>; Wed, 08 Apr 2020 21:03:18 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id k16sm14583443ljk.64.2020.04.08.21.03.15
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2020 21:03:15 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id b1so10013736ljp.3
        for <linux-sparse@vger.kernel.org>; Wed, 08 Apr 2020 21:03:15 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

Try linearizing this with 'sparse', and see it fail miserably:

   int t(void)
   {
        goto inside;
        return 0 ?
                 ({ inside: return 3; 1; })
                :
                 2;
   }

I came up with that disgusting example after talking to Nick
Desaulniers about how sparse does some front-end optimizations early,
and it made me go "Hmm... What about.."

There are two reasonable approaches for the above:

 - return 3 (due to the "goto inside")

 - tell the user to pound sand for doing crazy things and jumping into
a statement expression from outside.

clang does #1. gcc does #2.

sparse does something bad, and just generates garbage silently.

             Linus

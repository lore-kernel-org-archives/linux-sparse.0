From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Sparse 0.5.1 RC5 released.
Date: Sun, 13 Aug 2017 18:40:07 +0200
Message-ID: <CAMHZB6G5jG+HzOZOvbdJ6e125RTB5o58mGvecnE4BCvDxx9Abg@mail.gmail.com>
References: <CANeU7Qkr5CPe2uEHx3-gR+dPc5C9_kKYCB=AHVLrPw+JXZ8=yw@mail.gmail.com>
 <CACXZuxeoO0Udx41Qk4JJjM9fXTa4ta2X-yAyKsY+1SkOrxQE-A@mail.gmail.com>
 <CAExDi1Qaa4+km-B-KHpBJ1dH5EOnOCzyU18yP8Y67ETfgbqagA@mail.gmail.com>
 <CACXZuxeR4eWwxCA0-oNfY_zBR7VGWixVuUzQr5ydvYsMFwvB1Q@mail.gmail.com>
 <CAExDi1TftYYi=CS09_yUdMP0xni3zwq-ZJoRz3hEWgykiybLpQ@mail.gmail.com> <CAExDi1R_6W3wysxR5bNPZ5PYDhgwo+Q=tJdL1QaV9dOXwyM27w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f179.google.com ([209.85.217.179]:35763 "EHLO
        mail-ua0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751053AbdHMQkI (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 13 Aug 2017 12:40:08 -0400
Received: by mail-ua0-f179.google.com with SMTP id d29so29705801uai.2
        for <linux-sparse@vger.kernel.org>; Sun, 13 Aug 2017 09:40:08 -0700 (PDT)
In-Reply-To: <CAExDi1R_6W3wysxR5bNPZ5PYDhgwo+Q=tJdL1QaV9dOXwyM27w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Lance Richardson <lrichard@redhat.com>, Michael Stefaniuc <mstefani@mykolab.com>

Another interesting thing is that even without removing the single-store
shortcut when using test-linearize we have an "instruction buffer overflow".
In other words, an instruction (a phi-node for sure) can't be displayed
in a 4096 bytes buffer  (because it as so much phi-sources).

This is something I have already seen before when trying to understand
the origin of some quadratic behaviour I had seen.
In this case it was clearly a problem related to SSA construction which
kinda wrongly accumulated phi-sources from parents.

In the current case we have a phi-node with:
- 241 sources
- 550 VOIDs (sources that have been removed during simplification)
- its BB has a single parent (thus should never have a phi-node).

With the shortcut removed, we then have hundreds and hundreds
of phi-nodes with hundreds of sources which fully exp^lain the
excessive time needed to process them. And it's very much
something possible with the removal of the shortcut since its
goal was to avoid to create phi-nodes when possible.

So this clearly points to the problem of the SSA construction
wich not only create misplaced phi-nodes but also, in some case,
create lots of them while there was no need for them.
The shortcut was very good at hiding this.

-- Luc

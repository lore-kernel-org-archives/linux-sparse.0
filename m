From: Christopher Li <sparse@chrisli.org>
Subject: master branch for upcoming RC5
Date: Fri, 11 Aug 2017 09:49:09 -0400
Message-ID: <CANeU7QnAL0XxRHXifJunkPi1+My-vUJ84neaMPjPR+v7-UQmSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f178.google.com ([209.85.161.178]:36434 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752850AbdHKNtL (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 11 Aug 2017 09:49:11 -0400
Received: by mail-yw0-f178.google.com with SMTP id u207so22520708ywc.3
        for <linux-sparse@vger.kernel.org>; Fri, 11 Aug 2017 06:49:11 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Just let every know that I already delete all the sparse-next
branch for now.

Master is the the integration branch now, again.

I have add two documents and even the inspect gtk3 fix.

I think the master has every thing I want to have for RC5.
- the wine bug is nail down for good. Thanks Luc for the hard
   work there.
- The ptrlist delete while looping is checked and the offender
   has been change to mark delete rather than actual delete.
- The document and project ideas were added. Thanks Randy
   for correcting my horrible grammar mistakes.

We still have some clouds on the improper SSA forms, I am
confident that I have pretty good ideas what needs to be done
for them in the next release. Luc even have some patches.

Luc, I think the you have some thing to add to as the finial touch.
It is on you now.

Chris

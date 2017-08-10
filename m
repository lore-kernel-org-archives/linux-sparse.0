From: Chris Li <christ.li@gmail.com>
Subject: RFC: ptrlist insert during iteration
Date: Wed, 9 Aug 2017 23:56:48 -0400
Message-ID: <CANeU7QnyNWOLe+u+ZOKr0EGPn9_RJ7T=sPi5mMiC-UTvaqeoEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.161.173]:33094 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752176AbdHJD4t (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 9 Aug 2017 23:56:49 -0400
Received: by mail-yw0-f173.google.com with SMTP id p68so51675568ywg.0
        for <linux-sparse@vger.kernel.org>; Wed, 09 Aug 2017 20:56:49 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Dibyendu Majumdar <mobile@majumdar.org.uk>

I have give this a little bit more thought.
Find more bugs in the previous proposal.

Data structure:
occupier mask:
     indicate which ptrlist entry is valid.
insert mask:
     Indicate which ptrlist entry is new insert during current loop.

I find out for each ptr iteration. The insert mask need to restart
with fresh zero.
e.g. if the insert mask start with 00010B, and after the current
ptr iteration, the insert mask become 00110B. The loop iterator
has no way to tell if the new bit was insert before or after the
original bit.

That is the reason insert mask will need to start fresh zero
for each pointer iteration.

If there is nest loops, the inner loop will need to maintain and
merge the insert mask for the outer loop.

It need some thing similar to the ptrlist refcount to do some
save/merge on the insert mask context when iterator
enter/exit the ptrlist node.

It is pretty complicate, but do able if we really want to do it.

Chris

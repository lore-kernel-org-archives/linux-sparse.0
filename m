From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/2] be more generous with ptrlist repacking
Date: Thu, 17 Nov 2016 18:25:57 +0100
Message-ID: <20161117172559.29417-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35101 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934681AbcKQR0K (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Nov 2016 12:26:10 -0500
Received: by mail-wm0-f66.google.com with SMTP id a20so23342548wme.2
        for <linux-sparse@vger.kernel.org>; Thu, 17 Nov 2016 09:26:09 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The macros that do the ptrlist walking don't handle empty blocks.
So, when some elements are removed from a list some list rapacking
need to be done to remove the empty blocks. Failure to do this
can result in crashes or data corruption.

This series aims to improve the situation by:
- doing the repacking at the places where some elements are removed
  but no repacking where done.
- to compensate the added cost, mark ptrlists as dirty when some
  element are removed from it and only do the repacking when the list
  is marked as dirty.

Another thing that can be done would be to check the dirty bit at every
list walking but I think this should be reserved for testing/debugging.

In fact, while at first agreeing with the idea of the second patch,
I think less and less that it's the right approach.
What are we looking after here?
* Performance?
  - Will this bit save us a lot of list repacking?
* Robustness?
  - What this bit bring us? Nothing without check at each list walking.
    Is it a good idea to sprinkle some assert() on the macros?
  - I would much prefer to have something that either:
    - can do the list walking with empty blocks, or
    - never leave any empty blocks.
    and this without making the macros heavier :)


I'll try later to propose something but for now ...

Luc Van Oostenryck (2):
  add missing PACK_PTR_LIST()
  mark lists to be repacked as dirty

 cse.c      | 1 +
 evaluate.c | 1 +
 ptrlist.c  | 7 +++++++
 ptrlist.h  | 4 +++-
 4 files changed, 12 insertions(+), 1 deletion(-)

-- 

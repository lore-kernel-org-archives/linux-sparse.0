From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/2] simplify for-statement & make struct statement smaller
Date: Wed, 28 Jun 2017 22:49:16 +0200
Message-ID: <20170628204918.25853-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34127 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751554AbdF1UtX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 28 Jun 2017 16:49:23 -0400
Received: by mail-wm0-f67.google.com with SMTP id p204so8803067wmg.1
        for <linux-sparse@vger.kernel.org>; Wed, 28 Jun 2017 13:49:23 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The goal of this two patches series is to make struct statement
smaller via a slight change in how for-statement's AST is build. 

On a 64bit machine the size of the struct, which was 80, is now
a round 64 bytes, 20% thus (but admittingly, the effect on the
total memory is quite small since statements represent less than
2% of the total memory used).

Note: this series is part of a larger effort to decrease the amount
      of memory used by sparse.


Luc Van Oostenryck (2):
  avoid some struct symbol member for for-statements
  make for-loop statement simpler

 ast-inspect.c  |  2 --
 compile-i386.c |  3 ---
 dissect.c      |  2 --
 evaluate.c     |  2 --
 expand.c       |  1 -
 inline.c       |  3 ---
 linearize.c    |  8 --------
 parse.c        | 30 +++++++++++++++++++++++-------
 parse.h        |  2 --
 show-parse.c   |  3 ---
 10 files changed, 23 insertions(+), 33 deletions(-)

-- 
2.13.0

      statements:   125292,   10023360,   10059776,  99.64%,    80.00
           total:  5725865,  563383738,  566362112,  99.47%,    98.39

      statements:   126693,    8108352,    8126464,  99.78%,    64.00
           total:  5891718,  430096434,  431620096,  99.65%,    73.00




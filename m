From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC 00/34] ptrlist rework with iterator
Date: Fri,  7 Jul 2017 15:39:28 +0200
Message-ID: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:32926 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752746AbdGGNkQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 09:40:16 -0400
Received: by mail-lf0-f68.google.com with SMTP id t72so4027379lff.0
        for <linux-sparse@vger.kernel.org>; Fri, 07 Jul 2017 06:40:10 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Here is some patches reworking the whole ptrlist API
which move all the logic currently present in the macros
in a small set of primitive functions using an iterator
structure.

It's in the state I left it in November.
It's OK for the testsuite and IIRC was fine when using
on the kernel too.
I didn't saw any appreciable speed change when using it.

By no means will this solve our current problem with the
nested list walking but it is, IMO, a much cleaner base
to work on.


Luc Van Oostenryck (34):
  ptrlist: simplify DO_FOR_EACH/DO_END_FOR_EACH
  ptrlist: simplify DO_FOR_EACH_REVERSE/...
  ptrlist: simplify DO_NEXT link walking
  ptrlist: add helper __PTR_STRIP_TAG()
  ptrlist: introduce the ptr_list iterator structure
  ptrlist: add ptr_cur_entry() to get iterator's current entry
  ptrlist: add forward iterator
  ptrlist: let first_ptr_list() use the iterator API
  ptrlist: add backward iterator
  ptrlist: let lastst_ptr_list() use the iterator API
  ptrlist: mechanically replace head-list-nr triplets by an iterator struct
  ptrlist: simplify initialization of DO_REVERSE()'s cursor
  ptrlist: abstract away iterator initialization
  ptrlist: CUR_ENTRY/CUR_ENTRY_NOTAG
  ptrlist: use iterator API for PREPARE/NEXT_PTR_LIST()
  ptrlist: use iterator API for RESET_PTR_LIST()
  ptrlist: use iterator for FOR_EACH_PTR()
  ptrlist: use iterator for FOR_EACH_PTR_REVERSE()
  ptrlist: remove unneeded DO_INIT()
  ptrlist: use the iterator API for DO_INSERT_CURRENT()
  ptrlist: extract ptr_cur_insert from ptrlist.h
  ptrlist: simplify ptr_cur_insert()
  ptrlist: use the iterator API for DO_DELETE_CURRENT()
  ptrlist: extract prt_cur_delete() from ptrlist.h
  ptrlist: let delete_ptr_list() use the iterator API
  ptrlist: let replace_ptr_list_entry() use the iterator API
  ptrlist: let concat_ptr_list() use the iterator API
  ptrlist: let undo_ptr_list_last() use the iterator API
  ptrlist: let delete_ptr_list_last() use the iterator API
  ptrlist: simplify common case for __add_ptr_list()
  ptrlist: explicitely tagged
  ptrlist: tag/notag common case
  ptrlist: drop the now unneeded _NOTAG versions
  ptrlist: addr vs entry

 c2xml.c          |   4 +-
 compile.c        |   4 +-
 ctags.c          |   4 +-
 example.c        |  20 ++--
 graph.c          |   8 +-
 obfuscate.c      |   4 +-
 ptrlist.c        | 217 ++++++++++++++++++++++++++++++++---------
 ptrlist.h        | 286 ++++++++++++++++++++++---------------------------------
 sparse-llvm.c    |   4 +-
 sparse.c         |   4 +-
 test-dissect.c   |   4 +-
 test-inspect.c   |   4 +-
 test-lexing.c    |   4 +-
 test-linearize.c |   4 +-
 test-parsing.c   |   4 +-
 test-unssa.c     |   4 +-
 16 files changed, 323 insertions(+), 256 deletions(-)

-- 
2.13.0


From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/3] add real support for __BASE_FILE__
Date: Wed,  5 Apr 2017 03:14:52 +0200
Message-ID: <20170405011455.60222-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35478 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754192AbdDEBRE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 4 Apr 2017 21:17:04 -0400
Received: by mail-wm0-f67.google.com with SMTP id z133so185685wmb.2
        for <linux-sparse@vger.kernel.org>; Tue, 04 Apr 2017 18:17:03 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

These 3 patches add real support for __BASE_FILE__
as until now its expansion just returned the fixed
string: "base_file.c".

This series is available at:
	git://github.com/lucvoo/sparse.git base-file
based on commit:
	14964df5373292af78b29529d4fc7e1a26b67a97 (sparse-next @ 2017-03-31)
up to commit:
	f0988518f8792a203103af01f97ccb9b568bd37d


Luc Van Oostenryck (3):
  build: add missing #include "compat.h"
  add sparse_basename()
  add real support for __BASE_FILE__

 Makefile                                |  2 ++
 compat.h                                |  1 +
 compat/basename.c                       | 16 ++++++++++++++++
 compat/mmap-blob.c                      |  1 +
 compat/strtold.c                        |  1 +
 ident-list.h                            |  1 +
 lib.c                                   |  3 ---
 pre-process.c                           |  4 ++++
 validation/preprocessor/__BASE_FILE__.c | 11 +++++++++++
 9 files changed, 37 insertions(+), 3 deletions(-)
 create mode 100644 compat/basename.c
 create mode 100644 validation/preprocessor/__BASE_FILE__.c

-- Luc Van Oostenryck
-- 
2.12.0


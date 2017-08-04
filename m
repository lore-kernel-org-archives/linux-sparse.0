From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/4] fix list corruption with recursive remove_usage()
Date: Fri,  4 Aug 2017 22:09:11 +0200
Message-ID: <20170804200915.56738-1-luc.vanoostenryck@gmail.com>
References: <CANeU7QkRWygQB_dsD4o4omB-G_xtZZVLZP4-DgaK3iDMd=HB4w@mail.gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36326 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751343AbdHDUJU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 4 Aug 2017 16:09:20 -0400
Received: by mail-wr0-f196.google.com with SMTP id y67so3637009wrb.3
        for <linux-sparse@vger.kernel.org>; Fri, 04 Aug 2017 13:09:20 -0700 (PDT)
In-Reply-To: <CANeU7QkRWygQB_dsD4o4omB-G_xtZZVLZP4-DgaK3iDMd=HB4w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The goal of this series is to avoid list corruption that may happen
with pseudo-users when deleting one while doing nested ptrlist walking.
This can occurs with mutually recursive calls:
	remove_usage() - kill_instruction() - remove_usage() - ...

Luc Van Oostenryck (4):
  ptrlist: add a counter for the number of removed elemnets
  ptrlist: adjust ptr_list_size for the new ->rm field
  ptrlist: add MARK_CURRENT_DELETED
  mark pseudo users as deleted instead of removing them

 flow.c      | 28 ++++++++++++++++++++++------
 linearize.c |  2 ++
 memops.c    |  5 ++++-
 ptrlist.c   |  2 +-
 ptrlist.h   | 11 ++++++++++-
 simplify.c  | 10 ++++++++--
 unssa.c     |  2 ++
 7 files changed, 49 insertions(+), 11 deletions(-)

-- 
2.13.2

